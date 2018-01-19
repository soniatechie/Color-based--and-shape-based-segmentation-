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
