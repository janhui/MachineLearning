function [preds] = testCBR(cbr, x2)

	preds = zeros(size(x2,1),1);
	for i = 1:size(x2,1)
		newcase = new_case( x2(i,:), -1);
        [sim_case, case_location] = retrieve(cbr, newcase);
        solvedcase = reuse(sim_case, newcase);
        cbr = retain(cbr, solvedcase, case_location);
        preds(i) = solvedcase.y;
    end
end
