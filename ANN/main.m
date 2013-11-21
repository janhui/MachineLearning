function [eval_six] = main(x,y)

    [net_one] = generate_one_ANN(x, y);
    [net_six] = generate_six_ANN(x ,y);
    [eval_one] = evaluation(x, y, net_one);
    [eval_six] = evaluation(x,y, net_six);
    [falpha_measure_one] = eval_one.avg_class_falpha_measure;
    [falpha_measure_six] = eval_six.avg_class_falpha_measure;
    disp(falpha_measure_one);
    disp(falpha_measure_six);
    plot_performance_measure(falpha_measure_one, falpha_measure_six);
    


end