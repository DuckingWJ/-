function event_times = getEventTimes( c, tao, v)
    event_times = zeros(0);
    % 差分
    dc  = gradient(c, mySim.step);
    % 检测
    nargin_temp = nargin;
    for i = 2: length(dc)-1
        if c(i) > tao && dc(i-1)>0 &&dc(i)<0
            if nargin_temp ==2 && i < mySim.T*100 %匹配滤波接收方案 
                event_times(end+1) = i*0.01;
            end
        end
    end
end