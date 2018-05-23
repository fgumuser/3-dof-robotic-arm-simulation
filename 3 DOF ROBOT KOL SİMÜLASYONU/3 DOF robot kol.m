%Girilen joint açýlarýna göre, 3 DOF robot kolun ileri kinematiðinin
%simülasyonu programýnýn MATLAB kodlarý.

% Ýlk pozisyonlarý göstermeden önce giriþlerin girilmesi istenir.
% Her bir açý sýrayla alt alta girilerek "enter" a basýlýr
fprintf('Teta 1, teta 2, teta 3 açýlarýný giriniz:\n');
% t1, t2, t3 parametreleri joint açýlarýdýr. 
t1 = input('');
t2 = input('');
t3 = input('');

% 3 kolun jointlerinin baþlangýç pozisyonlarý(orijine uzaklýklarý)
x = [0 2 3.5 4.5];
y = [0 0 0 0];

% baþlangýç pozisyonlarýndan itibaren, girilen açýlara göre jointlerin
% hareketlerini çizer.
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

% eksenlerin sýnýr deðerleri belirlenir
axis([-5 5 -5 5]);

% Joint açýlarý radyana çevrilir

t1 = t1 * (pi / 180);
t2 = t2 * (pi / 180);
t3 = t3 * (pi / 180);

% Önceki ve sonraki x eksenleri arasýndaki açýlar theta ile gösterilir.
theta1 = t1;
theta2 = t2;
theta3 = t3;

% 3 açýnýn çarpýmý ile EKOK bulunur.
theta = theta1 * theta2 * theta3;

% Açýlarýn negatif deðerleri için hesaplama
% (theta'yý pozitif yapmak için)
if theta < 0
    theta = -theta;
end

% Animasyonlarý elde etmek için bir for döngüsü oluþturulur.

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
    % Link uzunluklarý
    T2 = Translate(2);
    T3 = Translate(1.5);
    T4 = Translate(1);

    % Ýkinci noktayý bulma
    
    % Transformasyon matrisi
    Y = R1 * T2;
    
    % Yeni koordinatlarý bulma
    Y1 = Y * [0; 0; 0; 1];
    x(2) = Y1(1);
    y(2) = Y1(2);

    % Üçüncü noktayý bulma
    
    % Transformasyon matrisi
    Y = R1 * T2 * R2 * T3;
    
    % Yeni koordinatarý bulma
    Y1 = Y * [0; 0; 0; 1];
    x(3) = Y1(1);
    y(3) = Y1(2);

    % Dördüncü noktayý bulma
    
    % Transformasyon matrisi
    Y = R1 * T2 * R2 * T3 * R3 * T4;
    
    % Yeni koordinatlarý bulma
    Y1 = Y * [0; 0; 0; 1];
    x(4) = Y1(1);
    y(4) = Y1(2);
    
    % link hareket ettikçe simülasyondaki görüntüsünde, anlýk olarak deðiþen 
    % çizgilerin eskisinin silinmesi.
    delete(l);
    delete(l5);
    delete(l6);
    delete(l7);
    delete(l8);
    % Hesaplanan deðerlere göre axes üzerinde simülasyonun görüntülenmesi
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
    % Yeni iterasyona geçmeden önce 0.01 saniye beklenir.
    pause(0.01);
end