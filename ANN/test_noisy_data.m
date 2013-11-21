function [falpha_measures] = test_noisy_data(x,y, net)
    %takes a noisy data as x and y and a the neural network to test it on 
    
    total_classes = 6;
    stats = struct('preds',[],'conf_matrix',[],'prec_rate',[],'recall_rates',[],'falpha_measure',[]);
    stats.prec_rate = zeros(1, total_classes);
    stats.recall_rates = zeros(1, total_classes);
    stats.falpha_measure = zeros(1, total_classes);
    
    [x2, y2] = ANNdata(x,y);
    stats.preds = testANN(net, x2);   
    stats.conf_matrix = get_conf_matrix(total_classes, y , stats.preds);
    
    for i = 1:num_classes
        stats.prec_rate(i) = get_precision_rate(i, stats.conf_matrix);
        stats.recall_rates(i) = get_recall_rate(i, stats.conf_matrix);
        stats.falpha_measure(i) = get_falpha_measure(stats.recall_rates(i), stats.prec_rate(i));
    end
    
    
    falpha_measures = stats.falpha_measure;
    

end

