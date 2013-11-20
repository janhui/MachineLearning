function [] = plot_performance_measure(f1_vector_one, f1_vector_six)


%%checkeck the labels!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


	y = [f1_vector_one',f1_vector_six'];
	bar(y,'grouped');
	title('Average F1-measure value for Fold');
	xlabel('Number of Fold');
	ylaber('Average F1 measure');
	legend('6 output neural network', '6 one output neural network');
end
	