%% 不同SNR、不同风速下的最优误码率曲线
clc; close all; clear;

%% 仿真参数
x = 1;

% 仿真变量范围
vs = [0.1,0.2, 0.4, 0.8];          % 风速列表
SNRs = [0, 4, 8, 12, 16, 20];        % 信噪比列表
t_arr = getTArray();
taos = linspace(0.8e-10, 6.4e-10, 32); 
% 结果
MinBERs = zeros(length(vs), length(SNRs));

%% 仿真
fprintf('start...\n');
for v_i = 1:length(vs)
    v = vs(v_i);

    for SNR_i = 1:length(SNRs)
        SNR = SNRs(SNR_i);
        BERs = zeros(1, length(taos));
        % 遍历候选阈值
        for tao_i = 1:length(taos)
            tao = taos(tao_i);
            
            goal_error = 2048; 
            errors = 0;
            bits = 0;
            
            while errors < goal_error
                tr_events = getEvents(poissrnd(mySim.lambda));
                tx_seq = getSeq(tr_events);
                
                c = getCArray(t_arr, tr_events,x, v);
                noise_c = max(awgn(c, SNR, 'measured'), 0);
                
                filtered_c = matchFilter(noise_c, v, t_arr);
                
                re_events = getEventTimes(filtered_c, tao);
                re_seq = getSeq(re_events);
                
                errors = errors + sum(xor(tx_seq, re_seq));
                bits = bits + 32;
            end
            BERs(tao_i) = errors / bits;
        end
        
        % 寻找最优解
        MinBERs(v_i, SNR_i) = min(BERs);
        fprintf('u_x: %.1f m/s, SNR: %2d dB ->  Min BER: %.2e\n',v, SNR,    MinBERs(v_i, SNR_i)  );
    end
end

%% 绘图
figure;
hold on; grid on; box on;
for i = 1:length(vs)
    plot(SNRs, MinBERs(i, :), '-o', 'LineWidth', 1.6, 'DisplayName', sprintf('u_x:%.1fm/s',vs(i)));
end
xlabel('SNR(dB)');
ylabel('BER');
title('不同风速，最优误码率随信噪比变化曲线');
legend;

saveas(gcf, "OOKBER3_res.fig");
hold off;