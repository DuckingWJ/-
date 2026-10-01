%% 基于扩散-对流方程信道冲激响应极值与极值点,不同风速
clc;close all;

%% 仿真参数
sim = mySim(64,32,0.01,8);
events = getEvents(poissrnd(sim.lambda),sim.T);
t_array = 0.01: 0.01:8;
receiver_x = 1;

%% 不同风速下的信道冲激响应极值点

u_x_range = 0:0.01:10; % 风速范围 (m/s)

N = length(u_x_range);
t_d = zeros(1, N);
C_peak = zeros(1, N);

for i = 1:N
    v = u_x_range(i);

    if v > 0
        t_d(i) = (-3*channel.D + sqrt(9*channel.D^2 + v^2 * receiver_x^2)) / (v^2);
    else
        t_d(i) = receiver_x^2 / (6*channel.D);
    end
    
    t = t_d(i);
    exponent = -(receiver_x - v*t)^2 / (4*channel.D*t);
    numerator = exp(exponent);
    denominator = 8 * (pi * channel.D * t)^(1.5);
    C_peak(i) = numerator / denominator;
end

% 绘图
figure;clf;
subplot(1,2,1);
hold on; grid on; box on;
plot(u_x_range, t_d, 'b-', 'LineWidth', 2);

xlabel('风速 u_x (m/s)', 'FontSize', 10.5);
ylabel('极值时间 t_d(s)', 'FontSize', 10.5);
title('信道冲激响应极值点随风速的变化关系', 'FontSize', 10.5);

% 优化显示范围
ylim([0, max(t_d)*1.1]);

subplot(1,2,2);
hold on; grid on; box on;
plot(u_x_range, C_peak, 'b-', 'LineWidth', 2);

xlabel('风速 u_x (m/s)', 'FontSize', 10.5);
ylabel('峰值 C_{peak} ', 'FontSize', 10.5);
title('信道冲激响应峰值随风速的变化关系', 'FontSize', 10.5);

% 优化显示范围
ylim([0, max(C_peak)*1.1]);

saveas(gcf,"Wind2_res.fig");
hold off;