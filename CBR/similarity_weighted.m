function [sim_weighted_dist] = similarity_weighted(cbr, case1, case2)
	class = 1;
	if not(case1.y == -1)
		class = case1.y;
	elseif not(case2.y == -1)
		class = case2.y;
	end

	sim_weighted_dist = sum(abs(case1.x - case2.x) .* cbr.class_weights(class));

end