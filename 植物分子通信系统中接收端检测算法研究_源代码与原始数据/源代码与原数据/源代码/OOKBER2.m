%% 不同风速，误码率vs检测阈值
clc;close all;

%% 仿真参数
vs=[0.4,0.8,1.6,3.2];
x=1;
SNR =10;
t_arr = getTArray();

%% 循环仿真
figure;
taos = linspace(0,1.6e-9,32);
for v_i = 1:length(vs)
    v = vs (v_i);

    BERs = zeros(1,length(taos));
    for tao_i = 1:length(taos)
        goal_error = 2048;
        errors = 0 ;
        bits = 0;
    
        while errors < goal_error
            tao = taos(tao_i);
            tr_events = getEvents(poissrnd(mySim.lambda));
            tx_seq = getSeq(tr_events);
            c = getCArray(t_arr,tr_events,x,v);
            noise_c = max(awgn(c, SNR, 'measured'), 0);
            filtered_c = matchFilter(noise_c,v,t_arr);
            re_events = getEventTimes(filtered_c,tao);
            re_seq = getSeq(re_events);
            errors = errors + sum(xor(tx_seq,re_seq));
            bits = bits + 32;
        end
        BERs(tao_i) = errors/bits;
        fprintf("tao:%e, BER:%e \n",tao, BERs(tao_i));
    end

    hold on;  grid on ;box on ;
    semilogy(taos, BERs, '-o', 'LineWidth', 1.5,DisplayName=sprintf("风速:%.1fm/s",v));
end
legend;
xlabel('阈值 \tau');
ylabel('BER');
saveas(gcf,"OOKBER2_res.fig");
hold off;