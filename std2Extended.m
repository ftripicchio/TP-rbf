function [std2Result] = std2Extended(extendedMatrix)
%MEANEXTENDED Summary of this function goes here
%   Detailed explanation goes here

std2Results=[];
for i=1:3
    for j=1:3
        if (~(i==2 && j==2) && (double(mean(extendedMatrix{i,j},'all'))~= double(1)))
        std2Results=[std2Results,std2(extendedMatrix{i,j})];
        end
    end
end
if (size(std2Results) > 0) 
std2Result=std2(std2Results);
else std2Result = 1;
end
end
