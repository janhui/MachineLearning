function [perform, classify_rate] = find_performance(net, tr, x, y)

	[x2, y2] = ANNdata(x, y);
	predictions = testANN(net, x2);
	classify_rate = (size(y, 1) - nnz(predictions - y))/size(y, 1);
	perform = tr.best_perf;
end
