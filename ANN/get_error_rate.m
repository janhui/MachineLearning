%used to get the error rate for each class, gets the avg classification
%rate (1-error rate)/total_target

function err = get_error_rate(target_labels, pred_labels)
    total_target = length(target_labels);
    
    comparison = zeros(total_target,1);
        
    function x = compare_actual_preds(act, pred)
        if act == pred
            x = 1;
        else
            x = 0;
        end
    end
               
    for j= 1:total_target
        comparison(j) = 1- compare_actual_preds(target_labels(j),pred_labels(j));               
    end
    
    err = (1/total_target) * sum(comparison); 
end
