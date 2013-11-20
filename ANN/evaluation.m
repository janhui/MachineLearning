function [information] = evaluation(examples, targets, net)
%cross validation and the avg statistics for all the folds

    statistics = struct('conf_matrix',[],'avg_classification_rate',[],'avg_recall_rates',[],'avg_precision_rate',[],'avg_fold_falpha_measure',[],'avg_class_falpha_measure',[]);

    random_examples = examples;
    random_targets = targets;
    total_classes = 6;
    total_folds = 10;
    classifiers = cell(1,total_folds);

    
    %does the cross validation for each fold then save it to each classdata
    for i = 1:total_folds
        classifiers{i} = cross_validation(random_examples,random_targets,i);
    end
    
    
    statistics.conf_matrix = zeros(total_classes,total_classes);
    statistics.avg_classification_rate = 0;
    statistics.avg_class_falpha_measure = zeros(1,total_folds);
    for i = 1:total_folds
        nans = 0;
        statistics.conf_matrix = statistics.conf_matrix +classifiers{i}.conf_matrix;
        statistics.avg_classification_rate = statistics.avg_classification_rate +classifiers{i}.error_rate;
        for j = 1:total_classes
            if classifiers{i}.falpha_measures(j) == -1
                nans = nans+1;
            else
                statistics.avg_class_falpha_measure(i) = statistics.avg_class_falpha_measure(i) + classifiers{i}.falpha_measures(j)
            end
        end
        statistics.avg_class_falpha_measure(i) = statistics.avg_class_falpha_measure(i) / total_classes-nans; 

    end
    
    %calculate the confusion matrix and classification rate. + initialises
    %other variables
    statistics.conf_matrix = statistics.conf_matrix / total_folds;
    statistics.avg_classification_rate = 1 - statistics.avg_classification_rate/total_folds;
    statistics.avg_recall_rates = zeros(1,total_classes);
    statistics.avg_precision_rate = zeros(1,total_classes);
    statistics.avg_fold_falpha_measure = zeros(1,total_classes);
    
    
    % calculated the avg  recall rate, f1 measure and precision rate for
    % each classification
    for i = 1:total_classes
        nans = zeros(1,3);
        for j = 1:total_folds
            if classifiers{j}.precision_rates(i) == -1
                nans(1) = nans(1)+1
            else
                statistics.avg_precision_rate(i) = statistics.avg_precision_rate(i) + classifiers{j}.precision_rates(i);
            end            
            if classifiers{j}.recall_rates(i) == -1
                nans(2) = nans(2)+1
            else
                statistics.avg_recall_rates(i) = statistics.avg_recall_rates(i) + classifiers{j}.recall_rates(i);
            end   
            if classifiers{j}.falpha_measures(i) == -1
                nans(3) = nans(3)+1
            else
                statistics.avg_fold_falpha_measure(i) = statistics.avg_fold_falpha_measure(i) + classifiers{j}.falpha_measures(i);
            end

        end
        statistics.avg_recall_rates(i) = statistics.avg_recall_rates(i)/(total_folds-nans(2);
        statistics.avg_precision_rate(i) = statistics.avg_precision_rate(i) /(total_folds-nans(1);
        statistics.avg_fold_falpha_measure(i) = statistics.avg_fold_falpha_measure(i) /(total_folds-nans(3));
    end
end
