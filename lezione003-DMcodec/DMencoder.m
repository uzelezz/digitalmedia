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

T = transform(Y);

Q = quantize(T,step); % Quantization error (step > 1)

entropycoding(Q,"output.dm");


%=== END CODING===

function Y = transform( X )
       Y = X;
end

function Y = quantize( X, step )
       Y = X/step;
end

function entropycoding( X, outfile )
    %E = entropy(uint16(X(:)));
    %disp(E);
    fid = fopen("tmp.dat","w");
    fwrite(fid,X,"uint16");
    fclose(fid);
    zip(outfile,'tmp.dat');
end