% DMdecoder
%
% (output.dm.zip) -> Entropy decoding -> (tmp.dat) -> Inverse quantization
% -> Inverse Transform -> Y' (decoded signal)
%

% step = 5; % Noto sia all'encoder che al decoder



inputfile = "output.dm.zip";

Qdec = entropydecoding(inputfile,H,W);

Tdec = dequantize(Qdec,step);

Ydec = inversetransform(Tdec);

%=== END CODING===

function Y = inversetransform( X )
       Y = uint16(idct2(X)*65535);
end

function Y = dequantize( X, step )
       Y = double(X) / 64 * step;
end

function Y = entropydecoding( inputfile, H, W )
    unzip(inputfile);
    fid = fopen("tmp.dat","r");
    Y = fread(fid,[H W],"int16=>int16");
    fclose(fid);
end