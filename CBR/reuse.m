function [solvedcase] = reuse(case, newcase)
	newcase.y = case.y;
	solvedcase = newcase;
end
