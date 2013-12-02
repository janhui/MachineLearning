function [similar_case, case_loc] = similarity_mean(cbr, newcase)
	min_class =1;
	min_val = 1000;
	for emotion = 1:6
		val = sum(abs(newcase.x - cbr.mean_active(emotion,:)));
		if val <= min_val
			min_val = val;
			min_class = emotion;
		end
	end

	min_val = 1000;
	case_loc = 1;
	min_case = cbr.cases(1);
	for i = 1:length(cbr.cases)
		if cbr.cases(i).y == min_class
			val = sum(abs(newcase.x - cbr.cases(i).x));
			if val <= min_val
				min_val = val;
				min_case = cbr.cases(i);
				case_loc = i;
			end
		end
	end

	similar_case = min_case;



end