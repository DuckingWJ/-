function filtered_signal = matchFilter(rx_signal, v, t_array)
% 针对扩散 - 对流信道的离散匹配滤波器
    D = 0.1;
    x=1;
    % 生成信道冲激响应 h(t)
    term = 1 ./ (8 * (pi * D * t_array).^(3/2));
    exp_term = exp(-(x - v * t_array).^2 ./ (4 * D * t_array));
    h = term .* exp_term;

    [h_max,max_i] = max(h);
    for i = 1:length(h)
        if h(i) < h_max*0.01 && i > max_i
            h = h(1:i);
            break;
        end
    end

    % 构建匹配滤波器模板,并能量归一化
    g = fliplr(h); 
    normalization_factor = sumsqr(h);
    g = g/normalization_factor;
    % 执行滤波 
    y_full = conv(rx_signal, g, 'full');
    %截断等长部分
    filtered_signal = y_full(length(h):length(h)+length(rx_signal)-1);
end