function event_times = getRSKEventTimes(filtered_c_a,filtered_c_b)
    event_times = zeros(0);

    % 差分
    dc_a  = gradient(filtered_c_a, mySim.step);
    for i = 2: length(dc_a)-1
        if filtered_c_a(i) > filtered_c_b(i) && dc_a(i-1)>0 &&dc_a(i)<0 
            event_times(end+1) = i*0.01;
        end
    end
end

