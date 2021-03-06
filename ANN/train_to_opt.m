function [net, tr] = train_to_opt(net, x, y)

    unconfigure(net);
    [x2, y2] = ANNdata(x, y);
    net = configure(net, x2, y2);
    
    net.divideFcn = 'divideint';
    net.divideParam.trainRatio = 0.9;
    net.divideParam.valRatio = 0.1;
    net.divideParam.testRatio = 0;
    net.trainParam.time = 20;
    
    [net, tr] = train(net, x2, y2);
    
end