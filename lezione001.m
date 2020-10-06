S = imread('dataset/LF_Bike_Central/007_007.pgm');

imwrite(S,'testBINARY.pgm','Encoding','rawbits');  

imwrite(S,'testBINARY.pgm','Encoding','ascii');  

S1 = imread('dataset/LF_Bike_Central/007_007.ppm');

imwrite(S,'testBINARY2.ppm','Encoding','rawbits');  

imwrite(S,'testBINARY2.ppm','Encoding','ascii');  

ROSSO = S1(:,:,1);

VERDE = S1(:,:,2);

BLU = S1(:,:,3);

figure; imshow([ ROSSO VERDE BLU ]);

S3 = cat(3,BLU ,VERDE, ROSSO);

figure; imshow([S1 S3]);