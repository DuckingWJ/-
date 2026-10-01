%% 匹配滤波
clc;close all;

%% 仿真参数
SNRs = -20:1:20;
SNR_out = zeros(1,length(SNRs));
G = zeros(1,length(SNRs));
v=1;

for SNR_i = 1:length(SNRs)
    events = getEvents(poissrnd(mySim.lambda));

    t_array = getTArray();
    c_arr = getCArray(t_array,events,1,v);
    
    noise_c = max(awgn(c_arr, SNRs(SNR_i), 'measured'),0);%采用截断的方式避免负值
    noise = noise_c - c_arr ;
    
    c_filter = matchFilter(c_arr,1,t_array);
    noise_filter = matchFilter(noise,1,t_array);
    
    P_sign = sum(c_filter .* c_filter);
    P_noise = sum(noise_filter .* noise_filter);

    SNR_out(SNR_i) =pow2db( P_sign / P_noise);
    G(SNR_i) =pow2db( P_sign / P_noise) / SNRs(SNR_i) ;
end

%% 绘制
figure;clf;
subplot(1,2,1)
hold on; grid on; box on;
plot(SNRs, SNR_out, '-', 'LineWidth', 1.5,DisplayName="输出信噪比");
xlabel("输入信噪比(dB)");
ylabel("输出信噪比(dB)");
legend;

subplot(1,2,2);
hold on; grid on; box on;

plot(SNRs, G, '-', 'LineWidth', 1.5);
xlabel("输入信噪比");
ylabel("处理增益");

hold off;