function [sing_case] = new_case(input_vect, target_val)

	sing_case = struct('x',input_vect,'y',target_val,'typicality',1);

end