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

% Appliquer la DWT bidimensionnelle avec l'ondelette 'haar'
[LL, LH, HL, HH] = dwt2(image_gray, 'haar');

% Afficher les résultats
figure;

% Approximation (basses fréquences)
subplot(1, 5, 1);
imshow(image_gray);
title('Original image');

subplot(1, 5, 2);
imshow(LL, []);
title('Approximation (LL)');

% Détails horizontaux (LH)
subplot(1, 5, 3);
imshow(LH, []);
title('Détails horizontaux (LH)');

% Détails verticaux (HL)
subplot(1, 5, 4);
imshow(HL, []);
title('Détails verticaux (HL)');

% Détails diagonaux (HH)
subplot(1, 5, 5);
imshow(HH, []);
title('Détails diagonaux (HH)');
