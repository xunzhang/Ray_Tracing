%
% Find the focal distance which results a minimum RMSE.
%
% Use the fminsearch matlab lib function to find the min, see more detail by typing 'doc fminsearch'.
%
%

clc;
clear all;
clc;

% read para from input file
input_para_fid = fopen('../config/input', 'r')
num_lghts = fscanf(input_para_fid, '%d', 1)
n1 = fscanf(input_para_fid, '%f', 1)
n2 = fscanf(input_para_fid, '%f', 1)
d = fscanf(input_para_fid, '%f', 1)
W = fscanf(input_para_fid, '%f', 1)
lamda = fscanf(input_para_fid, '%f', 1)
fclose(input_para_fid)

% read para from len file
len_fid = fopen('../config/len', 'r')
len_R = fscanf(len_fid, '%f', 1)
len_k = fscanf(len_fid, '%f', 1)
len_A2 = fscanf(len_fid, '%f', 1)
len_A4 = fscanf(len_fid, '%f', 1)
len_A6 = fscanf(len_fid, '%f', 1)
len_A8 = fscanf(len_fid, '%f', 1)
len_Dist = fscanf(len_fid, '%f', 1)
fclose(len_fid)

P1 = [0, 0]
P2 = [0, 0]
P3 = [0, -d]
P4 = [0, -d-W]
parameter_package = Input(num_lgts, n1, n2, d, W, lamda)
asp_1 = Len(len_R, len_k, len_A2, len_A4, len_A6, len_A8, len_Dist)
asp_2 = Len(-len_R, len_k, len_A2, len_A4, len_A6, len_A8, -d)
ray_obj = Ray(P1, P2, P3, P4, n1, n2)

[f_frt_min, rmse_min_value] = fminsearch(@(f_frt) Find_f_frt_of_Min_Rmse(f_frt, ray_obj, parameter_package, asp_1, asp_2), 50.5206)

