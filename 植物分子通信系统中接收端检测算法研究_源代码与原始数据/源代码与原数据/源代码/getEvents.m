function events = getEvents(events_num)
        % 生成泊松事件序列
        % 输入：
        %   lambda - 泊松强度（平均事件数）
        %   T      - 发射时间窗口
        % 输出：
        %   events - 排序后的事件发生时间（列向量）
        events = sort(rand(1,events_num) * mySim.T); % 均匀分布在 [0, T]
        events = round(events, 2);         % 保留两位小数
        events = max(0.01,events);%最小0.01
end
