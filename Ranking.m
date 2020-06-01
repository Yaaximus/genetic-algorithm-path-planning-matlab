function [ Ranked_Population ] = Ranking( CHR_Fitness,Initial_Population,PopMax )
%   Step_1 Calculation Probabilities
%   Step_2 Calculating Cumulative Probability
%   Step_3_Ranking of Cumulative Probabilities Based on Random number b/w
%          (0 & 1)
%   Step_4 Generation of Mating Pool
%   Step_5 Output for Debugging
%....................Step_1_Calculating Probability........................
for i=1:PopMax
    CHR_Prob(i,1) = CHR_Fitness(i,1)/sum(CHR_Fitness);
end
%..............Step_2_Calculating Comulative Probability...................
CHR_Cum_Prob = cumsum(CHR_Prob);
%................Step_3_Ranking of Comulative Probabilities................
%....................Based on Random number b/w(0 & 1).....................
rand_array = rand(PopMax,1);
for i=1:PopMax
    k = 0;
    if CHR_Cum_Prob(k+1) > rand_array(i)
        k = 1;
        No_Index_N(i,1) = k;
    end
    while( CHR_Cum_Prob(k+1) < rand_array(i) )
        k = k+1;
        No_Index_N(i,1) = k;
    end
end
for i=1:PopMax
    CHR_Rank_S(i,1)= 0;
    for j=1:PopMax
        if No_Index_N(j,1) == i
            CHR_Rank_S(i,1) = CHR_Rank_S(i,1)+1;
        end
    end
end
CHR_Rank_Sum = sum(CHR_Rank_S);
%......................Step_4_Generating Mating Pool.......................
Ranked_Population = [];
for i = 1:PopMax
    for j = 1:CHR_Rank_S(i)
        if i == 1 && j == 1 && CHR_Rank_S(1)~=0
            Ranked_Population = Initial_Population(i,:);
        else
            Ranked_Population = [Ranked_Population;Initial_Population(i,:)] ;
        end
    end
end
%.....................Step_5_Outputs For Debugging........................
%  CHR_Prob
%  CHR_Cum_Prob
%  No_Index_N
%  CHR_Rank_S
%  CHR_Rank_Sum
%  Ranked_Population;
%............................Function Ends.................................
end