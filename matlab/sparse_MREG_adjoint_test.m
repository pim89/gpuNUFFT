% MREG Test

clear all; close all; clc;
%%
load ../../daten/MREG_data_Graz;
addpath(genpath('GRIDDING3D'));
addpath(genpath('../bin'));
%%
% test for adjoint property: looks good
x1 = randn(size(z));
x1 = repmat(x1,[1 1 1 32]);
y2 = reshape(randn(size(data)),[11685 32]);

osf = 1.5;%1,1.25,1.5,1.75,2
wg = 3;%3-7
sw = 8;
imwidth = 64;
k = E.nufftStruct.om'./(2*pi);
w = ones(E.trajectory_length,1);
%%
%G3D = GRIDDING3D(k,w,imwidth,osf,wg,sw,'false');
G3D = GRIDDING3D(k,w,imwidth,osf,wg,sw,'sparse',E);

%%
y1 = G3D * x1;
y1_corr = y1/sqrt(prod([64 64 44 32]));
%%
x2 = G3D' * y2;
x2_corr = x2/sqrt(prod([64 64 44 32]));
%%
diff = x1(:)'*x2_corr(:) - y1_corr(:)'*y2(:)
display(['Adjoint test result: ', num2str(diff)]);

% Apply to data
%data1 = E * z;
%z1 = E' * data1;
