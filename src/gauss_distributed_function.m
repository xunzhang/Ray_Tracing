function y = gauss_distributed_function(x, length, peak)
    sigma = 1 / (sqrt(2*3.14159265358) * peak);
    gauss_interval = 2;
    x = x * (gauss_interval / length);
    y = normpdf(x, 0, sigma);
end