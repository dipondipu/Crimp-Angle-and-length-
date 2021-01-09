function [output] = crimpangle(azim,fig_name)

azim= double(azim);

to_peak = azim;
from_peak = azim; 

to_peak(to_peak<90) = NaN;
from_peak(from_peak>90) = NaN;

figure('NumberTitle', 'off', 'Name', fig_name);
 subplot(2,2,[1,2])
imshowpair(to_peak,from_peak)
subplot(2,2,3)
quiver(1,1,1,1,'LineWidth',3,'color','g')
set(gca,'Color','k')
set(gca,'XTick',[])
set(gca,'YTick',[])
title('to peak 90-180')
subplot(2,2,4)
quiver(1,1,1,-1,'LineWidth',3,'color','m')
set(gca,'Color','k')
set(gca,'XTick',[])
set(gca,'YTick',[])
title('from peak 0-90')


to_peak_abs = nanmean(to_peak(:))
from_peak_abs = nanmean(from_peak(:))

%crimp angle formula from "Structure and collagen crimp patterns of functionally distinct equine
%tendons, revealed by quantitative polarised light microscopy (qPLM), 2018"
output = 0.5*(to_peak_abs-from_peak_abs)
