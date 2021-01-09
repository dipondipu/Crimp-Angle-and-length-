function [output,L] = crimplength(azim, res,locat,name) 

azim = double(azim); 
% azim = abs(J_az90-90);

[x_s, y_s] = size(azim);

for i = 1:y_s
    
     avg_azim(1,i) = nanmean(azim(1:x_s,i));
end


  
  line = linspace(1,y_s,y_s);
    
 [fitresult, gof,yfitted] = Peaksmoother(line, avg_azim);
 
    [pks,locs,w,p] = findpeaks(yfitted,'MinPeakProminence',10,'MinPeakDistance',10);
 
    [pks_low, locs_low, w_low, p_low] = findpeaks(-yfitted,'MinPeakProminence',10,'MinPeakDistance',10);
    
    figure, 
    
    plot(yfitted,'color','red')
    ylabel('Orientation angle')
    hold on 
plot(avg_azim, 'color','blue')
    plot (locs,pks,'s','MarkerSize',10,...
    'MarkerEdgeColor','red',...
    'MarkerFaceColor',['red'])
 plot (locs_low,-pks_low,'s','MarkerSize',10,...
    'MarkerEdgeColor','blue',...
    'MarkerFaceColor','blue')

legend('fitted','original','peaks','valleys','Location','eastoutside')
title(strrep(name,'_',' '));

print(strcat(locat,'\',name,'_peaks_and_valleys'),'-dpng','-r400')

for i= 1:length(locs)-1
 crimplength_high(1,i) = abs(locs(i)-locs(i+1));
end


for i= 1:length(locs_low)-1
 crimplength_low(1,i) = abs(locs_low(i)-locs_low(i+1));
end




for i = 1:length(locs)
    
    high_value(i) = avg_azim(locs(i));

end

for i = 1:length(locs_low)
    
        low_value(i) = avg_azim(locs_low(i));

end

avg_low = mean(low_value(:));
avg_high = mean(high_value(:));

crimp_ang = abs(avg_low-avg_high);


L = crimp_ang;


crimplength_low_avg = mean(crimplength_low(:));
crimplength_high_avg = mean(crimplength_high(:));

 
output = (crimplength_low_avg+crimplength_high_avg)/2*res;

screensize = get( groot, 'Screensize' );

 figure

imshow(azim,[0,90])
colormap(parula)


c = colorbar;
c.Ticks = [0 90]
c.TickLabels = {['0' char(176)],['90' char(176)]}
hold on 

normline = avg_azim/90.*x_s;
normlineflip = flipud(normline);
plot(flipud(normline), 'color','blue')



for i = 1:length(locs)
            high_norm(i) = normline(locs(i));
end
for i = 1:length(locs_low)
            low_norm(i) = normline(locs_low(i));
end
plot (locs,high_norm,' cx','MarkerSize',10,...
    'MarkerEdgeColor','red',...
    'MarkerFaceColor','red')
plot (locs_low,low_norm,' cx','MarkerSize',10,...
    'MarkerEdgeColor','blue',...
    'MarkerFaceColor','blue')

ax = gca;
axis on
ax.YDir = 'normal'
% y_ticks = linspace(1,x_s,3)
 ax.YTick = [];
% ax.YLabel = 'µm'
% y_ticks_res =string( y_ticks*res);
% ax.YTickLabel= y_ticks_res

x_ticks = linspace(1,y_s,5)
ax.XTick = x_ticks;
xlabel('sample length [µm]')
x_ticks_res =string( x_ticks*res);
ax.XTickLabel= x_ticks_res




set(gcf, 'Position',  [100 100 screensize(3)-200 (screensize(3))*(x_s/(0.6*y_s))])

print(strcat(locat,'\',name,'_crimp'),'-dpng','-r400')




% output = mean(crimplength(:))*res;

