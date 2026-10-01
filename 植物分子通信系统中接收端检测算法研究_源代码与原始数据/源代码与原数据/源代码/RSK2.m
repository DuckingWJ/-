%% RSK调制接收信号
clc;close all;

%% 仿真参数
t_array = getTArray();
events = getEvents(poissrnd(mySim.lambda));
events0 = 0.01:4:64; 
r_0 = 0.5;
r_1 = 2;
v =3.2;
[c_a,c_b] = getRSKCArray(t_array,events0,events,v,r_0,r_1);
SNR = 10;
%
noise_c_a = max(awgn(c_a, SNR, 'measured'), 0);
noise_c_b = max(awgn(c_b, SNR, 'measured'), 0);
filtered_c_a = matchFilter(noise_c_a, v, t_arr);
filtered_c_b = matchFilter(noise_c_b, v, t_arr);
%% 绘制
figure;clf;
hold on; grid on; box on

% 浓度时间曲线
plot(t_array, c_a, '.-', 'LineWidth', 1, 'DisplayName', 'a分子浓度');
plot(t_array, c_b, '.-', 'LineWidth', 1, 'DisplayName', 'b分子浓度');
plot(t_array, filtered_c_a, '-', 'LineWidth', 1, 'DisplayName', 'a分子浓度');
plot(t_array, filtered_c_b, '-', 'LineWidth', 1, 'DisplayName', 'b分子浓度');
legend;
% 坐标轴
xlim([0, mySim.T]);
ylim([0, max(c_a)*1.5]) ;
xlabel('时间 t (s)');
ylabel('浓度');
title('RSK调制接收信号');

saveas(gcf,"RSK2_res.fig");
hold off;