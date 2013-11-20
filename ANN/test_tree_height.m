

function [class, height] = test_tree_height(tree, example, h)


%Recursively goes through the tree and find the predicted classification of
%the tree and the height to reach the leaf using the helper function which
%just traverse through the tree to find the h#

    if(isempty(tree.class))
        nodeValue = example(tree.op);
        leftChild = tree.kids{1};
        rightChild = tree.kids{2};

        if (nodeValue)
            [class, height] = test_tree_height(rightChild, example, h+1);
        else
            [class, height] = test_tree_height(leftChild, example, h+1);
        end
    else
        class = tree.class ;
        height = h;
    end
    
    
end


