function [expectedValues, expectedValuesBuiltIn] = calculateExpectedValues(midPoint, imgLayer, ...
    windowSize, numberOfPoints, numberOfFunctions)
% The function performs interpolation, returning interpolated values at X's
% of the window with size windowSize.
% The interpolated function has its domain in the vicinity of the midPoint, and its
% values come from the corresponding color layer.
% The function divides the interpolated interval into numberOfFunctions functions.
% -------------
% midPoint - reference illumination point (X, Y)
% imgLayer - color layer (R/G) of the illumination point
% windowSize - size of the window
% numberOfPoints - number of points in the reference window.
% numberOfFunctions - how many functions to divide the considered interval into
% --------
% expectedValues - function values interpolated by Lagrange's method at the points X,
% understood as the window of size windowSize rescaled to the size of the reference window
% expectedValuesBuiltIn - as above - built-in interpolation function.
    scaledIds = scaleIndices(windowSize, numberOfPoints);
    borders = createBordersForReferWin(numberOfPoints, numberOfFunctions);
    dividedWindow = divideWindowWithBorders(scaledIds, borders);
    
    offset = floor(numberOfPoints / 2); 
    pointXs = (midPoint(1)-offset):(midPoint(1)+offset);
    pointAdjacency = (imgLayer(pointXs, midPoint(2)))'; 
    
    expectedValues = [];
    for i=1:length(borders)-1
        currXs = borders(i):borders(i+1);
        denoms = calculateDenominators(currXs);
        interpResult = lagrangeInterpolation(currXs, pointAdjacency(currXs), denoms, dividedWindow{i});
        expectedValues = [expectedValues, interpResult];
    end
    expectedValuesBuiltIn = interp1(1:numberOfPoints, pointAdjacency, scaledIds, "spline");
end

