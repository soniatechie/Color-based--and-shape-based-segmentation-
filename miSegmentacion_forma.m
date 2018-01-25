function [numforma,imgd]=miSegmentacion_forma(imgo,forma)
s = regionprops(imgo,'Perimeter','Area','Extent');
CC = bwconncomp(imgo);
for i=1:length(s)
s(i).Compactacion = (s(i).Perimeter)^2/s(i).Area;
end

Compactacion = [s.('Compactacion')];
Extension = [s.('Extent')];

if forma == 1       %circulo
    regionsToKeep = (Compactacion >= 0) & (Compactacion <= 13);
elseif forma == 2   %cuadrado
   regionsToKeep = (Compactacion > 14.6) & (Compactacion <= 18.3)&...
       (Extension>=0.9); 
elseif forma == 3   %triangulo
    regionsToKeep = (Compactacion >= 18.4);
else                %todos las otras formas 
    regionsToKeep = ((Compactacion >= 13) & (Compactacion < 18.4)&...
        (Extension<0.9));
end

idxToKeep = CC.PixelIdxList(regionsToKeep);
idxToKeep = vertcat(idxToKeep{:});

imgd = false(size(imgo));
imgd(idxToKeep) = true;

figure, imshow(imgd);
[L,numforma]=bwlabel(imgd);
end