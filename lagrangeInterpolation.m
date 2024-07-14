function [Yq] = lagrangeInterpolation(X, Y, denoms, Xq)
% The function calculates the value of the interpolated function given by the points with
% coordinates (X, Y) at the points Xq.
% X - X coordinates of the interpolation nodes
% Y - Y coordinates of the interpolation nodes
% denoms - calculated denominators of the partial functions
% Xq - X coordinates at which to calculate the function value
% Yq - calculated function values at the points Xq
    partialFunctions = zeros(length(X), length(Xq));

    for i=1:length(X)
        Li = ones(1,length(Xq));
        for j=1:length(X)
            if (i==j)
                continue
            end
            Li = Li .* (Xq - X(j));
        end
        partialFunctions(i,:) = Li ./ denoms(i);
    end
    
    Yq = ones(1, length(Xq));
    for i=1:length(Xq)
        Yq(i) = sum(Y' .* partialFunctions(:,i)); 
    end
    
end

