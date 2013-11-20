function [net] = generate_one_ANN(x,y)
% generate six single-output neural networks (one for classifying each of the 
% six emotions).

	[x2, y2] = ANNdata(x,y);


	% makes an untrained tree
	[net] = feedforwardnet([10,10],'trainlm');
    net.layers{1}.transferFcn = 'purelin';
    %Configures the input and output layers of the neural network with respect 
    %to the given set of inputs (x) and targets (y).
    
    [net] = configure(net, x2, y2);

end
