function [ err_rate ] = get_error_rate_stats(x, y, net)

	total_fold = 10;
	err_rate = cell(total_fold, i);
	for fold_num = 1:total_fold
		[~, err_rate{fold_num}] - cross_validation(x,y,fold_num, net)
	end

	for emotion = 1:6
		vector = zeroes(total_fold, 1);
		for i = 1:total_fold
			fold = err_rate{1};
			vector{i} = fold(emotion);
		end
	end

	for fold_num = 1:total_fold
		err_rate(fold)
	end
end
