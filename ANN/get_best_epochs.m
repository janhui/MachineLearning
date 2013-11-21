function [epocs] = get_best_epochs(examples, target, untrained_network)


	[x2,y2] = ANNdata(x,y);
	if (size (untrained_network,1) ==1)
		untrained_network.divideParam.trainRation = 0.90;
		untrained_network.divideParam.valRatio = 0.10;
		untrained_network.trainParam.epochs = 1000;
		[~,tr] = train(untrained_network,x2,y2);
		[~,index] = min(tr.vperf);
		epocs = tr.epoc(index);
		figure, plotperform(tr)
	elseif size (untrained_network,1) == 6
		epochs = zeros(1,6)
		for i = 1:6	
			untrained_network{i}.divideParam.trainRation = 0.90;
			untrained_network{i}.divideParam.valRatio = 0.10;
			untrained_network{i}.trainParam.epochs = 1000;
			[~,tr] = train(untrained_network{i}, x2, y2(i,:));
			[~, index] = min(tr.vperf);
			epochs(i) = tr.epoch(index);
	end
end
