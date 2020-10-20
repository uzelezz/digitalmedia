W = 625;
H = 434;

step = 30000;

DMencoder

d = dir("output.dm.zip");
bitrate = d.bytes * 8 / ( W * H);

DMdecoder

QMpsnr = psnr(Y,Ydec);

figure;

imshow([Y Ydec]);
