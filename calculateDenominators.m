function [denoms] = calculateDenominators(X)
% The function calculates the denominators from the Lagrange interpolation formula
% to reduce the number of operations performed during the actual interpolation.
% X - vector of X coordinates
% denoms - denominators of the partial functions.
    denoms = [];
    for i=1:length(X)
        Li = 1;
        for j=1:length(X)
            if(i==j)
                continue
            end
            Li = Li * ( X(i) - X(j));
        end
        denoms(end+1) = Li;
    end
end

