%NOTA: La variable ‘color’ puede adoptar los valores ‘1’ para rojo, ‘2’ para verde,
%‘3’ para azul y ‘4’ para cualquier otro color.

function [numcolor,imgd]=miSegmentacion_color(imgo,color)%cambiar imagen per imgo
%%%%Esto irá fuera, lo dejo para pruebas
%imagen = imread('plantilla.bmp');
%figure, imshow(imagen);
%%%%%%hasta aquí

I=rgb2hsv(imgo);

if color == 1 %rojo
    hMin = 0.917; hMax = 0.082; %hMin = 0.957; hMax = 0.020;
    sMin = 0.001; sMax = 1.000;
    vMin = 0.000; vMax = 1.000;
    imgd = ((I(:,:,1) >= hMin ) | (I(:,:,1) <= hMax)) & ...
        (I(:,:,2) >= sMin ) & (I(:,:,2) <= sMax) & ...
        (I(:,:,3) >= vMin ) & (I(:,:,3) <= vMax);
elseif color == 2 %verde
    hMin = 0.250; hMax = 0.499; %hMin = 0.195; hMax = 0.442;
    sMin = 0.000; sMax = 1.000;
    vMin = 0.000; vMax = 1.000;
    imgd = (I(:,:,1) >= hMin ) & (I(:,:,1) <= hMax) & ...
        (I(:,:,2) >= sMin ) & (I(:,:,2) <= sMax) & ...
        (I(:,:,3) >= vMin ) & (I(:,:,3) <= vMax);
elseif color == 3 %azul
    hMin = 0.500; hMax = 0.749;
    sMin = 0.000; sMax = 1.000;
    vMin = 0.000; vMax = 1.000;
    imgd = (I(:,:,1) >= hMin ) & (I(:,:,1) <= hMax) & ...
        (I(:,:,2) >= sMin ) & (I(:,:,2) <= sMax) & ...
        (I(:,:,3) >= vMin ) & (I(:,:,3) <= vMax);
else
%grises
    hMin = 0.000; hMax = 0.000;
    sMin = 0.000; sMax = 1.000;
    vMin = 0.000; vMax = 0.999;
%todos los otros colores 
    hMin1 = 0.083; hMax1 = 0.249;%naranja-amarillo
    hMin2 = 0.750; hMax2 = 0.916;%magenta-violeta
    sMin1 = 0.000; sMax1 = 1.000;
    vMin1 = 0.000; vMax1 = 1.000;
    %imdg = grises & otros colores
    imgd = ((I(:,:,1) >= hMin ) & (I(:,:,1) <= hMax) & ...
        (I(:,:,2) >= sMin) & (I(:,:,2) <= sMax) & ...
        (I(:,:,3) >= vMin) & (I(:,:,3) <= vMax))| ...
        (((I(:,:,1) >= hMin1 ) & (I(:,:,1) <= hMax1) | ...
        (I(:,:,1) >= hMin2 ) & (I(:,:,1) <= hMax2)) & ...
        (I(:,:,2) >= sMin1) & (I(:,:,2) <= sMax1) & ...
        (I(:,:,3) >= vMin1) & (I(:,:,3) <= vMax1));
end
figure, imshow(imgd);
[L,numcolor]=bwlabel(imgd);
end