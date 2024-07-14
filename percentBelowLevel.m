function [percentBelow] = percentBelowLevel(imgLayer, rangeXs, y, colorLevel)
% The function calculates the percentage of points with a color value
% below a specified colorLevel.
% imgLayer - layer of the considered color
% rangeXs - considered set of X's
% y - considered height
% colorLevel - color content threshold
% percentBelow - percentage of points below the specified color level
    condition = imgLayer(rangeXs, y) < colorLevel;
    percentBelow = sum(condition) / length(condition);
end

