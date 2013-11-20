function class = tree_traversal(tree, example)
if (isempty(tree.class))
    nodeValue = example(tree.op);
    leftChild = tree.kids{1};
    rightChild = tree.kids{2};

    if (nodeValue == 0)
        class= tree_traversal(leftChild, example);
    else
        class = tree_traversal (rightChild, example);
    end
else
    class = tree.class ;

end
end