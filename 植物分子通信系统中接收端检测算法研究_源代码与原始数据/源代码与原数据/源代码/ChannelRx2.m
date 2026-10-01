%% 考虑噪声时基于扩散对流的接收信号
clc;close all;

%% 仿真参数
events = getEvents(poissrnd(mySim.lambda));
t_array = getTArray();
c_arr = getCArray(t_array,events,1,1);
noise_c = max(awgn(c_arr, 10, 'measured'),0);%采用截断的方式避免负值
%% 绘制
figure;clf;
hold on; grid on; box on

% 浓度时间曲线
plot(t_array, noise_c(1:length(t_array)), 'b-', 'LineWidth', 1.5, 'DisplayName', '分子浓度');

% 坐标轴
xlim([0, mySim.T]);
ylim([0, max(c_arr)*1.5]) ;
xlabel('时间 t (s)');
ylabel('浓度');

saveas(gcf,"ChannelRx2_res.fig");
hold off;