function [ predicted ] = testTrees(trees, examples)
%takes your trained trees (all six) T and examples and produces a 
%vector of label predictions of all the corresponding examples;
    for j = 1:size(examples, 1)
        predicted(j) = classify_emotion_height(trees,examples(j,:));
    end
    return

end



function emotion = classify_emotion_height(trees, example)

    attributes = zeros(1, length(trees));

    for i = 1:length(trees)
        [class, height] = test_tree_height(trees{i}, example, 0);
        if class
            attributes(i) = attributes(i) + 1/(height+1);
        end
    end

    [~, emotion] = max(attributes);
end

function emotion = classify_emotion_random(trees,example)
    attributes = zeros(1, length(trees));

    for i = 1: length(trees)
        class = tree_traversal(trees{i}, example);
    
        if (class ==0)
            attributes(i) = 0;
        else
            attributes(i) = 1;
        end
    end
    while 1 
        v = randi([1,6]);
        if attributes(v)
            emotion = v;
            return
        end
    end

end

