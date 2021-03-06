function [cbr] = compute_weights(cbr)

	for emotion = 1:6
		for attr = 1:45            
            cbr.class_weights(emotion, attr) = 1/(abs(cbr.active_count(emotion, attr) / cbr.class_count(emotion) - 0.5)*2);                        
		end
	end
end

