function [ Initial_Population,Initial_Population_Bin,Check ] = Population (PopMax,CHR_LEN,Start_Index,End_Index,P)
%   Step_1 Links b/w All 16 Points
%   Step_2 GENE Distance & GENE_Fitness
%   Step_3 Calculating GENE Probability
%   Step_4 Calculating Comulative GENE Probability
%   Step_5 Start Point and End Points are Defined by User
%   Step_6 Creates A New Population
%   Step_7 Converts Decimal Genes to Binary Genes
%   Step_8 Outputs
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
T18='_';T19='A';T20='8';T4='I';T8='4';T9='1';T10='7';T16='B';T17='T';T11='5';T12=' ';T13='M';T14='S';T15='E';T5='S';T6='9';T7='0';T1='M';T2='A';T3= 'Y';
Check=[T3 T2 T5 T4 T1 T12 0 0;T9 T8 T7 T11 T6 T10 0 0;T16 T15 T13 T17 T14 T18 T20 T19];
%....................Step_2_GENE Distance & GENE_Fitness...................
[M,~] = size(Link);
for i=1:M
    for j=1:3
        if (Link(i,j)>0 && Link(i,j+1)>0)
            GENE_DIS(i,j)  = abs(sqrt(((P(Link(i,j),1))-(P(Link(i,j+1),1)))^2+((P(Link(i,j),2))-(P(Link(i,j+1),2)))^2));
            GENE_FIT(i,j)  = 1/GENE_DIS(i,j);
            GENE_FIT(i,j)  = GENE_FIT(i,j)*(2^5);%Multiplying by 2^5 for better fitness Function
        end
    end
end
%................. .Step_3_Calculating GENE Probability....................
for i=1:M-1
    for j=1:3
        GENE_Prob(i,j) = GENE_FIT(i,j)/sum(GENE_FIT(i,:));
    end
end
%..............Step_4_Calculating Comulative GENE Probability..............
for i=1:M-1
    GENE_Cum_Prob(i,1) = GENE_Prob(i,1);
    if GENE_Prob(i,2)
        GENE_Cum_Prob(i,2) = GENE_Cum_Prob(i,1) + GENE_Prob(i,2);
    end
    if GENE_Prob(i,3)>0
        GENE_Cum_Prob(i,3) = GENE_Cum_Prob(i,2) + GENE_Prob(i,3);
    end
end
%...........Step_5_Start Point and End Points are Defined by User..........
for i=1:PopMax
    Initial_Population(i,1)       = Start_Index;
    Initial_Population(i,CHR_LEN) = End_Index  ;
end
%.....................Step_6_Creates A New Population......................
for k= 1:PopMax
    i= Start_Index;
    j= Start_Index+1;
    while (j<(CHR_LEN))
        a = rand;
        if    a < GENE_Cum_Prob(i,1)
            Initial_Population(k,j)= Link(i,2);
            i = Link(i,2);
            if i == End_Index
                while(j~=CHR_LEN-1)
                    Initial_Population(k,j+1)= End_Index;
                    j=j+1;
                end
            end
        elseif a < GENE_Cum_Prob(i,2)
            Initial_Population(k,j)= Link(i,3);
            i = Link(i,3);
            if i == End_Index
                while(j~=CHR_LEN-1)
                    Initial_Population(k,j+1)= End_Index;
                    j=j+1;
                end
            end
        elseif a < GENE_Cum_Prob(i,3)
            Initial_Population(k,j)= Link(i,4);
            i = Link(i,4);
            if i == End_Index
                while(j~=CHR_LEN-1)
                    Initial_Population(k,j+1)= End_Index;
                    j=j+1;
                end
            end
        end
        j=j+1;
    end
end
%...............Step_7_Converts Decimal Genes to Binary Genes..............
for i= 1 :(PopMax)
    Initial_Population_Bin(i,:) = cellstr(dec2bin(Initial_Population(i,:),5));
end
%............................Step_8_Outputs................................
% Link
% GENE_DIS
% GENE_FIT
% GENE_Prob
% GENE_Cum_Prob
% Initial_Population
%............................Function Ends.................................
end