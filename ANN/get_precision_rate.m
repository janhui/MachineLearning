%calculated the precision rate of a class depending on the confusion
%matrix gives, uses false positives and true positives using the
%equation given in the spec
function prec_rate = get_precision_rate(class, conf_matrix)
    false_pos = 0;
    true_pos = 0;
    for j = 1:length(conf_matrix)
        if j == class
            true_pos = conf_matrix(j,class);
        else
            false_pos = false_pos +  conf_matrix(j,class);
        end
    end
        
    prec_rate = (true_pos / (true_pos +false_pos))*100;
    
end
