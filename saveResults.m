function [] = saveResults(destination, finalXs, finalYs)
% The function saves the results to a file at the destination location
% finalXs - X coordinates of the found points
% finalYs - Y coordinates of the found points
% The save format is as follows:
% finalXs(i), finalYs(i)
    fileID = fopen(destination, 'w');
    for i = 1:length(finalXs)
        fprintf(fileID, '%g, %g\n', finalXs(i), finalYs(i));
    end
    fclose(fileID);
end

