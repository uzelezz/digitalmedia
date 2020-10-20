% DMencoder
%
% S ->(Preprocessing)-> Transform -> Quantization  -> (tmp.dat) -> Entropy
% Coding  -> (output.dm.zip)
% compressed file
%

% step = 5;

S = imread("007_007.ppm");

% Preprocessing
Y = rgb2gray(S);
Y = Y(1:8,1:8);

T = transform(Y);

Q = quantize(T,step); % Quantization error (step > 1)

entropycoding(Q,"output.dm");


%=== END CODING===

function Y = transform( X )
       X1 = double(X)/65535;
       Y = dct2(double(X1));
end

function Y = quantize( X, step )
       Y = int16(64*(X/step));
end

function entropycoding( X, outfile )
    %E = entropy(uint16(X(:)));
    %disp(E);
    fid = fopen("tmp.dat","w");
    fwrite(fid,X,"int16");
    fclose(fid);
    zip(outfile,'tmp.dat');
end