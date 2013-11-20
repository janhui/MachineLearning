function falpha_measure = get_falpha_measure(recall_rate, precision_rate)


	if(recall_rate == -1 || precision_rate == -1 || recall_rate + precision_rate ==0)
		falpha_measure = -1;
	else
		falpha_measure =  ((2*information.precision_rates(i)*information.recall_rates(i))+eps)/((information.precision_rates(i)+information.recall_rates(i))+eps);
	end
end