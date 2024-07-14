function [finalXs, finalYs] = removeRepeatedPoints(foundXs, foundYs, distanceThreshold)
% The function cleans the vectors foundXs and foundYs from points that,
% according to the Euclidean metric, are too close to each other - recognizing them as
% detections of the same point and leaving one of them.
% foundXs - X coordinates of the found points
% foundYs - Y coordinates of the found points
% distanceThreshold - distance threshold to determine points as indicating the same
% finalXs - vector of X coordinates of the cleaned points
% finalYs - vector of Y coordinates of the cleaned points
    finalXs = [];
    finalYs = [];
    for i = 1:length(foundXs)
        distance = sqrt((foundXs(i+1:end) - foundXs(i)).^2 + (foundYs(i+1:end) - foundYs(i)).^2);
    
        if ~any( distance < distanceThreshold )
            finalXs(end+1) = foundXs(i);
            finalYs(end+1) = foundYs(i);
        end
    end
end

