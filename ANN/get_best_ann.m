function [anns] = get_best_ann(x, y)

    nets = generate_anns();
    anns = cell(size(nets, 1), 3);
    performInd = ones(size(nets, 1), 1);
    for i = 1:size(nets)
        [anns{i, 1}, tr] = train_to_opt(nets{i}, x, y);
        [performInd(i), classification_rate] = find_performance(anns{i}, tr, x, y);
    end
    
    [order, id] = sort(performInd, 'descend');
    for i = 1:size(nets)
        anns{i, 2} = order(i);
        anns{i, 3} = id(i);
    end
    
end
