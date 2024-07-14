function [dividedWindow] = divideWindowWithBorders(scaledIds, borders)
% The function divides the window so that the scaled X's fall into the appropriate
% interval defined by the borders. Example:
% a scaled x=5.67 will fall into the interval interpolated by the function whose
% domain is <1,8>
% scaledIds - vector of X values scaled to the length of the reference window
% borders - boundaries defining the intervals for successive interpolation functions.
% dividedWindow - cell array containing vectors of X's belonging to
% the corresponding intervals
    dividedWindow = {};
    for i=1:length(borders)-1
        dividedWindow{end+1} = scaledIds(scaledIds >= borders(i) & scaledIds < borders(i+1));
    end
    if( ~isempty(scaledIds(scaledIds == borders(end))) )
        dividedWindow{end}(end+1) = borders(end);
    end
end

