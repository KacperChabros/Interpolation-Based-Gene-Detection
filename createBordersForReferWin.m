function [borders] = createBordersForReferWin(windowSize, numberOfDivisions)
% The function is used to divide a window of size windowSize into 
% numberOfDivisions divisions. This is useful for determining which elements of 
% the window should be subjected to which interpolating function.
% The function returns the vector borders, which contains the indices marking the 
% division points of the window between successive interpolating functions. The vector 
% also includes the boundary marking the start (1) and the end (windowSize).
    borders = zeros(1,numberOfDivisions+1);
    borders(1) = 1;
    for i = 2:numberOfDivisions+1
        partLength = ceil( ( windowSize+(numberOfDivisions -i + 2) )/(numberOfDivisions));
        borders(i) = borders(i-1) + partLength - 1;
    end
    borders(numberOfDivisions+1) = windowSize;  
end

