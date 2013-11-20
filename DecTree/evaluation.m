function [information] = evaluation(examples, targets)
%cross validation and the avg statistics for all the folds

    statistics = struct('conf_matrix',[],'avg_classification_rate',[],'avg_recall_rates',[],'avg_precision_rate',[],'avg_falpha_measure',[]);
    class_data = struct('preds', [], 'conf_matrix',[],'err_rate',[],'precision_rate',[],'recall_rate',[],'falpha_measures',[]);


    total_classes = 6;
    total_folds = 10;
    
    %does the cross validation for each fold then save it to each classdata
    for i = 1:total_folds
        information = cross_validation(examples,targets,i);
        class_data(i).preds = information.predictions;
        class_data(i).conf_matrix = information.conf_matrix;
        class_data(i).err_rate = information.error_rate;
        for j = 1:total_classes;
            class_data(i).precision_rate = information.precision_rates;
            class_data(i).recall_rate = information.recall_rates;
            class_data(i).falpha_measures= information.falpha_measures;
        end    
    end
    
    
    statistics.conf_matrix = zeros(total_classes,total_classes);
    for i = 1:total_folds
        statistics.conf_matrix = statistics.conf_matrix + class_data(i).conf_matrix;       
    end
    
    %calculate the confusion matrix and classification rate. + initialises
    %other variables
    statistics.conf_matrix = statistics.conf_matrix / total_folds;
    statistics.avg_classification_rate = 1 - sum([class_data.err_rate])/total_folds;
    statistics.avg_recall_rates = zeros(1,total_classes);
    statistics.avg_precision_rate = zeros(1,total_classes);
    statistics.avg_falpha_measure = zeros(1,total_classes);
    
    
    % calculated the avg  recall rate, f1 measure and precision rate for
    % each classification
    for i = 1:total_classes
        for j = 1:total_folds
            statistics.avg_recall_rates(i) = statistics.avg_recall_rates(i) + class_data(j).recall_rate(i);
            statistics.avg_precision_rate(i) = statistics.avg_precision_rate(i) + class_data(j).precision_rate(i);
            statistics.avg_falpha_measure(i) = statistics.avg_falpha_measure(i) + class_data(j).falpha_measures(i);
    
        end
        statistics.avg_recall_rates(i) = statistics.avg_recall_rates(i)/total_folds;
        statistics.avg_precision_rate(i) = statistics.avg_precision_rate(i) /total_folds;
        statistics.avg_falpha_measure(i) = statistics.avg_falpha_measure(i) /total_folds;
    end
end
