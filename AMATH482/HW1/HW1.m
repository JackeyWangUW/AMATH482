clear; close all; clc;
load Testdata
L=15; % spatial domain
n=64; % Fourier modes
x2=linspace(-L,L,n+1); x=x2(1:n); y=x; z=x;
k=(2*pi/(2*L))*[0:(n/2-1) -n/2:-1]; ks=fftshift(k);
[X,Y,Z]=meshgrid(x,y,z);
[Kx,Ky,Kz]=meshgrid(ks,ks,ks);
for j=1:1
Un(:,:,:)=reshape(Undata(j,:),n,n,n);
close all, isosurface(X,Y,Z,abs(Un),0.4)
axis([-20 20 -20 20 -20 20]), grid on, drawnow
pause(1)
end

% Apply Fourier Transformation on data and average the spectrum
Utave=zeros(n,n,n);
for j=1:20
   Un(:,:,:)=reshape(Undata(j,:),n,n,n);
   Unt=fftn(Un(:,:,:));
   Utave=Utave+Unt;
end
utave=abs(fftshift(Utave))/20;
utave_normal=utave/max(utave(:));
% Plot the isosurface of averageing over the frequency domain
figure(2)
isosurface(Kx,Ky,Kz,utave_normal,0.6)
grid on
xlabel('Kx');
ylabel('Ky');
zlabel('Kz');
% Find the center frequency 
ind=find(utave_normal==max(utave_normal(:)));
utave_size=size(utave_normal);
index=ind2sub(utave,ind);
cenfrex=Kx(index)
cenfrey=Ky(index)
cenfrez=Kz(index)
% for c=1:n
%     [a,b]=find(utave_normal(:,:,c)==1);
%     if (isempty(a)~=1 && isempty(b)~=1)
%         break
%     end    
% end
% a
% b
% c


% Create the filter and plot the trajectory
filter=exp(-0.2*(Kx-cenfrex).^2).*exp(-0.2*(Ky-cenfrey).^2).*exp(-0.2*(Kz-cenfrez).^2);
traject=zeros(20,3);
for j=1:20
   Un(:,:,:)=reshape(Undata(j,:),n,n,n);
   unt=fftn(Un(:,:,:));
   unft=filter.*fftshift(unt);
   %convert back to time-domain and normalize it
   unft_time_normal=abs(ifftn(unft))/max(abs(ifftn(unft(:))));
   ind=find(unft_time_normal==max(unft_time_normal(:)));
   size2=size(unft_time_normal);
   index=ind2sub(size2,ind);
   traject(j,:)=[X(index),Y(index),Z(index)];  
end
figure(3)
plot3(traject(:,1),traject(:,2),traject(:,3),'o-')
xlabel('x');
ylabel('y');
zlabel('z');
% Output the location of marble at the 20th data measurement
traject(20,:)

   
 


















