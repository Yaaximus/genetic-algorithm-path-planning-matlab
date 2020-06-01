clc
clear
close all
tic
%........................Genetic Algorithm.................................
%............................Coordinates...................................
x = [1 1 3 3 5 6 6 8 10 10 10 11 13 12 14 14]; % x-coordinate
y = [7 11 14 1 8 11 4 4 1 7 11 14 12 2 3 8];   % y-coordinate
%..........................Defining Points.................................
P = [x' y'];                     % Path Points
[M,N]= size(P);                  % M is no. of rows % N is no. of columns
%.........................Different Variables.............................
PopMax         = 500;                       % No. of Paths(Chromosomes)
NCsel          = PopMax*(0.4);              % No. of Chromosome Selected
NOBS           = 7;                         % No. of Obstacles
NPTS           = M;                         % No. of Points
SP             = [x(1) y(1)];               % Start Point
EP             = [x(16) y(16)];             % End Point
NBITS          = ((log10(NPTS))/(log10(2)));% No. of Bits
CHR_LEN_BITS   = (NOBS+2)*(NBITS);          % Chrome Length in Bits
CHR_LEN        = ((NOBS+2)*NBITS)/NBITS;    % Chrome Length
Mutation_Rate  = 0.001;                     % Mutation Rate
Start_Index    = 1;                         % Start Point
End_Index      = 16;                        % End Point
Generations    = 1;                         % Number of Generations
Prev_Fit_Check = 0;                         % Variable For Saving Best Path Fitness
Stop_Criteria  = 0;                         % Variable for defining number of times Previous Fitness was equal to New Fitness
                                            % Stop_Criteria = 3 in DNA Function
%.........................Create Initial Population........................
[Initial_Population,Initial_Population_Bin,Check] = Population(PopMax,CHR_LEN,Start_Index,End_Index,P);
%.............................Calculate Fitness............................
[CHR_Fitness,Best_Fitness_Index,CHR_DIS] = Fitness(P,CHR_LEN,Initial_Population,PopMax);
%...........................Ranking & Mating Pool..........................
[Ranked_Population] = Ranking(CHR_Fitness,Initial_Population,PopMax);
%..........................Cross Over & Mutation...........................
[CrossOver_Population,Mutated_Population,Stop_Generation, Prev_Fit_Check,Stop_Criteria] = DNA(CHR_Fitness,PopMax,CHR_LEN,Mutation_Rate,Start_Index,Ranked_Population,Best_Fitness_Index,Initial_Population,Prev_Fit_Check,Stop_Criteria);
Mutated_Population;
%.......................First Generation Completed.........................
%.............................N Generation.................................
while(Stop_Generation ~=1)
%...........................Calculate Fitness..............................
    [CHR_Fitness,Best_Fitness_Index,CHR_DIS] = Fitness(P,CHR_LEN,Mutated_Population,PopMax);
%.........................Ranking & Mating Pool............................
    [Ranked_Population] = Ranking(CHR_Fitness,Mutated_Population,PopMax);
%.........................Cross Over & Mutation............................
    [CrossOver_Population,Mutated_Population,Stop_Generation, Prev_Fit_Check,Stop_Criteria] = DNA(CHR_Fitness,PopMax,CHR_LEN,Mutation_Rate,Start_Index,Ranked_Population,Best_Fitness_Index,Mutated_Population,Prev_Fit_Check,Stop_Criteria);
%............................Convergence Check.............................
    if  Stop_Generation == 1
        break;
    end
    Generations = Generations + 1;
end
%................................Outputs...................................
Initial_Population;
Ranked_Population;
CrossOver_Population;
Mutated_Population;
First_Best_Chromosome  = Mutated_Population(1,:)
Second_Best_Chromosome = Mutated_Population(2,:)
Third_Best_Chromosome  = Mutated_Population(3,:)
First_Best_Chromosome_Distance = CHR_DIS(Best_Fitness_Index(1))
No_Of_Generations_For_Result_Convergence = Generations
%................................Text File.................................
fid = fopen('GA_Output.txt','wt');
fprintf(fid,'Function has following Values:\n');
fprintf(fid,'Initial_Population:\n');
for i = 1:50
    fprintf(fid,'%g\t',Initial_Population(i,:));
    fprintf(fid,'\n');
end
fprintf(fid,'First_Best_Chromosome:\n');
fprintf(fid,'%g\t',First_Best_Chromosome);
fprintf(fid,'\n');
fprintf(fid,'Second_Best_Chromosome:\n');
fprintf(fid,'%g\t',Second_Best_Chromosome);
fprintf(fid,'\n');
fprintf(fid,'Third_Best_Chromosome:\n');
fprintf(fid,'%g\t',Third_Best_Chromosome);
fprintf(fid,'\n');
fprintf(fid,'Mutated_Population:\n');
for i = 1:50
    fprintf(fid,'%g\t',Mutated_Population(i,:));
    fprintf(fid,'\n');
end
fprintf(fid,'Final_Best_Chromosome:\n');
fprintf(fid,'%g\t',First_Best_Chromosome);
fprintf(fid,'\n');
fprintf(fid,'Final_Best_Chromosome_Distance:\n');
fprintf(fid,'%g\t',First_Best_Chromosome_Distance);
fprintf(fid,'\n');
fprintf(fid,'No_Of_Generations_For_Result_Convergence=');
fprintf(fid,'%g\t',No_Of_Generations_For_Result_Convergence);
fclose(fid);
%..................................Plot....................................
hold on
tri4 = [P(1,1) P(2,1) P(3,1) P(4,1) P(5,1) P(6,1) P(7,1) P(8,1) P(9,1) P(10,1) P(11,1) P(12,1) P(13,1) P(14,1) P(15,1) P(16,1);P(1,2) P(2,2) P(3,2) P(4,2) P(5,2) P(6,2) P(7,2) P(8,2) P(9,2) P(10,2) P(11,2) P(12,2) P(13,2) P(14,2) P(15,2) P(16,2)];
plot(tri4(1,:), tri4(2,:),'O');
tri4 = [P(First_Best_Chromosome(1,1),1) P(First_Best_Chromosome(1,2),1) P(First_Best_Chromosome(1,3),1) P(First_Best_Chromosome(1,4),1) P(First_Best_Chromosome(1,5),1) P(First_Best_Chromosome(1,6),1);P(First_Best_Chromosome(1,1),2) P(First_Best_Chromosome(1,2),2) P(First_Best_Chromosome(1,3),2) P(First_Best_Chromosome(1,4),2) P(First_Best_Chromosome(1,5),2) P(First_Best_Chromosome(1,6),2)];
plot(tri4(1,:), tri4(2,:));
xlim([0 15])
ylim([0 15])
title('Best Path')
xlabel('Distance along x-axis')
ylabel('Distance along y-axis')
hold off
toc