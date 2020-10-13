function [meanResult] = meanExtended(extendedMatrix)
%MEANEXTENDED Summary of this function goes here
%   Detailed explanation goes here

meanResults=[];

for i=1:3
    for j=1:3
        if (~(i==2 && j==2) && (double(mean(extendedMatrix{i,j},'all'))~= double(1)))
        meanResults=[meanResults,mean(extendedMatrix{i,j},'all')];
        end
    end
end

if (size(meanResults) > 0) 
    meanResult=mean(meanResults, 'all');
else
    meanResult = 1;
end
end

