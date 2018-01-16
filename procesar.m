%{
Esto se hará en otro sitio pero lo dejo aquí para las pruebas
imagen = imread(imgo);
imgo=imcomplement(imbinarize(rgb2gray(imagen)));
figure(1), imshow(imgb);
hasta aquí
%}
clc,clear,close;
imgd=[];
disp('Hola! Este scrip es capaz de segmentar una imagen mediante diferentes formas geométricas o colores.');
disp('Para continuar pulse cualquier tecla y elija una imagen a procesar.');
pause;
%Abrir imagen desde el explorador de carpetas
[archivo,ruta]=uigetfile('*','Abrir una imagen');
if archivo==0
 return;
else
    if strcmp(ruta,pwd)%si está en la misma ruta del script
        imagen = imread(archivo);
        figure,imshow(imagen);
    else
        addpath(ruta);%si no lo está
        imagen = imread(archivo);
        figure,imshow(imagen);
    end
end
h=msgbox('Se muestra la imagen para verificar que se ha cargado correctamente. ');
waitfor(h);
if isempty(imgd)
    proc=input('Por favor, elija el tipo de procesamiento que desea realizar, 1 COLOR 2 FORMA');
else
    proc=input('Por favor, elija el tipo de procesamiento que desea realizar, 1 COLOR 2 FORMA 3 LOCALIZACIÓN');
end

if proc == 1
    imgo=imagen;
    color=input('Por favor, elija el color a segmentar, 1 ROJO 2 VERDE 3 AZUL 4 OTROS');
    [num,imgd] = miSegmentacion_color(imgo,color);
elseif proc == 2
    imgo=imcomplement(imbinarize(rgb2gray(imagen)));
    forma=input('Por favor, elija la forma a segmentar, 1 CÍRCULO 2 CUADRADO 3 TRIANGULO 4 OTRAS');
    [num,imgd] = miSegmentacion_forma(imgo,forma);
elseif proc == 3 &&  ~isempty(imgd)
    [pos,ori] = miLocalizacion(imgd);
else
    return
end
h=msgbox(sprintf('Se muestra la imagen resultante. \nEl número de figuras detectadas es: %d',num));
waitfor(h);
%{
numcolor imgd = miSegmentacion_color(imgo,color);
numforma imgd = miSegmentacion_forma(imgo,forma);
pos ori = miLocalizacion(imgd);

implementará la lectura de imagen y dónde el usuario podrá escoger el tipo 
de procesamiento que se quiere llevar a cabo 3.1 junto con 3.2, o 3.3, así
como los parámetros necesarios en cada caso tipo de color o tipo de forma.
%}