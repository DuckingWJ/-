%% 不同SNR、不同风速下的最优误码率曲线
clc; close all; clear;

%% 仿真参数
r_0=0.5;
r_1=2;

% 仿真变量范围
vs = 0.5:0.05:1.2;          % 风速列表
SNRs = [4,8,12,16,20,24];        % 信噪比列表
t_arr = getTArray();

%% 核心循环
BERs = zeros(length(SNRs), length(vs));
for SNR_i = 1:length(SNRs)
    SNR = SNRs(SNR_i);
    for v_i = 1:length(vs)
        v = vs(v_i);
   
        goal_error = 4096; 
        errors = 0;
        bits = 0;
        
        while errors < goal_error
            events1 = getEvents(poissrnd(mySim.lambda));
            events0 = 0.01:4:64; 
            tx_seq = getSeq(events1);
            
            [c_a,c_b] = getRSKCArray(t_arr, events0,events1,v,r_0,r_1);
            noise_c_a = max(awgn(c_a, SNR, 'measured'), 0);
            noise_c_b = max(awgn(c_b, SNR, 'measured'), 0);
            filtered_c_a = matchFilter(noise_c_a, v, t_arr);
            filtered_c_b = matchFilter(noise_c_b, v, t_arr);

            re_events = getRSKEventTimes(filtered_c_a,filtered_c_b);
            re_seq = getSeq(re_events);
            
            errors = errors + sum(xor(tx_seq, re_seq));
            bits = bits + 32;
        end
        BERs(SNR_i, v_i)  = errors / bits;
        
        fprintf('u_x: %.1f m/s, SNR: %2d dB ->  BER: %.2e\n', ...
            v, SNR,     BERs(SNR_i, v_i) );
    end
end

%% 绘图与排版
figure;
hold on; grid on; box on;

for i = 1:length(SNRs)
    plot(vs, BERs(i, :), '-o', 'LineWidth', 1.6, 'DisplayName', sprintf('SNR:%ddB',SNRs(i)));
end
xlabel('v(m/s)');
ylabel('BER');
legend;

% 保存图像
saveas(gcf, "RSK3_res.fig");
hold off;