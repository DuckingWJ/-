%% RSK调制的发射端编码
clc;close all;

%% 仿真参数
sim = mySim(64,32,0.01,8);
events = getEvents(poissrnd(sim.lambda),sim.T);
events0 = 0.01:4:64; 
tx_seq = getSeq(events);

%% 绘制
figure;
hold on; grid on; box on;

% 绘制事件时间戳（垂直线）
h1 = stem(events, 0.8*ones(length(events)), 'r--', 'LineWidth', 1,'DisplayName','胁迫事件脉冲');
h2 = stem(events0, 0.8*ones(length(events0)), 'b--', 'LineWidth', 1,'DisplayName','无胁迫事件固有脉冲');

% 时隙分界线
slot_boundaries = 0:2:sim.T; % 0, 2, 4, ..., 64
for i = 1:length(slot_boundaries)
    plot([slot_boundaries(i), slot_boundaries(i)], [0, max(tx_seq)*1.2], 'k:', 'LineWidth', 0.8);
end

% 码元序列
slot_centers = (0:length(tx_seq)-1) * sim.slot_duration + sim.slot_duration/2; % 每个时隙的中心点
for i = 1:length(tx_seq)
    text(slot_centers(i), 0.9, num2str(tx_seq(i)), ...
         'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', ...
         'FontSize', 10, 'FontWeight', 'bold');
end

legend([h1(2),h2(2)],{'胁迫事件脉冲', '无胁迫事件固有脉冲'});
% 坐标轴
xlim([0, sim.T]);
ylim([0, max(tx_seq)*1.2]) ;
xlabel('时间 t (s)');
ylabel('编码值');
title('基于RSK调制下的事件时间戳与编码后的码元序列');

saveas(gcf,"RSK1_res.fig");
hold off;