function [statistics] = evaluation(x,y,similarity_func)
%cross validation and the avg statistics for all the folds

    statistics = struct('conf_matrix',[],'avg_classification_rate',[],'avg_recall_rates',[],'avg_precision_rate',[],'avg_falpha_measure',[]);


    total_classes = 6;
    total_folds = 10;
    statistics.avg_classification_rate = 0;
    statistics.conf_matrix = zeros(total_classes,total_classes);
    classifiers = cell(1, total_folds);
    
    %does the cross validation for each fold then save it to each classdata
    for i = 1:total_folds
        classifiers{i} = cross_validation(x,y,i similarity_func);
    end

    for i = 1:total_folds
        statistics.conf_matrix = statistics.conf_matrix + classifiers{i}.conf_matrix;
        statistics.avg_classification_rate = statistics.avg_classification_rate + classifiers{i}.error_rate;       
    end
    
    %calculate the confusion matrix and classification rate. + initialises
    %other variables
    statistics.conf_matrix = statistics.conf_matrix / total_folds;
    statistics.avg_classification_rate = 1 - (statistics.avg_classification_rate/total_folds);
    statistics.avg_recall_rates = zeros(1,total_classes);   
    statistics.avg_precision_rate = zeros(1,total_classes);
    statistics.avg_falpha_measure = zeros(1,total_classes);
    
    
    % calculated the avg  recall rate, f1 measure and precision rate for
    % each classification
    for i = 1:total_classes
        statistics.avg_recall_rates(i) = get_recall_rate(i, statistics.conf_matrix);
        statistics.avg_precision_rate(i) = get_precision_rate(i, statistics.conf_matrix);
        statistics.avg_falpha_measure(i) = get_falpha_measure(i, statistics.conf_matrix);
    end

end
