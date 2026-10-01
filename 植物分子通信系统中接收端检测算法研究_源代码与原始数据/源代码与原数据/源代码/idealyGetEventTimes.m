function events = idealyGetEventTimes(tx_events,c_arr,x,v,tao)
    events = zeros(0);
    [~,i_d] = getTd(x,v);
    slot_i=1;events_i = 1;
    while slot_i<=mySim.slot_num 
        if events_i > length(tx_events) || slot_i*mySim.slot_duration<tx_events(events_i)
            index = round( (2*slot_i-1) * mySim.slot_duration/2 /0.01) + i_d;
            if c_arr(index) >tao
                events(end+1) = (index-i_d) * 0.01;
            end
            slot_i = slot_i+1;
        elseif (slot_i-1)*mySim.slot_duration <tx_events(events_i) && tx_events(events_i)<=slot_i*mySim.slot_duration
            index = round(tx_events(events_i)/0.01) + i_d;
            if c_arr(index) >tao
                events(end+1) = (index-i_d) * 0.01;
            end
            events_i = events_i+1;
        end
    end

end

