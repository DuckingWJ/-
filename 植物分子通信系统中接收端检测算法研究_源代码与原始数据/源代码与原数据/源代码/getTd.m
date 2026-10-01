function [t_d,index_d] = getTd(x,v)
    D = Channel.D;
    step = mySim.step;
    if v>0
        t_d = (-3*D + sqrt(9 * D^2 + v^2 * x^2)) / v^2;
    else
        t_d = x^2 / (6*D);
    end
    t_d = round(t_d, 2);
    index_d = round(t_d/step);
end

