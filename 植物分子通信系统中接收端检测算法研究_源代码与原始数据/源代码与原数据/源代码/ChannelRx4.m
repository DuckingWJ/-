%% 傅里叶变换的幅频和相频特性图

clear; clc; close all;

%% 参数设置
x = 1.0;        % 空间位置
D = 0.1;        % 扩散系数
ux = 1;       % 对流速度

% 频率范围
w_start = -2*pi;  % 起始角频率
w_end = 2*pi;     % 结束角频率
num_points = 1000; % 绘图点数
w = linspace(w_start, w_end, num_points); % 角频率向量

%% 计算傅里叶变换 H(w)
% 常数项
K0 = 1 / (4 * pi * D * x);

sqrt_term = sqrt(ux^2 + 4i * D * w); 
H_w = K0 * exp((x / (2 * D)) * (ux - sqrt_term));

magnitude_H = abs(H_w);   % 幅值 |H(w)|
phase_rad = angle(H_w);   % 相位 (弧度)

%% 绘图
figure;

% 幅频特性
subplot(1,2,1);
plot(w, magnitude_H, 'b-', 'LineWidth', 1.5);
grid on;
xlabel('角频率 ω');
ylabel('|H(jω)|');
xlim([w_start, w_end]);

% 相频特性
subplot(1,2,2);
plot(w, phase_rad, 'r-', 'LineWidth', 1.5);
hold on;
% 添加零相位参考线
plot([w_start, w_end], [0, 0], '--k', 'LineWidth', 0.8); % 零线
grid on;
xlabel('角频率 ω');
ylabel('∠H(jω) (弧度)'); 
xlim([w_start, w_end]);
ylim([-pi, pi]); % 限制相位范围在 [-π, π]，便于观察
