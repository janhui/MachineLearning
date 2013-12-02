function [case_struct] = new_case_struct(sim_func)

	cases = [];
	class_weight = ones(6,45);
	mean_active = ones(6,45);

	%class_entropies = ones(6,45)

	if nargin == 0
		sim_func = 'similarity_mean';
	end

	%case_struct = struct('cases', cases, 'class_count', zeros(6,1), 'class_weights', class_weights, 'class_entropies', class_entropies, 'active_count', zeros(6, 45), 'similarity_function', similarity_function, 'mean_active', mean_active);

	case_struct = struct('cases', cases, 'class_count', zeros(6,1), 'class_weights', class_weights, 'active_count', zeros(6, 45), 'similarity_function', similarity_function, 'mean_active', mean_active);
end
