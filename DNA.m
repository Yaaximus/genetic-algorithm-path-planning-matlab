function [CrossOver_Population,Mutated_Population,Stop_Generation,Prev_Fit_Check,Stop_Criteria] = DNA(CHR_Fitness,PopMax,CHR_LEN,Mutation_Rate,Start_Index,Ranked_Population,Best_Fitness_Index,Mutated_Population,Prev_Fit_Check,Stop_Criteria)
%   Step_1 Check For Stopping Criteria
%   Step_2 CrossOver
%   Step_3 Mutation
%   Step_4 Outputs
%...................Step_1_Check_For_Stopping_Criteria.....................
c = eq(Prev_Fit_Check,CHR_Fitness(Best_Fitness_Index(1,1)));
if c == 1
    Stop_Criteria = Stop_Criteria+1;
else
    Prev_Fit_Check = CHR_Fitness(Best_Fitness_Index(1));
    Stop_Criteria = 0;
end
%..............If Same Chromosome comes for 3 Times Consider...............
%....................that Result has been Convereged.......................
if Stop_Criteria == 3
    Stop_Generation = 1;
else
    Stop_Generation = 0;
end
%...........................Step_2_CrossOver...............................
CrossOver_Population(1,:) = Mutated_Population(Best_Fitness_Index(1),:);
CrossOver_Population(2,:) = Mutated_Population(Best_Fitness_Index(2),:);
CrossOver_Population(3,:) = Mutated_Population(Best_Fitness_Index(3),:);

for i=4:(PopMax-1)/5
    a = randi([1 PopMax]);
    b = randi([1 PopMax]);
    Partner_A = Ranked_Population(a,:);
    Partner_B = Ranked_Population(b,:);
    Mid_Point = randi([1 CHR_LEN]);
    for j=1:Mid_Point
        CrossOver_Population(i,j)   = Partner_A(1,j);
        CrossOver_Population(i+1,j) = Partner_B(1,j);
    end
    for j=(Mid_Point+1):CHR_LEN
        CrossOver_Population(i,j)   = Partner_B(1,j);
        CrossOver_Population(i+1,j) = Partner_A(1,j);
    end
end
for r= ((PopMax)/5) : PopMax-1
    CrossOver_Population = [CrossOver_Population;Ranked_Population(r,:)];
end
%...........................Step_3_Mutation................................
Mutated_Population(1,:) = CrossOver_Population(1,:);
Mutated_Population(2,:) = CrossOver_Population(2,:);
Mutated_Population(3,:) = CrossOver_Population(3,:);
for i=4:(PopMax-1)/5
    Mutated_Population(i,:) = CrossOver_Population(i,:);
end
for i= (PopMax/5):PopMax
    for j=1:(CHR_LEN-1)
        c = rand;
        if (c < Mutation_Rate && j ~= Start_Index)
            Mutated_Population(i,j) = randi([2,15]);
        else
            Mutated_Population(i,j) = CrossOver_Population(i,j);
        end
    end
end
%...........................Step_4_OutPut..................................
% Stop_Generation
% CrossOver_Population
% Mutated_Population
end