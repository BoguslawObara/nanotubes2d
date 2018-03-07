%   REFERENCE:
%       K. Massey, A. Kotsialos, D. Volpati, E. Vissol-Gaudin, C. Pearson, 
%       L. Bowen, B. Obara, D. Zeze, C. Groves, M. Petty, 
%       Evolution of electronic circuits using carbon nanotube composites, 
%       Nature Scientific Reports, 6, 32197, 2016

%% clear
clc; clear all; close all;

%% path
addpath('./lib')
addpath('../vesselness2d/lib')

%% load image
im = imread('./im/nanotubes.tif');
im = rgb2gray(im);
im = imresize(im,0.5);

%% normalize
im = double(im); im = (im - min(im(:))) / (max(im(:)) - min(im(:)));

%% filter
s = 1;
se = fspecial('gaussian',3*s,s);
im = imfilter(im,se,'replicate');

%% normalize
im = double(im); im = (im - min(im(:))) / (max(im(:)) - min(im(:)));
im = imcomplement(im);

%% threshold
% t = graythresh(im);
% imth = im>t;
imth = im>0.55;

%% vesselness2d
sigma = 1:1:5; gamma = 2; beta = 0.5; c = 15; wb = true;
[imv,v,vidx,vx,vy,l1,l2] = vesselnessv2d(im,sigma,gamma,beta,c,wb);

%% normalize
imv = double(imv); imv = (imv - min(imv(:))) / (max(imv(:)) - min(imv(:)));

%% orientation
imor = zeros(size(im));
for i=1:size(im,1)
    for j=1:size(im,2)
        if imth(i,j)==1
            imor(i,j) = vector_vector_angle2d(abs([vx(i,j) vy(i,j)]),[1 0],1,1);
        end
    end
end

%% plot
figure; imagesc(im); colormap gray; axis image; axis tight; axis off;

imor(~imth) = -1;
j = jet; j(1,:) = [0 0 0];
figure; imagesc(imor); colormap(j) ; axis image; axis tight; axis off; colorbar;