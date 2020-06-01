function [ CHR_Fitness,Best_Fitness_Index,CHR_DIS ] = Fitness(P,CHR_LEN,New_Pop,PopMax)
%   Step_1 Connections b/w Liinks are defined
%   Step_2 Distances of Paths(Chromosomes) is calculated
%   Step_3 Chromosomes Fitness based on distance is calculated
%   Step_4 Connection b/w two consecutive genes of Chromosomes is checked
%   Step_5 Chromosomes Fitness based on connection b/w consecutive genes of
%          a chromosome is calculated
%   Step_6 Overall Chromosome Fitness is Calculated
%   Step_7 Checks Indexes of Best 3 Chromosomes
%   Step_8 Output for Debugging
%.....................Step_1_Links b/w All 16 Points.......................
Link(01,01)= 01 ; Link(01,02)= 02 ; Link(01,03)= 04 ; Link(01,04)= 05 ;
Link(02,01)= 02 ; Link(02,02)= 03 ; % Link(02,03)= 01 ;
Link(03,01)= 03 ; Link(03,02)= 06 ; Link(03,03)= 12 ; % Link(03,04)= 02 ;
Link(04,01)= 04 ; Link(04,02)= 07 ; Link(04,03)= 09 ; % Link(04,04)= 01 ;
Link(05,01)= 05 ; Link(05,02)= 06 ; Link(05,03)= 07 ; % Link(05,04)= 01 ;
Link(06,01)= 06 ; Link(06,02)= 05 ; Link(06,03)= 11 ; % Link(06,04)= 03 ;
Link(07,01)= 07 ; Link(07,02)= 08 ; % Link(07,03)= 04 ; Link(07,04)= 05 ;
Link(08,01)= 08 ; Link(08,02)= 10 ; Link(08,03)= 14 ; % ; Link(08,04)= 07 ;
Link(09,01)= 09 ; Link(09,02)= 14 ; % Link(09,03)= 04 ;
Link(10,01)= 10 ; Link(10,02)= 11 ; Link(10,03)= 16 ; % Link(10,04)= 08 ;
Link(11,01)= 11 ; Link(11,02)= 10 ; Link(11,03)= 12 ; % Link(11,04)= 06 ;
Link(12,01)= 12 ; Link(12,02)= 13 ; % Link(12,03)= 03 ; Link(12,04)= 11 ;
Link(13,01)= 13 ; Link(13,02)= 16 ; % Link(13,03)= 12 ;
Link(14,01)= 14 ; Link(14,02)= 15 ; Link(14,03)= 16 ; % Link(14,04)= 08 ; Link(14,05)= 09 ;
Link(15,01)= 15 ; Link(15,02)= 16 ; % Link(15,03)= 14 ;
Link(16,01)= 16 ; % Link(16,02)= 10 ; Link(16,03)= 13 ; Link(16,04)= 14 ; Link(16,05)= 15 ;
%...................Step_2_Chromosome Total Distance.......................
%............Step_3_Chromosome Fitness Based on Total Distance.............
for i=1:PopMax
    for j=1:(CHR_LEN-1)
        Calculating_CHR_DIS(i,j)  = abs(sqrt(((P(New_Pop(i,j+1),1)-P(New_Pop(i,j),1))^2)+((P(New_Pop(i,j+1),2)-P(New_Pop(i,j),2))^2)));
    end
    CHR_DIS(i,1) = sum(Calculating_CHR_DIS(i,:));
    CHR_DIS_Fitness(i,1) = 1/CHR_DIS(i,1);
end
%........Step_4_Connection b/w two consective Genes of a Chromosomes.......
for i=1:PopMax
    CHR_CONN(i,1) = 0;
    for j=1:(CHR_LEN-1)
        a = New_Pop(i,j);
        b = New_Pop(i,j+1);
        for k=1:4
            if Link(a,k) == b
                CHR_CONN(i,1) = CHR_CONN(i,1)+1;
            end
        end
    end
end
%............Step_5_Fitness of Chromosomes Based On Connections............
%................b/w two consective Genes of a Chromosomes.................
for i=1:PopMax
    %   CHR_CONN_Fitness(i,1) = CHR_CONN(i,1)/sum(CHR_CONN(:,1));% (Fitness of One)/Sum of Fitness of All
    CHR_CONN_Fitness(i,1) = CHR_CONN(i,1)/CHR_LEN; % Fitness of One/Chromosome Length
end
%.....................Step_6_Chromosome Final Fitness......................
for i=1:PopMax
    CHR_Fitness(i,1) = CHR_DIS_Fitness(i) + (CHR_CONN_Fitness(i));
    CHR_Fitness(i,1) = CHR_Fitness(i,1);
end
%................Step_7_Checking Index of Best 3 Chromosomes...............
[~,y1] = max(CHR_Fitness);
CHR_Fitness_temp1 = CHR_Fitness;
max(CHR_Fitness_temp1);
CHR_Fitness_temp1(CHR_Fitness_temp1==max(CHR_Fitness_temp1)) = 0;
[~,y2] = max(CHR_Fitness_temp1);
CHR_Fitness_temp2 = CHR_Fitness_temp1;
max(CHR_Fitness_temp2);
CHR_Fitness_temp2(CHR_Fitness_temp2==max(CHR_Fitness_temp2)) = 0;
[~,y3] = max(CHR_Fitness_temp2);
max(CHR_Fitness_temp2);
Best_Fitness_Index = [y1 y2 y3];
%.....................Step_8_Outputs For Debugging........................
% Link
% CHR_DIS
% CHR_CONN
% CHR_DIS_Fitness
% CHR_CONN_Fitness
% CHR_Fitness
%............................Function Ends.................................
end