function [anns] = generate_anns()

    trainingFcn = {'trainlm', 'traingd'};
    activationFcn = {'tansig', 'purelin'};
    neurons = [10, 100];
    hiddenLayers = [1,2];
    
    trainFcn_size = size(trainingFcn, 2);
    activationFcn_size = size(activationFcn, 2);
    neurons_size = size(neurons, 2);
    hiddenLayers_size = size(hiddenLayers, 2);
    anns_size = trainFcn_size*activationFcn_size*neurons_size*hiddenLayers_size;
    
    anns = cell(anns_size, 1);
    
    n = 0;
    for i = 1:trainFcn_size
        for j = 1:neurons_size
            for k = 1:hiddenLayers_size
                for l = 1:activationFcn_size
                    n = n + 1;
                    layers = neurons(j)*ones(1, hiddenLayers(k));
                    [net] = feedforwardnet(layers, trainingFcn(i));
                    for m = 1:hiddenLayers(k)
                        net.layers{m}.transferFcn = activationFcn(l);
                    end
                    anns{n} = net;
                end
            end
        end
    end
    
end