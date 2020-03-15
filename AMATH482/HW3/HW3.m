
%% Case 1
clear all;close all;clc
load('cam1_1.mat')
% implay(vidFrames1_1)
load('cam2_1.mat')
% implay(vidFrames2_1)
load('cam3_1.mat')
% implay(vidFrames3_1)

% for j = 1:numFrames
% X = vidFrames1_1(:,:,:,j);
% imshow(X); drawnow
% end
%[x,y,rgb,frame_num]=size(vidFrames1_1);
frame_num1=size(vidFrames1_1,4);
frame_num2=size(vidFrames2_1,4);
frame_num3=size(vidFrames3_1,4);
matrix1=[];
matrix2=[];
matrix3=[];
for i=1:frame_num1
    gray_imag=double(rgb2gray(vidFrames1_1(:,:,:,i)));
    gray_imag(:,1:240)=0;
    gray_imag(:,400:680)=0;
    gray_imag(1:180,:)=0;
    Max=max(gray_imag(:));
    [x,y]=find(gray_imag>0.9*Max);
    matrix1=[matrix1;mean(x),mean(y)];  
end
for i=1:frame_num2
    gray_imag=double(rgb2gray(vidFrames2_1(:,:,:,i)));
    gray_imag(:,1:240)=0;
    gray_imag(:,400:680)=0;
%     gray_imag(1:100,200:350)=0;
    Max=max(gray_imag(:));
    [x,y]=find(gray_imag>0.9*Max);
    matrix2=[matrix2;mean(x),mean(y)];  
end
for i=1:frame_num3
    gray_imag=double(rgb2gray(vidFrames3_1(:,:,:,i)));
    gray_imag(:,1:240)=0;
    gray_imag(:,500:680)=0;
    gray_imag(1:200,200:500)=0;
    gray_imag(330:480, 220:500)=0;
    Max=max(gray_imag(:));
    [x,y]=find(gray_imag>0.9*Max);
    matrix3=[matrix3;mean(x),mean(y)];  
end

[M,I]=min(matrix1(1:25,2));
matrix1=matrix1(I:end,:);
[M,I]=min(matrix2(1:25,2));
matrix2=matrix2(I:end,:);
[M,I]=min(matrix3(1:25,2));
matrix3=matrix3(I:end,:);
size1=size(matrix1);
size2=size(matrix2);
size3=size(matrix3);
min_size=min([size1(1) size2(1) size3(1)]);
matrix1=matrix1(1:min_size,:);
matrix2=matrix2(1:min_size,:);
matrix3=matrix3(1:min_size,:);
x1=matrix1(:,1);
y1=matrix1(:,2);
x2=matrix2(:,1);
y2=matrix2(:,2);
x3=matrix3(:,1);
y3=matrix3(:,2);
bigX=[x1 y1 x2 y2 x3 y3];
bigX=bigX';
t=1:min_size;

subplot(3,1,1)
plot(t,bigX(1,:),t,bigX(2,:))
xlabel('Frame number'); ylabel('Displacement(pixel)')
title('Camera 1')
legend('z','x-y plane')
subplot(3,1,2)
plot(t,bigX(3,:),t,bigX(4,:))
xlabel('Frame number'); ylabel('Displacement(pixel)')
legend('z','x-y plane')
title('Camera 2')
subplot(3,1,3)
plot(t,bigX(6,:),t,bigX(5,:))
xlabel('Frame number'); ylabel('Displacement(pixel)')
legend('z','x-y plane')
title('Camera 3')

meandata=zeros(6,1);
for i=1:6
   meandata(i,1)=mean(bigX(i,:)); 
