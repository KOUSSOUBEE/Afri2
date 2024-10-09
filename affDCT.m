clc;
clear all;
close all;
% Charger l'image en niveaux de gris
image = imread('imaget\images18.jpg');
%image = imread('imag\im1.png');

if size(image, 3) == 3
    image_gray = rgb2gray(image);
else
    image_gray = image;
end

% Convertir l'image en type double pour appliquer la DCT
image_double = double(image_gray);

% Appliquer la DCT sur l'image
dct_image = dct2(image_double);

% Appliquer une échelle logarithmique pour mieux visualiser
dct_log = log(abs(dct_image) + 1);

% Dimensions de l'image
[rows, cols] = size(dct_image);

% Masque pour les basses fréquences (conserver uniquement une petite partie des coefficients DCT)
mask_low = zeros(rows, cols);
mask_low(1:round(rows/10), 1:round(cols/10)) = 1;  % Conserver environ 10% des basses fréquences

% Masque pour les moyennes fréquences (cercle centré sur les fréquences moyennes)
mask_mid = zeros(rows, cols);
mask_mid(round(rows/10):round(rows/3), round(cols/10):round(cols/3)) = 1;

% Masque pour les hautes fréquences (supprimer les basses et moyennes fréquences)
mask_high = ones(rows, cols);
mask_high(1:round(rows/3), 1:round(cols/3)) = 0;

% Appliquer les masques sur l'image DCT
dct_low_freq = dct_image .* mask_low;
dct_mid_freq = dct_image .* mask_mid;
dct_high_freq = dct_image .* mask_high;

% Recréer les images à partir des différentes fréquences
low_freq_image = idct2(dct_low_freq);
mid_freq_image = idct2(dct_mid_freq);
high_freq_image = idct2(dct_high_freq);

% Afficher les résultats
figure;

% Image originale
subplot(1, 5, 1);
imshow(image_gray, []);
title('Image originale');


subplot(1, 5, 2);
imshow(dct_log, []);
title('Transformée DCT');


% Basses fréquences
subplot(1, 5, 3);
imshow(uint8(low_freq_image), []);
title('Basses fréquences');

% Moyennes fréquences
subplot(1, 5, 4);
imshow(uint8(mid_freq_image), []);
title('Moyennes fréquences');

% Hautes fréquences
subplot(1, 5, 5);
imshow(uint8(high_freq_image), []);
title('Hautes fréquences');
