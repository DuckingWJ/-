%% 基于扩散-对流方程信道冲激响应,不同风速
clc;close all;

%% 仿真参数
events = getEvents(poissrnd(mySim.lambda));
t_array = 0.01: 0.01:4;
receiver_x = 1;

%% 绘图
figure;clf;
hold on; grid on; box on

% 浓度时间曲线
vs = [0,0.5,1,2];
for i = 1:length(vs)
    v = vs(i);
    %信道冲激响应
    term = 1 ./ (8 * (pi * Channel.D * t_array).^(3/2));
    exp_term = exp(-(receiver_x - v * t_array).^2 ./ (4 * Channel.D * t_array));
    h = term .* exp_term;
    plot(t_array, h, '-', 'LineWidth', 1.5, 'DisplayName', sprintf("u_x:%.1fm/s",vs(i)));
end
% 坐标轴
legend;
ylim([0, max(h)*1.2]) ;
xlabel('时间 t (s)');
ylabel(sprintf("浓度(kg/m^3)"));

