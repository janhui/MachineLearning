function [cbr] = CBRinit(x, y, similarity_func)
	if nargin ==2
		similarity_func = 'similarity_mean';
	end

	cbr = new_case_struct(similarity_func);
	for i = 1:length(y)
		single_case = new_case(x(i,:), y(i));
		cbr = add_case(cbr,single_case);
	end

	cbr = comp_weights(cbr);
	cbr = comp_mean(cbr);


end
