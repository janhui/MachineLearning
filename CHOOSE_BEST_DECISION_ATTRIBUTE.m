function [ attribute ] = CHOOSE_BEST_DECISION_ATTRIBUTE( examples, attributes, binary_targets )
%CHOOSE_BEST_DECISION_ATTRIBUTE Summary of this function goes here
%   Choose the attribute that results in the highest informatino gain.

p0 = 0; %The number of positive examples for the subset for which the attrivute has the value 0
n0 = 0; %The number of the negative examples for this subset
p1 = 0; %The number of positive examples for the subset for which the attrivute has the value 1
n1 = 0; %The number of the negative examples for this subset
gain = zeros(1,length(attributes));

    function [ entropy ] = calc_entropy ( p, n )
        entropy = -(p/(p+n))*log2((p/(p+n))+eps) - (n/(p+n))*log2((n/(p+n))+eps);
    end

    function [ remainder ] = calc_remainder (p0, n0, p1, n1)
        attr0 = p0 + n0;
        attr1 = p1 + n1;
        total = p0 + n0 + p1 + n1;
        remainder = (attr0/total)*(calc_entropy(p0,n0)) + (attr1/total)*(calc_entropy(p1,n1));
    end

    for i = 1:length(attributes)
        for j = 1:length(binary_targets)
            if examples(j, attributes(i)) == 0
                if binary_targets(j) == 0
                    n0 = n0 + 1;
                else
                    p0 = p0 + 1;
                end
            else
                if binary_targets(j) == 0
                    n1 = n1 + 1;
                else
                    p1 = p1 + 1;
                end
            end
        end
        gain(i) = calc_entropy((p0+p1), (n0+n1)) - calc_remainder (p0, n0, p1, n1);
    end

[~,attribute] = max(gain);

end

