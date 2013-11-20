function [classes_avg] = get_class_avg_falpha_measure(conf_matrix)

	classes_avg = zeros(1,6);

	for i = 1:6
		recall_rate = get_recall_rate(conf_matrix);
		prec_rate = get_precion_rate(conf_matrix);
		classes_avg(i) = get_falpha_measure(recall_rate, prec_rate);
	end
end
