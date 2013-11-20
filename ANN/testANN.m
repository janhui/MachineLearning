function [ predictions ] = testANN( net, x2 )


    if size(net, 1) == 1,
        [t] = sim(net, x2);        
        predictions = NNout2labels(t);
    elseif size(net, 1) == 6,
        for i=1:6,
            results(:,i) = sim(net{i}, x2);
        end
        [V, predictions] = max(results');
        predictions = predictions';
    end


end