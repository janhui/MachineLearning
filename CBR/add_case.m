function [case_struct] = add_case(case_struct, sing_case)

	for i = 1: size(case_struct.cases,2)
		if similarity_distance(sing_case,case_struct.cases(i))==0 && sing_case.y ==case_struct.cases(i).y
            case_struct.cases(i).typicality = case_struct.cases(i).typicality + 1;
            return;
        end
    end

    case_struct.cases = [case_struct.cases sing_case];
    case_struct.class_count(sing_case.y) = case_struct.class_count(sing_case.y) + 1;
    case_struct.active_count(sing_case.y, :) = case_struct.active_count(sing_case.y, :) + sing_case.x; 
end


