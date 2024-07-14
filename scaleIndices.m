function scaledIds = scaleIndices(windowSize, numberOfPoints)
% Due to the possible difference in width between the window and the reference window, 
% the function recalculates the indices of a window of size windowSize to values in the range
% 1:numberOfPoints where numberOfPoints is the number of points included in
% the reference window.
% scaledIds is a vector of X values scaled to the range
% 1:numberOfPoints.
    originalValues = 1:windowSize;
    
    minValue = min(originalValues);
    maxValue = max(originalValues);

    scaledIds = (originalValues - minValue) / (maxValue - minValue) * (numberOfPoints - 1) + 1;
end
