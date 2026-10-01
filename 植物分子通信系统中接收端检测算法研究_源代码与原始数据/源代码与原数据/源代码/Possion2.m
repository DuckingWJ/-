%% 基于泊松分布的发射端编码
clc;close all;

%% 仿真参数
sim = mySim();
events = getEvents(poissrnd(sim.lambda));
tx_seq = getSeq(events);

%% 绘制浓度时间曲线
figure;clf;
hold on; grid on; box on;

% 绘制事件时间戳（垂直线）
for i = 1:length(events)
    if events(i) <= sim.T
        stem([events(i), events(i)], [0, 0.8], 'r--', 'LineWidth', 1);
    end
end

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
         'FontSize', 10, 'FontWeight', 'bold', 'Color', 'blue');
end


% 坐标轴与图例
xlim([0, sim.T]);
ylim([0, max(tx_seq)*1.2]) ;
xlabel('时间 t (s)');
ylabel('编码值');
legend('事件时间戳', 'Location', 'best');
hold off;