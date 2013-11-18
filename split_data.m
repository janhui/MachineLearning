function [data] = split_data(examples, target_attr, fold_num)
    data = struct;
    data.test_examples = [];
    data.test_targets = [];
    data.train_examples = [];
    data.train_targets = [];
    
    %sets the final number of a set = total num of rows/ total fold num
    %since we are doing 10 fold cross validation 10!
    k = 10;
    total_rows = size (examples, 1);
    
    if fold_num == 1
        test_start = 1;
        test_end = round(total_rows/k);    
    else
        test_start = round((fold_num - 1) *total_rows/k);
        test_end = round((fold_num)*total_rows/k);
    end
    
    data.test_examples = examples( test_start:test_end,:);
    data.test_targets = target_attr(test_start:test_end);
    
    %makes the training examples and targets -- the left over data after
    %the testing data depending on the fold number. 
    %if fold number = 1 then
    %all the data after the first set, 
    if test_start == 1
        train_start = test_end +1;
        train_end = total_rows;
        data.train_examples = examples(train_start:train_end,:);
        data.train_targets = target_attr(train_start:train_end);
    
    %if fold num = 10 (i.e the last test
    %= total num of row) then train data is from 1 to the last fold 
    elseif test_end == total_rows
        train_start = 1;
        train_end = test_start -1;
        data.train_examples = examples(train_start:train_end,:);
        data.train_targets = target_attr(train_start:train_end);
    %if the fold num is betweer 2 and 9 then the train data is all the data
    %before the fold and the data after the fold concatenated 
    else
        data.train_examples = examples(1:test_start-1,:);
        data.train_examples = vertcat(data.train_examples, examples(test_end+1:total_rows,:));
        data.train_targets = vertcat (target_attr(1:test_start-1), target_attr(test_end+1:total_rows));
    end
end

