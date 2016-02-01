%%7
v = readVTK('hydrogen.vtk');

mean_kernel = ones(3,3,3);
mean_kernel = mean_kernel ./ 27;

v_sp = imnoise(v,'salt & pepper', 0.02);
v_g = imnoise(v,'gaussian', 0, 0.001); %Mean, variance

v_sp_median_filtered = ordfilt3D(v_sp,14);
v_g_gaussian_filtered = imfilter(v_g,mean_kernel);
v_sp_gaussian_filtered = imfilter(v_sp,mean_kernel);
v_g_median_filtered = ordfilt3D(v_g,14);



volrender(v_g_gaussian_filtered);
title('Gaussian noise filtered with 3x3x3 mean filter');

volrender(v_g_median_filtered);
title('Gaussian noise filtered with 3x3x3 median filter');

volrender(v_sp_gaussian_filtered);
title('Salt and pepper noise filtered with 3x3x3 mean filter');

volrender(v_sp_median_filtered);
title('Salt and pepper noise filtered with 3x3x3 median filter');
%% 8
v = readVTK('hydrogen.vtk');
array = cell(27,1);
close all;
for i = 1 : 27
  array{i} = imnoise(v,'gaussian', 0, 0.0001);
  %volrender(array{i});
end

v_total = array{1};
for i = 2:27
    v_total = v_total + array{i};
    end
v_total = v_total / 27;

volrender(v_total);

%% 9

disp()

%% 11
image = imread('coins.png');
subplot(1,3,1);
imshow(image);
subplot(1,3,2);
BW = edge(image,'canny', [0 0.4], 2);
imshow(BW)

lenX = length(image(1,:));
lenY = length(image(:,1));

for(i = 1:lenY)
    for(j = 1:lenX)
        if(BW(i,j) == 1)
            new_image(i,j) = 255;
        else
            new_image(i,j) = image(i,j);
        end
    end
end
    
subplot(1,3,3);
imshow(new_image);
%% 13 249 in course book

% 29 radius in big circle
% 25 radius in small circle
%generate_circle(imsize,radius,pos)

lenX = length(BW(1,:));
lenY = length(BW(:,1));

hough_big = zeros(lenY,lenX);
hough_small = zeros(lenY,lenX);

for(i = 1:lenY)
    for(j = 1:lenX)
        if(BW(i,j) == 1)
            hough_big = hough_big + generate_circle([lenY lenX], 29, [i j]);
            hough_small = hough_small + generate_circle([lenY lenX], 25, [i j]);
        end
    end
end
%% Plot hough
subplot(1,2,1);
imagesc(hough_big);
title('Big coins');
subplot(1,2,2);
imagesc(hough_small);
title('Small coins');
regionprops(hough_big);
%%
new_BW = zeros(lenY,lenX);
L = zeros(1,5); %L = local neighbourhood
incr = 1;
reg_siz = 10;
found = 0;

for(i = 1:lenY)    
    for(j = 1:lenX)        
        val = hough_big(i,j);
        if(val > 70)                       
            for(L_index = 1:length(L(:,1)))              
                Y = L(L_index,1);
                X = L(L_index,2);                               
                if((Y - reg_siz <= i && i < Y + reg_siz) && (X - reg_siz <= j && j < X + reg_siz))                                                                                
                    found = 1;
                    if(L(L_index,5) < val)                        
                        L(L_index,3) = i;
                        L(L_index,4) = j;
                        L(L_index,5) = val;
                    end                    
                    break;                                     
                end
            end
            if(found == 0)
                L = [L;[i j i j val]];
            end
            found = 0;
        end
    end
end
L = L(2:length(L(:,1)),:);
for(i = 1:length(L(:,1)))
    new_BW = new_BW + generate_circle([lenY lenX], 29, [L(i,1) L(i,2)]);
end
imagesc(new_BW);
        
new_image = image;
for(i = 1:lenY)
    for(j = 1:lenX)
        if(new_BW(i,j) == 1)
            new_image(i,j) = 255;
        else
            new_image(i,j) = image(i,j);
        end
    end
end
   
        
        
%            index_Y = find(local(:,1,1,1) >= i)
%            if(isempty(index))
%                local = [local; [i,j,i,j,val]];
%            else
%            index_X = 
%            local(incr) = [i,j,i+5,j+5, max(local(5),hough_big(i,j))];
            %new_BW = new_BW + generate_circle([lenY lenX], 29, [i j]);

            %%
radius = zeros(10,1);
for(i = 1:10)
    radius(i) = Q2_region(i).Area/(2*pi)
end
%%
fprintf('plz');
