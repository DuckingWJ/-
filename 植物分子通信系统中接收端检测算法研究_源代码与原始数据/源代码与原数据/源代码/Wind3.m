%% 信道特性分析：不同风速下的幅频响应与3dB带宽
clear; clc; close all;

%% 1. 公共参数设置
x = 1.0;        % 接收端距离 (m)
D = 0.1;        % 扩散系数 (m^2/s)
w_range = linspace(0, 20, 1000); % 频率范围 (rad/s)，用于绘图

% 风速设置 (第一张图)
u_values_plot = [0, 0.5, 1, 2]; 

%% 2. 定义幅频特性函数 |H(w)|
get_magnitude = @(w, ux, x, D) ...
    (1/(4*pi*D*x)) * exp( (x/(2*D)) * (ux - sqrt( (sqrt(ux^4 + 16*D^2*w.^2) + ux^2)/2 )) );

%% 3. 定义 3dB 带宽解析解函数
get_bandwidth = @(ux, x, D) ...
    (1/(4*D)) * sqrt( (2*(ux + (D*log(2)/x)).^2 - ux.^2).^2 - ux.^4 );

%% --- 子图 1: 不同风速下的幅频特性 ---
figure;
subplot(1, 2, 1);
hold on;grid on;box on;

for i = 1:length(u_values_plot)
    ux = u_values_plot(i);
    mag = get_magnitude(w_range, ux, x, D);
    
    % 绘制曲线
    plot(w_range, mag, 'LineWidth', 1.5, ...
        'DisplayName', sprintf('u_x = %.1f m/s', ux));
end

title('不同风速下的幅频特性 |H(j \omega)|');
xlabel('角频率 \omega (rad/s)');
ylabel('幅值 |H(j\omega)|');
legend('Location', 'northeast');
xlim([0, max(w_range)]);

%% --- 子图 2: 3dB 带宽随风速的变化 ---
subplot(1, 2, 2);
hold on;grid on;box on;

% 风速范围 0 到 10，步长 0.01
u_scan = 0:0.01:10;
bw_scan = zeros(size(u_scan));

for i = 1:length(u_scan)
    ux = u_scan(i);
    bw_val = get_bandwidth(ux, x, D);
    bw_scan(i) = bw_val;
end

plot(u_scan, bw_scan, 'r-', 'LineWidth', 2);
title('3dB 带宽 (\omega_{3dB}) 随风速 u_x 的变化关系');
xlabel('风速 u_x (m/s)');
ylabel('3dB 带宽 \omega_{3dB} (rad/s)');
xlim([0, 10]);
ylim([0, max(bw_scan)*1.1]); % 留出顶部空间

saveas(gcf,'Wind3_res.fig');