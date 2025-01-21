% [back1,backpath]=uigetfile('*.SPE','Select Image(s)','MultiSelect','on');
% [back2,backpath]=uigetfile('*.SPE','Select Image(s)','MultiSelect','on');
% fid=fopen(strcat(backpath,back1),'r');
% unkdata1=fread(fid,[1024 256],'real*4','l');
% fid=fopen(strcat(backpath,back2),'r');
% unkdata2=fread(fid,[1024 256],'real*4','l');

unkdata1(unkdata1> 8.4077e-41) = NaN;
unkdata2(unkdata2> 8.4077e-41) = NaN;
unkdata3 = unkdata1(:,2)+unkdata2(:,2);

%plot(unkdata1(:,2))
hold on
%plot(unkdata2(:,2))
plot(unkdata3)

P1 = nanstd(unkdata1(:,2))
P2 = nanstd(unkdata2(:,2))
P3 = nanstd(unkdata3)