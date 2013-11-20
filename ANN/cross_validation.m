function [information] = cross_validation(examples, target_attr, fold_num)

total_classes = 6;
information = struct('predictions',[], 'conf_matrix',[], 'error_rate',[], 'precision_rates', [], 'recall_rates',[], 'falpha_measures',[]);
information.precision_rates = zeros(1,total_classes);
information.recall_rates = zeros(1,total_classes);
information.falpha_measures = zeros(1,total_classes);
%initialises empty trees for each emotionas
generated_trees = cell(1,6);


    %splits the data k-fold
    data = split_data(examples,target_attr,fold_num);

    %generats the tree according to the training samples. 
    for i = 1:total_classes
        generated_trees{i} = TRAIN_TREE(data.train_examples,data.train_targets,i);
    end

    %test the trees according to the spec
    %%%%%%%%%%%%%%%5TODO: need to implement!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    information.predictions = testTrees(generated_trees,data.test_examples);

    %gets the confusion matrix which depends on the actual results and the
    %predictions made by runing the script and how many got write
    information.conf_matrix = get_conf_matrix(total_classes,data.test_targets, information.predictions);

    %gets the error rate the algorithm produces
    information.error_rate = get_error_rate(data.test_targets, information.predictions);


    for i = 1:total_classes
        information.precision_rates(i) = get_precision_rate(i, information.conf_matrix);
        information.recall_rates(i) = get_recall_rate(i, information.conf_matrix);
        information.falpha_measures(i) = ((2*information.precision_rates(i)*information.recall_rates(i))+eps)/((information.precision_rates(i)+information.recall_rates(i))+eps);
    end


end