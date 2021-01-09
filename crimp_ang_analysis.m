clear all 
close all 
clc

%choose folder to save results to 
cur = pwd;
% locat = uigetdir(cur,'E:\PLM Classified\Result');

 locat = 'E:\PLM Classified\Result' 
%for example 'C:\Users\samikaup\DIPONKOR crimp_angle\Results'

%give the pixel resolution of your images (how much one pixel is in micrometers)
res= 0.4954;
%load data for analysis
[file,path] = uigetfile;

name = file(1:end-4)

load(strcat(path,file))
%check data size 
[x_size y_size] = size(ret);

%rotate image to make sure the tendon orientation is straight
[rot_ret,az,az90,cmin, cmax] = rotate_image(ret,az,az90);


[J, rect] = imcrop(rot_ret,[cmin cmax]);

J_az = imcrop(az,rect);
J_az90 = imcrop(az90,rect);

J_az = double(J_az);
J_az90 = double(J_az90);

close all 

%roi dimensions
[x_c, y_c] =size(J);

%allocate line profile data to be created from the region of interest

avg_line = zeros(1,y_c);
avg_line_az = zeros(1,y_c);
avg_line_az90 = zeros(1,y_c);


%create line profiles
for i=1:y_c
    
    avg_line(1,i) = mean(J(1:x_c,i));
    avg_line_az(1,i) = nanmean(J_az(1:x_c,i));
    avg_line_az90(1,i) = nanmean(J_az90(1:x_c,i));
end




%create image to see where profile is created from
figure,

subplot(2,2,1)
imshow(ret,[cmin,cmax])
title('original')
subplot(2,2,2)
imshow(rot_ret,[cmin,cmax])
title('rotated')
hold on 
rectangle('Position',rect,'EdgeColor','r',...
    'LineWidth',1)
hold off
subplot(2,2,3)
imshow(J,[cmin,cmax])
title('cropped')
subplot(2,2,4)
plot(avg_line)
title('retardance profile')

print(strcat(locat,'\',name,'_analysis_location'),'-dpng','-r400')



figure,

subplot(2,3,[1,2])
imshow(J_az,[0,180])
colormap(jet)
colorbar('southoutside')
title('cropped az')

subplot(2,3,3)
plot(avg_line_az)

ylim([0 180])
title('profile az180')

subplot(2,3,[4,5])
imshow(J_az90,[0,90])
colormap(jet)
colorbar('southoutside')
title('cropped az90')

subplot(2,3,6)
plot(avg_line_az90)

ylim([0 90])
title('profile az90')


 crimp = crimpangle(J_az, 'azimuth 0-180'); 
 crimp90 = crimpangle(J_az90, 'azimuth 0-90'); 

%calculate results and plot result images
[crimp_L_90, crimp_angle_90] = crimplength(J_az90, res,locat,name);


result.name = name
% result.crimpangle = crimp
% result.crimplength = crimp_L
% result.crimpangle90 = crimp90
result.crimplength90 = crimp_L_90
% result.crimp_angle = crimp_angle
result.crimp_angle_90 = crimp_angle_90

%save results as csv to resultfolder chosen at the beginning
writetable(struct2table(result), strcat(locat,'\',name,'results.txt'))



