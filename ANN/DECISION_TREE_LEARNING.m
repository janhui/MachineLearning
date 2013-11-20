function tree = DECISION_TREE_LEARNING( examples, attributes, binary_targets )
    tree = struct;
    tree.op = [];
    tree.kids = [];
    tree.class = [];
%DECISION_TREE_LEARNING Summary of this function goes here
%   Implementation of the pseudo code for the decision tree algorithm given
%   in table 1
    
    %if all examples have the same value of binary_targets
    %then return a leaf node with this value
    if sum(binary_targets) == 0
        tree.class = 0;
        return
    elseif sum(binary_targets) == length(binary_targets)
        tree.class = 1;
        return
    %else if attributes is empty
    %then return a leaf node with value = MAJORITY-VALUE(binary_targets)
    elseif isempty(attributes)
        tree.class = MAJORITY_VALUE( binary_targets );
        return
    else
        %best_attribute <- CHOOSE-BEST-DECISION-ATTRIBUaTE(examples,attributes, binary_targets)
        best_attribute = CHOOSE_BEST_DECISION_ATTRIBUTE (examples, attributes, binary_targets );
        
        %tree <- a new decision tree with root as best_attribute as the tree
        %was originally empty we can use that with .op defined as
        %best_attributes
        tree.op = attributes(best_attribute);
        
        %define the two possible branches as there are two possible values
        %for best_attributes
        branch_examples = cell(1,2);
        branch_binary_targets = cell(1,2);
        
        %number of positive or negative examples for each attribute
        num_examples=[0,0];
        
        %initialize the branches
        for i = 1:2
            %zeros the number of examples (length of binary_targets)
            branch_binary_targets{i} = zeros(length(binary_targets));
            %zeros the number of examples X the number of attributes
            branch_examples{i} = zeros(length(binary_targets), size(examples,2));
        end
        
        %{examplesi , binary_targets i}<- {elements of examples with best_attribute = ?i and the corresponding binary_targetsi }
        %for loop to sort the examples and its binary target to the branch it belongs 
        for i = 1:length(binary_targets)
            example = examples(i,:);
            %extract value where value is whether the example is positive
            %or negative
            value = examples(i, attributes(best_attribute));
            %modify value so we can use it as index for num_example, and
            %the two branches data (example and binary_target)
            value = value + 1;
            num_examples(value) = num_examples(value) + 1;
            branch_examples{value} (num_examples(value),:) = example;
            branch_binary_targets{value}(num_examples(value)) = binary_targets(i);
        end
        
        %modify the size of examples and bts to their correct size
        for k = 1:2
            branch_examples{k} = branch_examples{k}(1:num_examples(k),:);
            branch_binary_targets{k} = branch_binary_targets{k}(1:num_examples(k));
        end
        
        attributes(best_attribute) = [];
        subtrees = cell(1,2);
        for i = 1:2
            %if examplesi is empty
            %then return a leaf node with value = MAJORITY-VALUE(binary_targets)
            subtrees{i} = struct('op',[],'kids',[],'class',[]);
            if isempty(branch_examples{i})
                tree.class = MAJORITY_VALUE( binary_targets );
                return
            %else subtree <- DECISION-TREE-LEARNING(examplesi ,attributes-{best_attribute}, binary_targetsi)
            else
                subtrees{i} = DECISION_TREE_LEARNING(branch_examples{i}, attributes, branch_binary_targets{i});
            end
            tree.kids{i} = subtrees{i};
        end
    end
    return
    
end

