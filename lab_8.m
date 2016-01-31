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




