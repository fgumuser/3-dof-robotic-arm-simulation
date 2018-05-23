function [ R ] = Rotate( theta )
%Rotasyon matrisinin fonksiyonu
R = [cos(theta) -sin(theta) 0 0;
    sin(theta) cos(theta) 0 0;
    0 0 1 0
    0 0 0 1];
end