end
bigX=bigX-meandata;
subplot(2,1,1)
[U,S,V]=svd(bigX);
sig=diag(S);
plot(sig.^2/sum(sig.^2),'bo','Linewidth',1.5)
xlabel('Mode'); ylabel('Energy captured(%)')
subplot(2,1,2)
plot(t,S*V')
xlabel('Frame number'); ylabel('Displacement(pixel)')
legend('mode1','mode2','mode3','mode4','mode5','mode6')


%% Case 2
clear all;close all;clc
load('cam1_2.mat')
implay(vidFrames1_2)
load('cam2_2.mat')
implay(vidFrames2_2)
load('cam3_2.mat')
implay(vidFrames3_2)

frame_num1=size(vidFrames1_2,4);
frame_num2=size(vidFrames2_2,4);
frame_num3=size(vidFrames3_2,4);
matrix1=[];
matrix2=[];
matrix3=[];
for i=1:frame_num1
    gray_imag=double(rgb2gray(vidFrames1_2(:,:,:,i)));
    gray_imag(1:440,1:300)=0;
    gray_imag(1:440,470:680)=0;
    gray_imag(1:180,300:450)=0;
    Max=max(gray_imag(:));
    [x,y]=find(gray_imag>0.9*Max);
    matrix1=[matrix1;mean(x),mean(y)];  
end
for i=1:frame_num2
    gray_imag=double(rgb2gray(vidFrames2_2(:,:,:,i)));
    gray_imag(1:440,1:180)=0;
    gray_imag(1:440,450:680)=0;
    Max=max(gray_imag(:));
    [x,y]=find(gray_imag>0.9*Max);
    matrix2=[matrix2;mean(x),mean(y)];  
end
for i=1:frame_num3
    gray_imag=double(rgb2gray(vidFrames3_2(:,:,:,i)));
    gray_imag(:,1:280)=0;
    gray_imag(:,520:680)=0;
    gray_imag(1:170,290:500)=0;
    gray_imag(350:480, 290:500)=0;
    Max=max(gray_imag(:));
    [x,y]=find(gray_imag>240);
    matrix3=[matrix3;mean(x),mean(y)];  
end

[M,I]=min(matrix1(1:25,2));
matrix1=matrix1(I:end,:);
[M,I]=min(matrix2(1:25,2));
matrix2=matrix2(I:end,:);
[M,I]=min(matrix3(1:25,2));
matrix3=matrix3(I:end,:);
size1=size(matrix1);
size2=size(matrix2);
size3=size(matrix3);
min_size=min([size1(1) size2(1) size3(1)]);
matrix1=matrix1(1:min_size,:);
matrix2=matrix2(1:min_size,:);
matrix3=matrix3(1:min_size,:);
x1=matrix1(:,1);
y1=matrix1(:,2);
x2=matrix2(:,1);
y2=matrix2(:,2);
x3=matrix3(:,1);
y3=matrix3(:,2);
bigX=[x1 y1 x2 y2 x3 y3];
bigX=bigX';
t=1:min_size;

subplot(3,1,1)
plot(t,bigX(1,:),t,bigX(2,:))
xlabel('Frame number'); ylabel('Displacement(pixel)')
title('Camera 1')
legend('z','x-y plane')
subplot(3,1,2)
plot(t,bigX(3,:),t,bigX(4,:))
xlabel('Frame number'); ylabel('Displacement(pixel)')
legend('z','x-y plane')
title('Camera 2')
subplot(3,1,3)
plot(t,bigX(6,:),t,bigX(5,:))
xlabel('Frame number'); ylabel('Displacement(pixel)')
legend('z','x-y plane')
title('Camera 3')

meandata=zeros(6,1);
for i=1:6
   meandata(i,1)=mean(bigX(i,:)); 
end
bigX=bigX-meandata;
subplot(2,1,1)
[U,S,V]=svd(bigX);
sig=diag(S);
plot(sig.^2/sum(sig.^2),'bo','Linewidth',1.5)
xlabel('Mode'); ylabel('Energy captured(%)')
subplot(2,1,2)
plot(t,S*V')
xlabel('Frame number'); ylabel('Displacement(pixel)')
legend('mode1','mode2','mode3','mode4','mode5','mode6')

%% Case 3
clear all;close all;clc
load('cam1_3.mat')
%implay(vidFrames1_3)
load('cam2_3.mat')
%implay(vidFrames2_3)
load('cam3_3.mat')
%implay(vidFrames3_3)
frame_num1=size(vidFrames1_3,4);
frame_num2=size(vidFrames2_3,4);
frame_num3=size(vidFrames3_3,4);
matrix1=[];
matrix2=[];
matrix3=[];
for i=1:frame_num1
    gray_imag=double(rgb2gray(vidFrames1_3(:,:,:,i)));
    gray_imag(:,1:260)=0;
    gray_imag(:,400:640)=0;
    gray_imag(1:200,270:380)=0;
    Max=max(gray_imag(:));
    [x,y]=find(gray_imag>0.9*Max);
    matrix1=[matrix1;mean(x),mean(y)];  
end
for i=1:frame_num2
    gray_imag=double(rgb2gray(vidFrames2_3(:,:,:,i)));
    gray_imag(:,1:200)=0;
    gray_imag(:,450:680)=0;
    gray_imag(1:160,200:450)=0;
    Max=max(gray_imag(:));
    [x,y]=find(gray_imag>0.9*Max);
    matrix2=[matrix2;mean(x),mean(y)];  
end
for i=1:frame_num3
    gray_imag=double(rgb2gray(vidFrames3_3(:,:,:,i)));
    gray_imag(:,1:200)=0;
    gray_imag(:,500:680)=0;
    gray_imag(1:100,200:500)=0;
    gray_imag(350:480, 200:500)=0;
    Max=max(gray_imag(:));
    [x,y]=find(gray_imag>240);
    matrix3=[matrix3;mean(x),mean(y)];  
end

[M,I]=min(matrix1(1:25,2));
matrix1=matrix1(I:end,:);
[M,I]=min(matrix2(1:25,2));
matrix2=matrix2(I:end,:);
[M,I]=min(matrix3(1:25,2));
matrix3=matrix3(I:end,:);
size1=size(matrix1);
size2=size(matrix2);
size3=size(matrix3);
min_size=min([size1(1) size2(1) size3(1)]);
matrix1=matrix1(1:min_size,:);
matrix2=matrix2(1:min_size,:);
matrix3=matrix3(1:min_size,:);
x1=matrix1(:,1);
y1=matrix1(:,2);
x2=matrix2(:,1);
y2=matrix2(:,2);
x3=matrix3(:,1);
y3=matrix3(:,2);
bigX=[x1 y1 x2 y2 x3 y3];
bigX=bigX';
t=1:min_size;

subplot(3,1,1)
plot(t,bigX(1,:),t,bigX(2,:))
xlabel('Frame number'); ylabel('Displacement(pixel)')
title('Camera 1')
legend('z','x-y plane')
subplot(3,1,2)
plot(t,bigX(3,:),t,bigX(4,:))
xlabel('Frame number'); ylabel('Displacement(pixel)')
legend('z','x-y plane')
title('Camera 2')
subplot(3,1,3)
plot(t,bigX(6,:),t,bigX(5,:))
xlabel('Frame number'); ylabel('Displacement(pixel)')
legend('z','x-y plane')
title('Camera 3')

meandata=zeros(6,1);
for i=1:6
   meandata(i,1)=mean(bigX(i,:)); 
end
bigX=bigX-meandata;
subplot(2,1,1)
[U,S,V]=svd(bigX);
sig=diag(S);
plot(sig.^2/sum(sig.^2),'bo','Linewidth',1.5)
xlabel('Mode'); ylabel('Energy captured(%)')
subplot(2,1,2)
plot(t,S*V')
xlabel('Frame number'); ylabel('Displacement(pixel)')
legend('mode1','mode2','mode3','mode4','mode5','mode6')

%% Case 4
clear all;close all;clc
load('cam1_4.mat')
implay(vidFrames1_4)
load('cam2_4.mat')
implay(vidFrames2_4)
load('cam3_4.mat')
implay(vidFrames3_4)

frame_num1=size(vidFrames1_4,4);
frame_num2=size(vidFrames2_4,4);
frame_num3=size(vidFrames3_4,4);
matrix1=[];
matrix2=[];
matrix3=[];
for i=1:frame_num1
    gray_imag=double(rgb2gray(vidFrames1_4(:,:,:,i)));
    gray_imag(:,1:260)=0;
    gray_imag(:,500:680)=0;
    gray_imag(1:200,270:500)=0;
    Max=max(gray_imag(:));
    [x,y]=find(gray_imag>0.8*Max);
    matrix1=[matrix1;mean(x),mean(y)];  
end
for i=1:frame_num2
    gray_imag=double(rgb2gray(vidFrames2_4(:,:,:,i)));
    gray_imag(:,1:200)=0;
    gray_imag(1:100,200:400)=0;
    gray_imag(:,450:680)=0;
    gray_imag(400:480,200:400)=0;
    Max=max(gray_imag(:));
    [x,y]=find(gray_imag>0.9*Max);
    matrix2=[matrix2;mean(x),mean(y)];  
end
for i=1:frame_num3
    gray_imag=double(rgb2gray(vidFrames3_4(:,:,:,i)));
    gray_imag(:,1:200)=0;
    gray_imag(:,600:640)=0;
    gray_imag(1:100,:)=0;
    gray_imag(350:480, :)=0;
    Max=max(gray_imag(:));
    [x,y]=find(gray_imag>230);
    matrix3=[matrix3;mean(x),mean(y)];  
end

[M,I]=min(matrix1(1:25,2));
matrix1=matrix1(I:end,:);
[M,I]=min(matrix2(1:25,2));
matrix2=matrix2(I:end,:);
[M,I]=min(matrix3(1:25,2));
matrix3=matrix3(I:end,:);
size1=size(matrix1);
size2=size(matrix2);
size3=size(matrix3);
min_size=min([size1(1) size2(1) size3(1)]);
matrix1=matrix1(1:min_size,:);
matrix2=matrix2(1:min_size,:);
matrix3=matrix3(1:min_size,:);
x1=matrix1(:,1);
y1=matrix1(:,2);
x2=matrix2(:,1);
y2=matrix2(:,2);
x3=matrix3(:,1);
y3=matrix3(:,2);
bigX=[x1 y1 x2 y2 x3 y3];
bigX=bigX';
t=1:min_size;

subplot(3,1,1)
plot(t,bigX(1,:),t,bigX(2,:))
xlabel('Frame number'); ylabel('Displacement(pixel)')
title('Camera 1')
legend('z','x-y plane')
subplot(3,1,2)
plot(t,bigX(3,:),t,bigX(4,:))
xlabel('Frame number'); ylabel('Displacement(pixel)')
legend('z','x-y plane')
title('Camera 2')
subplot(3,1,3)
plot(t,bigX(6,:),t,bigX(5,:))
xlabel('Frame number'); ylabel('Displacement(pixel)')
legend('z','x-y plane')
title('Camera 3')

meandata=zeros(6,1);
for i=1:6
   meandata(i,1)=mean(bigX(i,:)); 
end
bigX=bigX-meandata;
subplot(2,1,1)
[U,S,V]=svd(bigX);
sig=diag(S);
plot(sig.^2/sum(sig.^2),'bo','Linewidth',1.5)
xlabel('Mode'); ylabel('Energy captured(%)')
subplot(2,1,2)
plot(t,S*V')
xlabel('Frame number'); ylabel('Displacement(pixel)')
legend('mode1','mode2','mode3','mode4','mode5','mode6')
    








    
    