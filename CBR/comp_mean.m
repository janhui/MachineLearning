function [cbr] = compute_mean(cbr)

	for emotion = 1:6
		cbr.mean_active(emotion,:) = cbr.active_count(emotion,:)/cbr.class_count(emotion);
	end

end