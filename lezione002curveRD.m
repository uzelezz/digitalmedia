clear; clc;

mkdir('sandbox');
cd('sandbox');

% Sperimentazioni JPEG
filename = '../dataset/LF_Bike_Central/007_007.ppm';
F = dir(filename);
sizeoriginale = F.bytes * 8; % Dimensioni del file in ingresso

S = imread(filename);

W = size(S,2);
H = size(S,1);
c = size(S,3); % Numero di canali 

X = double(S) / double(max(S(:))); % Segnale normalizzato

quality = [ 10 20  40 60 80 100 ];
for i = 1:length(quality)
    q = quality(i);
    imwrite(X,'compresso.jpg','quality',q);
    F = dir('compresso.jpg');
    sizecompresso = F.bytes * 8;
    RD(i,1) = sizecompresso / (W*H); % bpp del file compresso
    D = imread('compresso.jpg');
    Y = uint16(  double(D)/255*65535  );
    RD(i,2) = psnr(S,Y);
    RD(i,3) = ssim(S,Y);
end


% Sperimentazioni JPEG2000
cr = [ 1:20:100 ];
for i = 1:length(cr)
    cri = cr(i);
    imwrite(S,'compresso.j2k','CompressionRatio',cri);
    F = dir('compresso.j2k');
    sizecompresso = F.bytes * 8;
    RD2(i,1) = sizecompresso / (W*H); % bpp del file compresso JPEG 2000
    D = imread('compresso.j2k');
    RD2(i,2) = psnr(S,D);
    RD2(i,3) = ssim(S,D);
end

% Lossless
imwrite(S,'noncompresso.j2k','Mode','Lossless');
F = dir('noncompresso.j2k');
sizenoncompresso = F.bytes * 8;
RD3X = sizenoncompresso / (W*H);
RD3Y = 500; % !!! ATTEZIONE IL VOLORE E' INFINITO, 500 SERVE PER AVERE UN PUNTO SUL GRAFICO


figure; 
plot(RD(:,1),RD(:,2),'*-');
title('RD PSNR');
hold on
plot(RD2(:,1),RD2(:,2),'+-');
hold on
%plot(RD3X,RD3Y,'X');
grid on
legend('JPEG','JPEG2000');
xlabel('bpp')
ylabel('PSNR (dB)');

figure; 
plot(RD(:,1),RD(:,3),'*-');
title('RD SSIM');
hold on
plot(RD2(:,1),RD2(:,3),'+-');
grid on
legend('JPEG','JPEG2000');
xlabel('bpp')
ylabel('SSIM');
