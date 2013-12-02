function [ match_case, case_location ] = retrieve( cbr, newcase )
%RETRIEVE Summary of this function goes here
%   retrieve the case that matches best with newcase

    if strcmp(cbr.similarity_function, 'similarity_mean') ==1
        [match_case, case_location] = similarity_mean(cbr, newcase);
        return
    end
    
    min_value = 1000;
    match_case = newcase;
    typicality = 0;
    case_location = -1;
    for i = 1:length(cbr.case)
        switch cbr.similarity_function
            case 'similarity_distance'
                value = similarity_distance(newcase, cbr.case(i));
            case 'similarity_weighted'
                value = similarity_weighted(cbr, newcase, cbr.case(i));
        end
        
        if value < min_value || (value == min_value && cbr.case(i).typicality >= typicality)
            min_value = value;
            match_case = cbr.case(i);
            typicality = cbr.case(i).typicality;
            if (value == 0)
                case_location = i;
            else 
                case_location = -1;
            end
        end
        

