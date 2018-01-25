clc,clear,close;
imgd=[];
disp('Hola! Este scrip es capaz de segmentar una imagen mediante diferentes formas geométricas o colores.');
disp('Para continuar pulse cualquier tecla y elija una imagen a procesar.');
pause;
archivo=abrir_img_dsd_explorador;
imagen = imread(archivo);
figure,imshow(imagen);
h=msgbox('Se muestra la imagen para verificar que se ha cargado correctamente. ');
waitfor(h);
while true
    eleccion=input('Por favor, elija el tipo de procesamiento que desea realizar, 1 COLOR 2 FORMA 3 LOCALIZACIÓN 4 CAMBIAR IMAGEN 5 SALIR');

    if eleccion == 5 %condición para salir
            break
    else
        if eleccion == 1
            imgo=imagen;
            color=input('Por favor, elija el color a segmentar, 1 ROJO 2 VERDE 3 AZUL 4 OTROS');
            [num,imgd] = miSegmentacion_color(imgo,color);
            h=msgbox(sprintf('Se muestra la imagen resultante. \nEl número de figuras detectadas es: %d',num));
            waitfor(h);
        elseif eleccion == 2
            imgo=imcomplement(imbinarize(rgb2gray(imagen)));
            forma=input('Por favor, elija la forma a segmentar, 1 CÍRCULO 2 CUADRADO 3 TRIANGULO 4 OTRAS');
            [num,imgd] = miSegmentacion_forma(imgo,forma);
            h=msgbox(sprintf('Se muestra la imagen resultante. \nEl número de figuras detectadas es: %d',num));
            waitfor(h);
        elseif eleccion == 3
            if isempty(imgd)
                disp('Elija primero el procesamiento 1 o 2 para tener una imagen donde localizar las figuras.');
            else
                [pos,ori] = miLocalizacion(imgd);
                h=msgbox({'Se muestra la imagen resultante.','La posición y orientación de las figuras es:',sprintf('x= %f; y= %f\n',pos),sprintf('%f\n',ori)});
                waitfor(h);
            end
        elseif eleccion == 4
            archivo=abrir_img_dsd_explorador;
            imagen = imread(archivo);
            figure,imshow(imagen);
            h=msgbox('Se muestra la imagen para verificar que se ha cargado correctamente. ');
            waitfor(h);
            imgd=[];
        else
            disp('Opción no definida.');
        end
    end
end

function [archivo,ruta] = abrir_img_dsd_explorador
%Abrir imagen desde el explorador de carpetas
[archivo,ruta]=uigetfile('*','Abrir una imagen');
if archivo==0
 return;
else
    if ~strcmp(ruta,pwd)%si no está en la misma ruta del script
        addpath(ruta);
    end
end
end