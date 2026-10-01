% 泊松分布概率随参数λ变化的可视化
% 绘制事件发生0次、1次、2次及以上三种情况的概率曲线

clear; clc; close all;

% 定义参数范围
lambda_range = 0:0.05:10; % λ 参数从 0 到 10，步长 0.1
time_interval = 1; % 假设时间区间 t = 1，则参数为 λ*t = λ

% 初始化概率数组
prob_0 = zeros(size(lambda_range));
prob_1 = zeros(size(lambda_range));
prob_ge_2 = zeros(size(lambda_range)); % ge = greater than or equal to

% 计算不同λ值下的概率
for i = 1:length(lambda_range)
    lambda_t = lambda_range(i); % 由于 t=1, 所以 lambda_t = lambda
    
    % P(X=0) = (λt)^0 * e^(-λt) / 0! = e^(-λt)
    prob_0(i) = exp(-lambda_t);
    
    % P(X=1) = (λt)^1 * e^(-λt) / 1! = λt * e^(-λt)
    prob_1(i) = lambda_t * exp(-lambda_t);
    
    % P(X>=2) = 1 - P(X=0) - P(X=1)
    prob_ge_2(i) = 1 - prob_0(i) - prob_1(i);
end

% 绘图
figure('Name', '泊松分布概率随参数λ变化曲线', 'NumberTitle', 'off');
plot(lambda_range, prob_0, '-', 'LineWidth', 1.5, 'DisplayName', '事件发生0次 P(X=0)');
hold on;
plot(lambda_range, prob_1, '--', 'LineWidth', 1.5, 'DisplayName', '事件发生1次 P(X=1)');
plot(lambda_range, prob_ge_2, '-.', 'LineWidth', 1.5, 'DisplayName', '事件发生≥2次 P(X≥2)');

% 添加网格和图例
grid on;
legend('Location', 'best');
xlabel('泊松分布参数 \lambda');
ylabel('概率 P(X=k)');
xlim([0 max(lambda_range)]);
ylim([0 1]);

saveas(gcf,"possion1_res.fig")


