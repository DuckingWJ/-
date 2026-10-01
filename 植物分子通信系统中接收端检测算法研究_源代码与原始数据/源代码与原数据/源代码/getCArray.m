function c = getCArray(TArray, events, x, v)

    D = 0.1;
    m = Channel.m;
    tx_signal = zeros(1, length(TArray)); % 初始化全零信号
    for k = 1:length(events)
        tx_signal(round(events(k)/0.01)) = tx_signal(round(events(k)/0.01)) + m;
    end
    
    %信道冲激响应
    term = 1 ./ (8 * (pi * D * TArray).^(3/2));
    exp_term = exp(-(x - v * TArray).^2 ./ (4 * D * TArray));
    h = term .* exp_term;

    c = conv(tx_signal, h); 
end