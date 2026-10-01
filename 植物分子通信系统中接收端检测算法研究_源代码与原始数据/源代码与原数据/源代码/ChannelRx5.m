%% 基于扩散对流信道的接收端信号频谱
clc; close all;

%% 仿真参数
events = getEvents(poissrnd(mySim.lambda));
t_array = getTArray();
c_arr = getCArray(t_array, events, 1,1);
noise_c = max(awgn(c_arr, 10, 'measured'), 0);

%% 绘制频谱图
figure; clf;
hold on; grid on; box on;

% 采样参数 
Fs = 100;
N = length(noise_c);                % 信号长度

% 快速傅里叶变换
Y = fft(noise_c);  

% 双边谱的幅度
P2 = abs(Y / N);                    % 归一化幅度

P1 = P2(1:floor(N/2)+1);
P1(2:end-1) = 2 * P1(2:end-1);

% 频率轴
f = Fs * (0:(floor(N/2))) / N;      % 频率向量 (Hz)

% 绘图 
plot(f, P1, 'b-', 'LineWidth', 1.5, 'DisplayName', '含噪信号幅度谱');
hold on;

% 绘制无噪信号的频谱进行对比
Y_clean = fft(c_arr);
P2_clean = abs(Y_clean / N);
P1_clean = P2_clean(1:floor(N/2)+1);
P1_clean(2:end-1) = 2 * P1_clean(2:end-1);
plot(f, P1_clean, 'r--', 'LineWidth', 1.5, 'DisplayName', '无噪信号幅度谱');

% 坐标轴与图例
xlim([0, 8]);                   
ylim([0, max(P1)*1.1]);
xlabel('频率 f (Hz)');
ylabel('幅度 |H(f)|');
legend('Location', 'best');

xline(0.316, 'k:', 'LineWidth', 1, 'DisplayName', '3dB带宽 (0.316Hz)'); 

saveas(gcf, "ChannelRx5_res.fig");
hold off;