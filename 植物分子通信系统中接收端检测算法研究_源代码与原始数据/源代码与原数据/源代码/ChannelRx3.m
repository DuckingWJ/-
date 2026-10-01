%% 基于扩散-对流方程信道冲激响应
clc;close all;

%% 仿真参数
events = getEvents(poissrnd(sim.lambda));
t_array = 0.01: 0.01:8;
c_arr = getCArray(t_array,0.01,1,1);

%% 绘制
figure;clf;
hold on; grid on; box on

% 浓度时间曲线
plot(t_array, c_arr(1:length(t_array)), 'b-', 'LineWidth', 1.5);

% 坐标轴
ylim([0, max(c_arr)*1.5]) ;
xlabel('时间 t(s)');
ylabel('浓度 c(kg/m^3)')

saveas(gcf,"ChannelRx3_res.fig");
hold off;