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
  array{i} = imnoise(v,'gaussian', 0, 0.00001);
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







