% DCT coding ONLY of the first 8x8 block top-left of the image
% Note: a full coded should process all 8x8 blocks in the image.

%W = 625;
%H = 434;

W = 8;
H = 8;

step = 4;

DMencoderdct

d = dir("output.dm.zip");
bitrate = d.bytes * 8 / ( W * H);

DMdecoderdct

QMpsnr = psnr(Y,Ydec)

figure;
t = sprintf("PSNR=%5.2f dB, bpp=%4.2f",QMpsnr,bitrate);
imshow([Y Ydec]);
title(t);
