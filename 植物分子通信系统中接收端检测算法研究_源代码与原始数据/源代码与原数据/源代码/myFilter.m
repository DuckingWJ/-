%% 匹配滤波
clc;close all;

%% 仿真参数
events = getEvents(poissrnd(mySim.lambda));
v=1;
t_array = getTArray();
c_arr = getCArray(t_array,events,1,v);
noise_c = max(awgn(c_arr, 10, 'measured'),0);%采用截断的方式避免负值

%% 绘制浓度时间曲线
figure;clf;
hold on; grid on; box on

% 绘制浓度时间曲线

plot(t_array, noise_c(1:length(t_array)), '-', 'LineWidth', 1.5, 'DisplayName', '滤波前信号');
plot(t_array, c_arr(1:length(t_array)), '-', 'LineWidth', 1.5, 'DisplayName', '无噪声滤波前信号');
c_filter = matchFilter(noise_c,1,t_array);
plot(t_array,c_filter(1:length(t_array)),'-','LineWidth',1.5,'DisplayName','滤波后信号');
legend;
% 设置坐标轴
xlim([0, mySim.T]);
ylim([0, max(c_arr)*1.5]) ;
xlabel('时间 t (s)');
ylabel('浓度');
title('基于匹配滤波器的滤波后接收信号');

saveas(gcf,"myFilter_res.fig");
hold off;