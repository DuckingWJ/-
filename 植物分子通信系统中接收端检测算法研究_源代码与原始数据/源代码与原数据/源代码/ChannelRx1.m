%% 基于扩散-对流方程的植物间分子通信信号
clc;close all;

%% 仿真参数
sim = mySim(64,32,0.01,8);
events = getEvents(poissrnd(sim.lambda),sim.T);
channel = Channel(1,1,sim);
t_array = getTArray();
c_arr = getCArray(t_array,events,1,channel.m,channel.v);

%% 绘制
figure;clf;
hold on; grid on; box on

% 浓度时间曲线
plot(t_array, c_arr(1:length(t_array)), 'b-', 'LineWidth', 1.5, 'DisplayName', '分子浓度');

% 坐标轴
xlim([0, sim.T]);
ylim([0, max(c_arr)*1.5]) ;
xlabel('时间 t (s)');
ylabel('浓度');
title('基于扩散-对流信道的接收信号曲线');

saveas(gcf,"ChannelRx_res1.fig");
hold off;