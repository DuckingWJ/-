%% 不同信噪比，误码率vs检测阈值
clc;close all;

%% 仿真参数
sim = mySim(64,32,0.01,8);
m = 1.1e-9;
v=1;
x=1;
t_arr = getTArray();

%% 循环仿真
c_peak = max(getCArray(t_arr,0.01,x,m,v));
SNRs = [4,8,12];
taos = linspace(0,c_peak*1.6,32);
BERs_filtered = zeros(length(SNRs),length(taos));
BERs_noised = zeros(length(SNRs),length(taos));
% 主循环
for SNR_i = 1:length(SNRs)
    SNR = SNRs (SNR_i);
    for tao_i = 1:length(taos)
        goal_error = 256;
        % 滤波误码率
        errors = 0 ;
        bits = 0;
        while errors < goal_error
            tao = taos(tao_i);
            tr_events = getEvents(poissrnd(sim.lambda),sim.T);
            tx_seq = getSeq(tr_events);
            c = getCArray(t_arr,tr_events,x,m,v);
            noise_c = max(awgn(c, SNR, 'measured'), 0);
            filtered_c = matchFilter(noise_c,v,t_arr);
            re_events = getEventTimes(filtered_c,tao);
            re_seq = getSeq(re_events);
            errors = errors + sum(xor(tx_seq,re_seq));
            bits = bits + 32;
        end
        BERs_filtered(SNR_i,tao_i) = errors/bits;
        fprintf("SNR:%d, tao:%e, BER:%e \n",SNR,tao, BERs_filtered(SNR_i,tao_i));
        %不滤波误码率
        errors = 0 ;
        bits = 0;
    
        while errors < goal_error
            tao = taos(tao_i);
            tr_events = getEvents(poissrnd(sim.lambda),sim.T);
            tx_seq = getSeq(tr_events);
            c = getCArray(t_arr,tr_events,x,m,v);
            noise_c = max(awgn(c, SNR, 'measured'), 0);
            re_events = getEventTimes(noise_c,tao,v);
            re_seq = getSeq(re_events);
            errors = errors + sum(xor(tx_seq,re_seq));
            bits = bits + 32;
        end
        BERs_noised(SNR_i,tao_i) = errors/bits;
        fprintf("SNR:%d, tao:%e, BER:%e \n",SNR,tao, BERs_noised(SNR_i,tao_i));
    end
end

%% 绘图
figure;
hold on;  grid on ;box on ;
for SNR_i = 1:length(SNRs)
    semilogy(taos, BERs_noised(SNR_i,:), '-o', 'LineWidth', 1.5, 'DisplayName', sprintf('SNR:%d dB',SNRs(SNR_i)));
end
legend;
% 设置坐标轴
hold off;
saveas(gcf,"OOKBER1_1_res.fig");

%图2
figure;
hold on;  grid on ;box on ;
for SNR_i = 1:length(SNRs)
    semilogy(taos, BERs_filtered(SNR_i,:), '-o', 'LineWidth', 1.5, 'DisplayName', sprintf('SNR:%d dB',SNRs(SNR_i)));
end
legend;
saveas(gcf,"OOKBER1_2_res.fig");
