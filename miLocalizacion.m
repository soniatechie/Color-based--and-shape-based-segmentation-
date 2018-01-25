function [ pos,ori ] = miLocalizacion(imgb)
s = regionprops(imgb,'centroid','orientation','MajorAxisLength');
pos = cat(1, s.Centroid);
ori= cat(1, s.Orientation);
figure, imshow(imgb);
hold on
plot(pos(:,1),pos(:,2), 'b*')
for i=1:length(s)
hlen = s(i).MajorAxisLength/5;
xcoords = pos(i,1) + hlen * [cosd(ori(i)) -cosd(ori(i))];
ycoords = pos(i,2) + hlen * [-sind(ori(i)) sind(ori(i))];
line(xcoords, ycoords);
end
hold off
end