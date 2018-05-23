function [ T ] = Translate( d )
%Translasyon matrisinin fonksiyonu.

T = [1 0 0 d;
    0 1 0 0;
    0 0 1 0;
    0 0 0 1];
end