function [ cbr ] = retain( cbr, solvedcase, case_location )
%RETAIN Summary of this function goes here
%   updates the CBR system by storing the solved case solvedcase

    if (case_location >=0)
        cbr.cases(case_location).typicality = cbr.cases(case_location).typicality+1;
    else
        cbr.cases = [cbr.cases solvedcase];
        cbr.class_count(solvedcase.y) = cbr.class_count(solvedcase.y) + 1;
        cbr.active_count(solvedcase.y, :) = cbr.active_count(solvedcase.y, :) + solvedcase.x;
    end  
end

