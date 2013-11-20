function [information] = cross_validation(examples, target_attr, fold_num, net)

total_classes = 6;
information = struct('predictions',[], 'conf_matrix',[], 'error_rate',[], 'precision_rates', [], 'recall_rates',[], 'falpha_measures',[]);
information.precision_rates = zeros(1,total_classes);
information.recall_rates = zeros(1,total_classes);
information.falpha_measures = zeros(1,total_classes);

    %splits the data k-fold
    data = split_data(examples,target_attr,fold_num);
    [train_exs, train_tars] = ANNdata(data.train_examples, data.train_targets);
    [test_exs, ~] = ANNdata(data.test_examples, data.test_targets);
    
    if size(net, 1) == 6
    %trains ANN according to the training samples. 
        for i = 1:total_classes
            net{i}.divideFcn = 'divideint';
            net{i}.divideParam.trainRatio = 0.67;
            net{i}.divideParam.valRatio = 0.33;
            net{i}.divideParam.testRatio = 0;
            [net{i}] = train(net{i}, train_exs, train_tars(i, :));
        end
    else
         net.divideFcn = 'divideint';
         net.divideParam.trainRatio = 0.67;
         net.divideParam.valRatio = 0.33;
         net.divideParam.testRatio = 0;
         [net] = train(net{i}, train_exs, train_tars);
    end
    
    %error rates corresponding to each emotion
    emotion_error_rates = zeros(6, 1);
    test_tar_len = size(data.test_targets, 1);    
    binary_targets = zeros(test_tar_len);
    binary_predictions = zeros(test_tar_len);
    for emotion = 1:6
        for i=1:test_tar_len
            binary_targets(i) = (data.test_targets(i) == emotion);
            binary_predictions(i) = (info.predictions(i) == emotion);
        end       
        
        emotion_error_rate = nnz(binary_targets - binary_predictions)/test_tar_len;        
        emotion_error_rates(emotion) = emotion_error_rate;
    end    
    

    %test the trees according to the spec
    information.predictions = testANN(net, test_exs);

    %gets the confusion matrix which depends on the actual results and the
    %predictions made by runing the script and how many got write
    information.conf_matrix = get_conf_matrix(total_classes,data.test_targets, information.predictions);

    %gets the general error rate the algorithm produces 
    information.error_rate = get_error_rate(data.test_targets, information.predictions);

    for i = 1:total_classes
        information.precision_rates(i) = get_precision_rate(i, information.conf_matrix);
        information.recall_rates(i) = get_recall_rate(i, information.conf_matrix);
        information.falpha_measures(i) = ((2*information.precision_rates(i)*information.recall_rates(i))+eps)/((information.precision_rates(i)+information.recall_rates(i))+eps);
    end


end