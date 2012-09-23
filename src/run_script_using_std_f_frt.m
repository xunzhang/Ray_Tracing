%
% run the basic process of the model and plot the picture of our model.
% you can also have a phase difference distribution in another picture.
%

clc;
clear all;
clc;

% calculate the wavefront
wavefront = cal_wavefront_and_polt()

% calculate the wgts of the phase difference
weights = cal_wgts();

% calculate the rmse using the weights and wavefront
rmse = cal_rmse(weights, wavefront);
