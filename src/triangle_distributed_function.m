function y = triangle_distributed_function(x, length, peak)
    x = x / (length * peak); %(x/(length/(1/peak)))
    
    if(x > 0)
        y = 2/3-4/9*x;
    end
    
    if(x < 0)
        y = 2/3+4/9*x;
    end
end