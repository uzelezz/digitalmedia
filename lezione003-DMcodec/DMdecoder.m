% DMdecoder
%
% (output.dm.zip) -> Entropy decoding -> (tmp.dat) -> Inverse quantization
% -> Inverse Transform -> Y' (decoded signal)
%

% step = 5; % Noto sia all'encoder che al decoder

inputfile = "output.dm.zip";

Qdec = entropydecoding(inputfile);

Tdec = dequantize(Qdec,step);

Ydec = inversetransform(Tdec);

%=== END CODING===

function Y = inversetransform( X )
       Y = X;
end

function Y = dequantize( X, step )
       Y = X*step;
end

function Y = entropydecoding( inputfile )
    unzip(inputfile);
    fid = fopen("tmp.dat","r");
    Y = fread(fid,[434 625],"uint16=>uint16");
    fclose(fid);
end