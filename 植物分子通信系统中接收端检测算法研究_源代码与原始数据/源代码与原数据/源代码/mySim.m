classdef mySim
    properties (Constant = true)
        T  = 64 ;
        slot_num = 32;
        slot_duration = 2;% 时隙/码元持续时间
        lambda = 8;% 泊松分布参数
        step = 0.01;%仿真步长时间
        Fs = 100;%采样频率
    end
    
end

