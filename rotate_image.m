function [output output2 output3 cmin cmax] = rotate_image(image,azim,azim90)
%    
%   image     - image to be rotated
%   output    - rotated image
%   
%
%   commands:
%  
% 
%   'q'                 - quit and save curent slice
%   '9'                 - rotate 5 degrees clockwise
%   '8'                 - rotate 1 degree clockwise
%   '7'                 - rotate 1 degree anti clockwise
%   '6'                 - rotate 5 degrees anti clockwise
%   'u'                 - increase grayscale upper limit
%   'd'                 - decrease grayscale upper limit


orig_image = image;
[ox ,oy] = size(image);
cmin = min(image(:));
cmax = max(image(:));
% cmin = round(cmax/3);

key = '1';
plot_lims = [1 ox;1 oy];

f=figure();
b_img = imshow(image);
caxis([cmin cmax])
colormap gray;
axis equal


hold on;
sumrotate = 0;

while(not(key == 'q'))
    [x,y,key] = ginput(1);
    x=round(x);
    y=round(y);
   
   if key == '9'
        
                delete(b_img)
                sumrotate = sumrotate -5;  
                
                image =  imrotate(orig_image,sumrotate,'bilinear','crop');
                b_img = imshow(image), axis equal
                caxis([cmin cmax])
           
           disp(['rotation=' num2str(sumrotate) ' degrees'])
           
    
    elseif key == '8'
        
                delete(b_img)
                sumrotate = sumrotate -1;       

                image =  imrotate(orig_image,sumrotate,'bilinear','crop');
                b_img = imshow(image), axis equal
                caxis([cmin cmax])
           
            disp(['rotation=' num2str(sumrotate) ' degrees'])
  
    
    elseif key == '7'
         
                delete(b_img)
                sumrotate = sumrotate +1;  

                image =  imrotate(orig_image,sumrotate,'bilinear','crop');
                b_img = imshow(image), axis equal
                caxis([cmin cmax])
          
            disp(['rotation=' num2str(sumrotate) ' degrees'])
    
    elseif key == '6'
         
        delete(b_img)

     sumrotate = sumrotate +5;  
     image =  imrotate(orig_image,sumrotate,'bilinear','crop');
           
              
                b_img = imshow(image), axis equal
                caxis([cmin cmax])
           
           
            disp(['rotation=' num2str(sumrotate) ' degrees'])
            

 elseif key == 'u'
         
        delete(b_img)    
                
                cmax = cmax+4;
                b_img = imshow(image), axis equal
                caxis([cmin cmax])
           
           

elseif key == 'd'
         
        delete(b_img)    
                
                cmax = cmax-4;
                b_img = imshow(image), axis equal
                caxis([cmin cmax])
           
           
           
    end
end
 output =  imrotate(orig_image,sumrotate,'bilinear','loose');
 output2 =  imrotate(azim,sumrotate,'bilinear','loose');
 output3 =  imrotate(azim90,sumrotate,'bilinear','loose');

close(f);





