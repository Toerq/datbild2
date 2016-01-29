image = imread('van.tif');
image = double(image);

filtersize = [5 5];
h = fspecial('gaussian', filtersize,2);
hx = fspecial('gaussian', [1 filtersize(2)],2);
hy = fspecial('gaussian', [filtersize(1) 1],2);
h_high = fspecial('gaussian', filtersize,5);

%% 2
tic;
result = conv2(h,image);
time_1 = toc;

tic;
result2 = conv2(hx,hy,image);
time_2 = toc;


subplot(1,2,1);
imagesc(result/255);

subplot(1,2,2);
imagesc(result2);
%% 3
h_low = fspecial('gaussian', filtersize,1);
h_high_ = fspecial('gaussian', filtersize,5);
im_low_dev = conv2(h_low,image);
im_high_dev = conv2(h_high_,image);
subplot(1,2,1);
imshow(im_low_dev/255);
title('Low std deviation');
subplot(1,2,2);
imshow(im_high_dev/255);
title('High std deviation');
%% 4
im_low = conv2(h, image);
im_high = conv2(h_high, image);

DoG_lowminushigh = im_low - im_high;
DoG_highminuslow = im_high - im_low;

subplot(1,2,1);
imagesc(DoG_lowminushigh);
title('Low - high');
subplot(1,2,2);
imagesc(DoG_highminuslow);
title('High - low');



