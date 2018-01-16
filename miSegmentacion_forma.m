function [numforma,imgd]=miSegmentacion_forma(imgo,forma)
%miSegmentacion_forma Summary of this function goes here
%   Detailed explanation goes here
%tic
%%%%%%%Esto se hará en otro sitio pero lo dejo aquí para las pruebas
%imagen = imread(imgo);
%imgo=imcomplement(imbinarize(rgb2gray(imagen)));
%figure(1), imshow(imgb);
%%%%%%hasta aquí

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