function [distance] = similarity_distance(case1, case2)
	distance = nnz(case1.x - case2.x);
end
