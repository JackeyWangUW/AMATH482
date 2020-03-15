

%% Test case 1
clear all;close all;clc

path='C:\Users\jacke\OneDrive\Documents\MATLAB\AMATH482HW4\Deng';
file=dir(path);
songs={file.name};
songs=songs(3:end);
dengdata=[];
for i=1:20
    filename=strcat(path,'\',char(songs(i)));
    [y,Fs]=audioread(filename);
%    sound(y,Fs)
    y=resample(y,Fs/4,Fs);
%   sound(y,Fs/4)
    dengdata=[dengdata y];
end

path='C:\Users\jacke\OneDrive\Documents\MATLAB\AMATH482HW4\Liang';
file=dir(path);
songs={file.name};
songs=songs(3:end);
liangdata=[];
for i=1:20
    filename=strcat(path,'\',char(songs(i)));
    [y,Fs]=audioread(filename);
%    sound(y,Fs)
    y=resample(y,Fs/4,Fs);
%   sound(y,Fs/4)
    liangdata=[liangdata y];
end

path='C:\Users\jacke\OneDrive\Documents\MATLAB\AMATH482HW4\Zhou';
file=dir(path);
songs={file.name};
songs=songs(3:end);
zhoudata=[];
for i=1:20
    filename=strcat(path,'\',char(songs(i)));
    [y,Fs]=audioread(filename);
%    sound(y,Fs)
    y=resample(y,Fs/4,Fs);
%   sound(y,Fs/4)
    zhoudata=[zhoudata y];
end


deng_spec=spect(dengdata);
liang_spec=spect(liangdata);
zhou_spec=spect(zhoudata);
[U,S,V,threshold1,threshold2,w,m1,m2,m3]=music_trainer(deng_spec,liang_spec,zhou_spec,56);







%% Test case 2
clear all;close all;clc

path='C:\Users\jacke\OneDrive\Documents\MATLAB\AMATH482HW4\AliceInChains';
file=dir(path);
songs={file.name};
songs=songs(3:end);
AliceInChainsdata=[];
for i=1:20
    filename=strcat(path,'\',char(songs(i)));
    [y,Fs]=audioread(filename);
%    sound(y,Fs)
    y=resample(y,Fs/4,Fs);
%   sound(y,Fs/4)
    AliceInChainsdata=[AliceInChainsdata y];
end

path='C:\Users\jacke\OneDrive\Documents\MATLAB\AMATH482HW4\PearlJam';
file=dir(path);
songs={file.name};
songs=songs(3:end);
PearlJamdata=[];
for i=1:20
    filename=strcat(path,'\',char(songs(i)));
    [y,Fs]=audioread(filename);
%    sound(y,Fs)
    y=resample(y,Fs/4,Fs);
%   sound(y,Fs/4)
    PearlJamdata=[PearlJamdata y];
end

path='C:\Users\jacke\OneDrive\Documents\MATLAB\AMATH482HW4\Soundgarden';
file=dir(path);
songs={file.name};
songs=songs(3:end);
Soundgardendata=[];
for i=1:20
    filename=strcat(path,'\',char(songs(i)));
    [y,Fs]=audioread(filename);
%    sound(y,Fs)
    y=resample(y,Fs/4,Fs);
%   sound(y,Fs/4)
    Soundgardendata=[Soundgardendata y];
end


AliceInChains_spec=spect(AliceInChainsdata);
PearlJam_spec=spect(PearlJamdata);
Soundgarden_spec=spect(Soundgardendata);
[U,S,V,threshold1,threshold2,w,m1,m2,m3]=music_trainer(AliceInChains_spec,PearlJam_spec,Soundgarden_spec,30);






%% Test case 3
clear all;close all;clc

path='C:\Users\jacke\OneDrive\Documents\MATLAB\AMATH482HW4\country';
file=dir(path);
songs={file.name};
songs=songs(3:end);
countrydata=[];
for i=1:20
    filename=strcat(path,'\',char(songs(i)));
    [y,Fs]=audioread(filename);
%    sound(y,Fs)
    y=resample(y,Fs/4,Fs);
%   sound(y,Fs/4)
    countrydata=[countrydata y];
end

path='C:\Users\jacke\OneDrive\Documents\MATLAB\AMATH482HW4\hiphop';
file=dir(path);
songs={file.name};
songs=songs(3:end);
hiphopdata=[];
for i=1:20
    filename=strcat(path,'\',char(songs(i)));
    [y,Fs]=audioread(filename);
%    sound(y,Fs)
    y=resample(y,Fs/4,Fs);
%   sound(y,Fs/4)
    hiphopdata=[hiphopdata y];
end

path='C:\Users\jacke\OneDrive\Documents\MATLAB\AMATH482HW4\jazz';
file=dir(path);
songs={file.name};
songs=songs(3:end);
jazzdata=[];
for i=1:20
    filename=strcat(path,'\',char(songs(i)));
    [y,Fs]=audioread(filename);
%    sound(y,Fs)
    y=resample(y,Fs/4,Fs);
%   sound(y,Fs/4)
    jazzdata=[jazzdata y];
end
country_spec=spect(countrydata);
hiphop_spec=spect(hiphopdata);
jazz_spec=spect(jazzdata);
[U,S,V,threshold1,threshold2,w,m1,m2,m3]=music_trainer(country_spec,hiphop_spec,jazz_spec,25);




%% Test classifier
clc
%path='C:\Users\jacke\OneDrive\Documents\MATLAB\AMATH482HW4\test1';
%path='C:\Users\jacke\OneDrive\Documents\MATLAB\AMATH482HW4\test2';
path='C:\Users\jacke\OneDrive\Documents\MATLAB\AMATH482HW4\test3';
file=dir(path);
songs={file.name};
songs=songs(3:end);
testdata=[];
for i=1:15
    filename=strcat(path,'\',char(songs(i)));
    [y,Fs]=audioread(filename);
%    sound(y,Fs)
    y=resample(y,Fs/4,Fs);
%   sound(y,Fs/4)
    testdata=[testdata y];
end

test_spec=spect(testdata);
testMat=U'*test_spec;
pval=w'*testMat;
testresult=[];
for i=1:size(pval,2)
    if pval(i)<threshold1
        testresult=[testresult 1];
    elseif pval(i)>threshold1 && pval(i)<threshold2
        testresult=[testresult 2];
    else   
        testresult=[testresult 3] ;         
    end
end
%answer=[1 1 1 1 1 3 3 3 3 3 2 2 2 2 2];   %for test 1
%answer=[1 2 2 2 1 2 3 3 3 3 1 3 1 1 2];  %for test 2
answer=[2 3 2 3 1 1 3 3 2 2 1 3 1 1 2];  %for test 3
yes=0;
for i=1:15
    if answer(i)==testresult(i);
        yes=yes+1;
    end
end
disp('Rate of success');
sucRate = yes/15


Country1=U'*country_spec;
Country=w'*Country1;
Hiphop1=U'*hiphop_spec;
Hiphop=w'*Hiphop1;
Jazz1=U'*jazz_spec;
Jazz=w'*Jazz1;


%%

function [U,S,V,threshold1,threshold2,w,m1,m2,m3]=music_trainer(country0,hiphop0,jazz0,feature)
    nc=size(country0,2);
    nh=size(hiphop0,2);
    nj=size(jazz0,2);
    [U,S,V]=svd([country0 hiphop0 jazz0],'econ');
    %plot(diag(S)/sum(diag(S)), 'ro', 'Linewidth', 2)
    music=S*V'; %projection onto principal components
    U=U(:,1:feature);
    country=music(1:feature,1:nc);
    hiphop=music(1:feature,nc+1:nc+nh);
    jazz=music(1:feature,nc+nh+1:nc+nh+nj);
    mc=mean(country,2);
    mh=mean(hiphop,2);
    mj=mean(jazz,2);
    mtotal=mean(music(1:feature,:),2);

    Sw=0;
    for k=1:nc
        Sw=Sw+(country(:,k)-mc)*(country(:,k)-mc)';
    end
    for k=1:nh
        Sw=Sw+(hiphop(:,k)-mh)*(hiphop(:,k)-mh)';
    end
    for k=1:nj
        Sw=Sw+(jazz(:,k)-mj)*(jazz(:,k)-mj)';
    end

    Sb=nc.*(mc-mtotal)*(mc-mtotal)'+nh.*(mh-mtotal)*(mh-mtotal)'+nj.*(mj-mtotal)*(mj-mtotal)';

    [V2,D]=eig(Sb,Sw);
    [~,ind]=max(abs(diag(D)));
    w=V2(:,ind); w=w/norm(w,2);
    vcountry=w'*country;
    vhiphop=w'*hiphop;
    vjazz=w'*jazz;
    m1=mean(vcountry);
    m2=mean(vhiphop);
    m3=mean(vjazz);
    if m1==max([m1 m2 m3])
        if m2==min([m1 m2 m3])
            [threshold1,threshold2]=thresh(vhiphop,vjazz,vcountry);
        else
            [threshold1,threshold2]=thresh(vjazz,vhiphop,vcountry);  
        end       
    elseif m2==max([m1 m2 m3])
        if m1==min([m1 m2 m3])
            [threshold1,threshold2]=thresh(vcountry,vjazz,vhiphop);
        else
            [threshold1,threshold2]=thresh(vjazz,vcountry,vhiphop);   
        end
    else 
        if m1==min([m1 m2 m3])
            [threshold1,threshold2]=thresh(vcountry,vhiphop,vjazz);
        else
            [threshold1,threshold2]=thresh(vhiphop,vcountry,vjazz);   
        end
    end
 end   

% find two thresholds
function [threshold1,threshold2]=thresh(mi,me,ma)     
   
    sortmi=sort(mi);
    sortme=sort(me);
    t1 = length(sortmi);
    t2 = 1;
    while sortmi(t1)>sortme(t2)
        t1 = t1-1;
        t2 = t2+1;
    end
    threshold1 = (sortmi(t1)+sortme(t2))/2; 
           
    sortme=sort(me);
    sortma=sort(ma);
    t1 = length(sortme);
    t2 = 1;
    while sortme(t1)>sortma(t2)
        t1 = t1-1;
        t2 = t2+1;
    end
    threshold2 = (sortme(t1)+sortma(t2))/2;               
end
    
% spectrogram function
function spe=spect(data)
    spe=[];
    for i=1:size(data,2)
        spe(:,i)=reshape(abs(spectrogram(data(:,i))),[],1);  
    end      
end









