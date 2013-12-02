function [information] = cross_validation(x, y, fold_num, similarity_func)

total_classes = 6;
information = struct('predictions',[], 'conf_matrix',[], 'error_rate',[], 'precision_rates', [], 'recall_rates',[], 'falpha_measures',[], 'classifying_errors', []);
information.precision_rates = zeros(1,total_classes);
information.recall_rates = zeros(1,total_classes);
information.falpha_measures = zeros(1,total_classes);
%initialises empty trees for each emotionas



    %splits the data k-fold
    data = split_data(x,y,fold_num);
    cbr = CBRinit(data.train_examples, data.train_targets, similarity_func);
    information.predictions = testCBR(cbr, data.test_examples);
    information.conf_matrix = get_conf_matrix(total_classes,data.test_targets,information.predictions);
    information.error_rate = get_error_rate(data.test_targets,information.predictions);

    for i = 1:total_classes
        information.precision_rates(i) = get_precision_rate(i, information.conf_matrix);
        information.recall_rates(i) = get_recall_rate(i,information.conf_matrix);
        information.falpha_measures(i) = get_falpha_measure(information.recall_rates(i), information.precision_rates(i));
    end

    err_rates = zeros(6,1);
    len = size(data.test_targets, 1);
    bin_targets = zeros(len);
    bin_preds = zeros(len);
    for emotion = 1:total_classes
        for j = 1:len
            bin_targets(j) =  data.test_targets(j) == emotion;
            bin_predictions(j) = information.predictions(j) == emotion;
        end

        err_rates(emotion) = nnz(bin_targets - bin_preds)/len;
    end




end