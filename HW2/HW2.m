clear all; close all; clc
load handel
v = y';
% v=v(1:length(v)-1);
t=(1:length(v))/Fs;
%figure(1)
% plot(t,v);
% xlabel('Time [sec]');
% ylabel('Amplitude');
% title('Signal of Interest, v(n)');
L=round(max(t)); n=length(v);
t2=linspace(0,L,n+1); t=t2(1:n); 
k=(1/L)*[0:(n-1)/2 -(n-1)/2:-1]; 
ks=fftshift(k);


% Spectrograms for varying window sizes
a_vec = [0.1 2 20];
for jj = 1:1
    a = a_vec(jj);
    tslide=0:0.1:L;
    Sgt_spec = zeros(length(tslide),n);
    Sgt_spec = [];
    for j=1:length(tslide)
        g=exp(-a*(t-tslide(j)).^2); 
        Sg=g.*v; 
        Sgt=fft(Sg); 
        Sgt_spec(j,:) = fftshift(abs(Sgt)); 
    end
%     figure(jj)
%     pcolor(tslide,ks,Sgt_spec.'), 
%     shading interp 
%     set(gca,'Fontsize',16) 
%     colormap(hot)Fs
%     title(['a = ',num2str(a)],'Fontsize',12)
%     xlabel('Time(s)','FontSize', 12), ylabel('Frequency (Hz)','FontSize', 12)
%     pause(2)
end


%% Spectrograms for varying translations
trans=[0.03];
for jj=1:length(trans)
    a = 30;
    tslide=0:trans(jj):L;
    Sgt_spec = zeros(length(tslide),n);
    Sgt_spec = [];
    for j=1:length(tslide)
        g=exp(-a*(t-tslide(j)).^2); 
        Sg=g.*v; 
        Sgt=fft(Sg); 
        Sgt_spec(j,:) = fftshift(abs(Sgt)); 
    end
    figure(jj)
    pcolor(tslide,ks,Sgt_spec.'), 
    shading interp 
    set(gca,'Fontsize',16) 
    colormap(hot)
    title(['Translation=',num2str(trans(jj))],'Fontsize',12)
    xlabel('Time(s)','FontSize', 12), ylabel('Frequency (Hz)','FontSize', 12)
end
    

%% Different Gabor windows
for jj = 1:length(a_vec)
    a = 1;
    tslide=0:0.1:L;
    Sgt_spec = zeros(length(tslide),n);
    Sgt_spec = [];
    for j=1:length(tslide)
        % Gaussian 
        g=exp(-a*(t-tslide(j)).^2); 
        % Mexican hat
        g=(1-((t-tslide(j))/a).^2).*exp(-((t-tslide(j))/a).^2)/2;
        % Step-function(Shannon)
        g=(x>-a/2 & x<a/2);
        Sg=g.*v; 
        Sgt=fft(Sg); 
        Sgt_spec(j,:) = fftshift(abs(Sgt)); 
    end
    figure(jj)
    pcolor(tslide,ks,Sgt_spec.'), 
    shading interp 
    set(gca,'Fontsize',16) 
    colormap(hot)
    title(['a = ',num2str(a)],'Fontsize',12)
    xlabel('Time(s)','FontSize', 12), ylabel('Frequency (Hz)','FontSize', 12)
    pause(2)
end

%% Part 2
clear all; close all;clc
opengl('save', 'software')
[y,Fs] = audioread('music1.wav');
tr_piano=length(y)/Fs; % record time in seconds
%plot((1:length(y))/Fs,y);
%xlabel('Time [sec]'); ylabel('Amplitude');
%title('Mary had a little lamb (piano)');
%p8 = audioplayer(y,Fs); playblocking(p8);
v=y';
L=round(tr_piano);
n=length(y);
t2=linspace(0,L,n+1); t=t2(1:n); 
k=(1/L)*[0:n/2-1 -n/2:-1];
ks=fftshift(k);
a =40;
tslide=0:0.2:L;
Sgt_spec = zeros(length(tslide),n);
Sgt_spec = [];
for j=1:length(tslide)
    g=exp(-a*(t-tslide(j)).^2); 
    Sg=g.*v; 
    Sgt=fft(Sg); 
    Sgt_spec(j,:) = fftshift(abs(Sgt))/max(abs(Sgt)); 
end
figure(1)
pcolor(tslide,ks,Sgt_spec.'), 
shading interp 
set(gca,'Fontsize',16) 
colormap(hot)
xlabel('Time(s)','FontSize', 12), ylabel('Frequency (Hz)','FontSize', 12)









    


