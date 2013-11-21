function [perform, classify_rate] = find_performance(net, tr, x, y)

	[x2, y2] = ANNdata(x, y);
	preds = test_to_opt	(net, x2);
	classify_rate = (size( y, 1) - nnz(preds - y))/size( y, 1);
	perform = tr.best_perf;
end
