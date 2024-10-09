clc;
clear all;
close all;
% Charger l'image en niveaux de gris
image = imread('imaget\images18.jpg');

if size(image, 3) == 3
    image_gray = rgb2gray(image);
else
    image_gray = image;
end


% Appliquer la DFT bidimensionnelle
dft_image = fft2(double(image_gray));

% Déplacer les basses fréquences au centre
dft_image_shifted = fftshift(dft_image);

% Dimensions de l'image
[rows, cols] = size(dft_image_shifted);
center_row = round(rows / 2);
center_col = round(cols / 2);

% ------------------ Basses fréquences (BF) -------------------
% Masque pour les basses fréquences (petite zone centrale)
mask_low = zeros(rows, cols);
mask_low(center_row-30:center_row+30, center_col-30:center_col+30) = 1;

% Appliquer le masque
dft_low_freq = dft_image_shifted .* mask_low;
low_freq_image = real(ifft2(ifftshift(dft_low_freq)));

% ------------------ Hautes fréquences (HF) -------------------
% Masque pour les hautes fréquences (zones périphériques)
mask_high = ones(rows, cols);
mask_high(center_row-30:center_row+30, center_col-30:center_col+30) = 0;

% Appliquer le masque
dft_high_freq = dft_image_shifted .* mask_high;
high_freq_image = real(ifft2(ifftshift(dft_high_freq)));

% ------------------ Contours verticaux (axe horizontal) -------------------
% Masque pour les fréquences sur l'axe horizontal (correspondant aux contours verticaux)
mask_vertical = zeros(rows, cols);
mask_vertical(center_row-10:center_row+10, :) = 1;  % Axe horizontal

% Appliquer le masque
dft_vertical_freq = dft_image_shifted .* mask_vertical;
vertical_freq_image = real(ifft2(ifftshift(dft_vertical_freq)));

% ------------------ Contours horizontaux (axe vertical) -------------------
% Masque pour les fréquences sur l'axe vertical (correspondant aux contours horizontaux)
mask_horizontal = zeros(rows, cols);
mask_horizontal(:, center_col-10:center_col+10) = 1;  % Axe vertical

% Appliquer le masque
dft_horizontal_freq = dft_image_shifted .* mask_horizontal;
horizontal_freq_image = real(ifft2(ifftshift(dft_horizontal_freq)));

% ------------------ Affichage des résultats -------------------

figure;

% Image originale
subplot(1, 6, 1);
imshow(image_gray, []);
title('Image originale');

% Spectre de Fourier (visualisation globale)
dft_log = log(1 + abs(dft_image_shifted));
subplot(1, 6, 2);
imshow(dft_log, []);
title('Spectre de Fourier');

% Basses fréquences
subplot(1, 6, 3);
imshow(uint8(low_freq_image), []);
title('Basses fréquences');

% Hautes fréquences
subplot(1, 6, 4);
imshow(uint8(high_freq_image), []);
title('Hautes fréquences');

% Contours verticaux (axe horizontal)
subplot(1, 6, 5);
imshow(uint8(vertical_freq_image), []);
title('Contours verticaux');

% Contours horizontaux (axe vertical)
subplot(1, 6, 6);
imshow(uint8(horizontal_freq_image), []);
title('Contours horizontaux');


