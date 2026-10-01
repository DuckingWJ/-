function [c_a,c_b] = getRSKCArray(t_array, events_0,events_1, v,r_0,r_1)

    D = Channel.D;
    m= Channel.m;
    x=1 ;

    %建立无胁迫脉冲输入信号
    tx_signal_a = zeros(1, length(t_array)); % 初始化全零信号
    tx_signal_b = zeros(1, length(t_array)); % 初始化全零信号
    for k = 1:length(events_0)
        tx_signal_a(round(events_0(k)/0.01)) = tx_signal_a(round(events_0(k)/0.01)) + m * (r_0)/(1+r_0);
        tx_signal_b(round(events_0(k)/0.01)) = tx_signal_b(round(events_0(k)/0.01)) + m * (1)/(1+r_0);
    end
    %建立有胁迫脉冲输入信号
    for k = 1:length(events_1)
        tx_signal_a(round(events_1(k)/0.01)) = tx_signal_a(round(events_1(k)/0.01)) + m * (r_1)/(1+r_1);
        tx_signal_b(round(events_1(k)/0.01)) = tx_signal_b(round(events_1(k)/0.01)) + m * (1)/(1+r_1);
    end

    %信道冲激响应
    term = 1 ./ (8 * (pi * D * t_array).^(3/2));
    exp_term = exp(-(x - v * t_array).^2 ./ (4 * D * t_array));
    h = term .* exp_term;

    c_a_full = conv(tx_signal_a, h); 
    c_b_full = conv(tx_signal_b,h);
    c_a = c_a_full(1:length(t_array));
    c_b = c_b_full(1:length(t_array));
end