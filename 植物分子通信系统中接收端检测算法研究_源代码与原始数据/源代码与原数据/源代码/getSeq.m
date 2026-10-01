function seq = getSeq( events)
    % 将事件时间映射到时隙符号序列
    % 输入：
    %   events       - 事件时间向量（列向量或行向量）
    % 输出：
    %   tx_seq       - 1×slot_num 的二进制序列（1 表示该时隙有事件）
    seq = zeros(1, mySim.slot_num);

    for j = 1:length(events)
        t = events(j);
        slot_idx = ceil(t / mySim.slot_duration);
        if slot_idx >= 1 && slot_idx <= mySim.slot_num
            seq(slot_idx) = 1;
        end
    end
end
