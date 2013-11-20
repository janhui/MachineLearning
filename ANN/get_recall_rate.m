function recall_rate = get_recall_rate(class, conf_matrix)
    false_neg = 0;
    true_pos = 0;
    for j = 1:length(conf_matrix)
        if j == class
            true_pos = conf_matrix(class ,j);
        else
            false_neg = false_neg +  conf_matrix(class,j);
        end
    end
    
    if true_pos +false_neg == 0
        recall_rate = - 1;
    else
        recall_rate = (true_pos / (true_pos +false_neg))*100;
    end
    


end
