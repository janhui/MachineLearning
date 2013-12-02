function [solvedcase] = reuse(oldcase, newcase)
	newcase.y = oldcase.y;
	solvedcase = newcase;
end
