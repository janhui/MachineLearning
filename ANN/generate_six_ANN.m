function [net] = generate_six_ANN(x,y)
% generate six single-output neural networks (one for classifying each of the 
% six emotions).
    net = cell(6,1);
	[x2, y2] = ANNdata(x,y);

    for i = 1:6
        % makes an untrained tree
        [net{i}] = feedforwardnet([10,10],'trainlm');
        net{i}.layers{1}.transferFcn = 'purelin';
        %Configures the input and output layers of the neural network with respect 
        %to the given set of inputs (x) and targets (y).
        [net{i}] = configure(net{i}, x2, y2(i,:));
    end

end
