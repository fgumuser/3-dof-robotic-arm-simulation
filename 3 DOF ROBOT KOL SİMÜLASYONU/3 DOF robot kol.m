%Girilen joint a��lar�na g�re, 3 DOF robot kolun ileri kinemati�inin
%sim�lasyonu program�n�n MATLAB kodlar�.

% �lk pozisyonlar� g�stermeden �nce giri�lerin girilmesi istenir.
% Her bir a�� s�rayla alt alta girilerek "enter" a bas�l�r
fprintf('Teta 1, teta 2, teta 3 a��lar�n� giriniz:\n');
% t1, t2, t3 parametreleri joint a��lar�d�r. 
t1 = input('');
t2 = input('');
t3 = input('');

% 3 kolun jointlerinin ba�lang�� pozisyonlar�(orijine uzakl�klar�)
x = [0 2 3.5 4.5];
y = [0 0 0 0];

% ba�lang�� pozisyonlar�ndan itibaren, girilen a��lara g�re jointlerin
% hareketlerini �izer.
grid on;
l = line(x, y);
hold on;
l1 = plot(x(1), y(1), '-');
l2 = plot(x(2), y(2), '-');
l3 = plot(x(3), y(3), '-');
l4 = plot(x(4), y(4), '-');
l5 = plot(x(1), y(1), 's');
l6 = plot(x(2), y(2), 's');
l7 = plot(x(3), y(3), 's');
l8 = plot(x(4), y(4), 's');

% eksenlerin s�n�r de�erleri belirlenir
axis([-5 5 -5 5]);

% Joint a��lar� radyana �evrilir

t1 = t1 * (pi / 180);
t2 = t2 * (pi / 180);
t3 = t3 * (pi / 180);

% �nceki ve sonraki x eksenleri aras�ndaki a��lar theta ile g�sterilir.
theta1 = t1;
theta2 = t2;
theta3 = t3;

% 3 a��n�n �arp�m� ile EKOK bulunur.
theta = theta1 * theta2 * theta3;

% A��lar�n negatif de�erleri i�in hesaplama
% (theta'y� pozitif yapmak i�in)
if theta < 0
    theta = -theta;
end

% Animasyonlar� elde etmek i�in bir for d�ng�s� olu�turulur.

for i = 0 : 0.003 : theta
    
    tt1 = (i * theta1) ./ (theta);
    tt2 = (i * theta2) ./ (theta);
    tt3 = (i * theta3) ./ (theta);

    % Transformasyon matrisi

    % Rotasyon matrisi
    R1 = Rotate(tt1);
    R2 = Rotate(tt2);
    R3 = Rotate(tt3);

    % Translation matrisi
    % Link uzunluklar�
    T2 = Translate(2);
    T3 = Translate(1.5);
    T4 = Translate(1);

    % �kinci noktay� bulma
    
    % Transformasyon matrisi
    Y = R1 * T2;
    
    % Yeni koordinatlar� bulma
    Y1 = Y * [0; 0; 0; 1];
    x(2) = Y1(1);
    y(2) = Y1(2);

    % ���nc� noktay� bulma
    
    % Transformasyon matrisi
    Y = R1 * T2 * R2 * T3;
    
    % Yeni koordinatar� bulma
    Y1 = Y * [0; 0; 0; 1];
    x(3) = Y1(1);
    y(3) = Y1(2);

    % D�rd�nc� noktay� bulma
    
    % Transformasyon matrisi
    Y = R1 * T2 * R2 * T3 * R3 * T4;
    
    % Yeni koordinatlar� bulma
    Y1 = Y * [0; 0; 0; 1];
    x(4) = Y1(1);
    y(4) = Y1(2);
    
    % link hareket ettik�e sim�lasyondaki g�r�nt�s�nde, anl�k olarak de�i�en 
    % �izgilerin eskisinin silinmesi.
    delete(l);
    delete(l5);
    delete(l6);
    delete(l7);
    delete(l8);
    % Hesaplanan de�erlere g�re axes �zerinde sim�lasyonun g�r�nt�lenmesi
    l = line(x, y);
    hold on;
    l1 = plot(x(1), y(1), 'r.');
    l2 = plot(x(2), y(2), 'r.');
    l3 = plot(x(3), y(3), 'r.');
    l4 = plot(x(4), y(4), 'ro');
    l1.MarkerSize = 1;
    l2.MarkerSize = 1;
    l3.MarkerSize = 1;
    l4.MarkerSize = 5;
    l5 = plot(x(1), y(1), 'gs');
    l6 = plot(x(2), y(2), 'gs');
    l7 = plot(x(3), y(3), 'gs');
    l8 = plot(x(4), y(4), 'gs');
    axis([-5 5 -5 5]);
    % Yeni iterasyona ge�meden �nce 0.01 saniye beklenir.
    pause(0.01);
end