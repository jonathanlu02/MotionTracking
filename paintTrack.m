% Jonathan Lu
% AMATH 482
% HW2 - PCA for mass/spring system
% 2/3/17

close all; clc
%%% case 1 %%%
% vid1 = cropVid(vidFrames1_1,290,200,110,230); % crop
% vid2 = cropVid(vidFrames2_1,240,110,110,270);
% vid3 = cropVid(vidFrames3_1,275,240,205,110);
% t1 = readData(vid1(:,:,:,10:end)); % shift
% t2 = readData(vid2(:,:,:,20:end));
% t3 = readData(vid3(:,:,:,10:end));
%%% case 2 - the wobbling camera %%%
% vid1 = cropVid(vidFrames1_2,240,180,200,220); % crop
% vid2 = cropVid(vidFrames2_2,230,100,200,320); % so much shaking T_T
% vid3 = cropVid(vidFrames3_2,210,190,220,150);
% t1 = readData(vid1(:,:,:,13:end)); % shift
% t2 = readData(vid2(:,:,:,:));
% t3 = readData(vid3(:,:,:,18:end));
%%% case 3 - horizontal displacement %%%
% vid1 = cropVid(vidFrames1_3,260,160,210,180); % crop
% vid2 = cropVid(vidFrames2_3,210,220,200,160); 
% vid3 = cropVid(vidFrames3_3,280,250,110,130);
% t1 = readData(vid1(:,:,:,16:end)); % shift
% t2 = readData(vid2(:,:,:,45:end));
% t3 = readData(vid3(:,:,:,11:end));
%%% case 4 - horizontal displacement w/ rotation %%%
vid1 = cropVid(vidFrames1_4,280,250,110,130); % crop
vid2 = cropVid(vidFrames2_4,210,130,170,200); 
vid3 = cropVid(vidFrames3_4,230,200,300,160);
t1 = readData(vid1(:,:,:,35:end)); % shift
t2 = readData(vid2(:,:,:,41:end));
t3 = readData(vid3(:,:,:,32:end));

% truncate and add to data matrix, since not all frames could be parsed
% fully:
minFrames = min([size(t1, 2), size(t2, 2), size(t3,2)]); 
A = [t1(:, 1:minFrames); t2(:, 1:minFrames); t3(:, 1:minFrames)];

%% performing svd
[U, S, V] = svd(A, 'econ');

%% analyzing the results
figure(1)
plot(100*diag(S)/sum(diag(S)), 'ko')
xlabel('\sigma_x')
ylabel('Percentage (%)')
title('Dominance of \sigma_x')

figure(2) 
subplot(3,1,1)
plot(V(:,1))
xlabel('mode 1')
subplot(3,1,2)
plot(V(:,2))
xlabel('mode 2')
subplot(3,1,3)
plot(V(:,3))
xlabel('mode 3')


