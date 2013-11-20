function [ tree ] = TRAIN_TREE( examples, y, emotion )
%TRAIN_TREE Summary of this function goes here
%   Train a tree by using dataset.

    %initialize the attributes and set them from 1 to 45
    attributes = zeros(1, 45);
    for i = 1:45
        attributes(i) = i;
    end
    %initialize the binary targets and set them to 1 or 0 depending on the
    %label
    binary_targets = zeros(1, length(y));
    for i = 1:length(y)
        if y(i) == emotion
            binary_targets(i) = 1;
        else
            binary_targets(i) = 0;
        end
    end
    %train the tree using decision tree learning
    tree = DECISION_TREE_LEARNING(examples, attributes, binary_targets);
end

