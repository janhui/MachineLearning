    %creates a confusion matrix with rows corresponding to actual class and
    %columns corresponding to predicted class - like in manual
    %*TODO: pull this out to a separate *
    function matrix = get_conf_matrix(total, target_labels, pred_labels)
        matrix = zeros(total,total);
        total_length = length(target_labels);
        for j = 1:total_length
            if (target_labels(j) == pred_labels(j))
                matrix(target_labels(j), target_labels(j)) =  matrix(target_labels(j), target_labels(j)) +1;
            else
                matrix(target_labels(j), pred_labels(j)) =  matrix(target_labels(j), pred_labels(j)) +1;
            end
        end
        
    end