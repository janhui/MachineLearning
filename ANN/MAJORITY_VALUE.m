function [ mode ] = MAJORITY_VALUE( binary_targets )
%MAJORITY_VALUE Summary of this function goes here
%   returns the mode of the binary_targets

if sum( binary_targets ) >= length( binary_targets ) / 2
    mode = 1;
else
    mode = 0;
end

end

