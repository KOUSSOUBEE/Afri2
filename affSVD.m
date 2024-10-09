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

% Appliquer la décomposition SVD
[U, S, V] = svd(double(image_gray));

% Afficher les résultats
figure;

subplot(1, 4, 1);
imshow(image_gray);
title('Original image');

% Afficher la matrice U
subplot(1, 4, 2);
imshow(U, []);
title(' U');

% Afficher la matrice S (valeurs singulières)
subplot(1, 4, 3);
imshow(log(1 + S), []);  % Échelle logarithmique pour mieux visualiser
title('S');

% Afficher la matrice V
subplot(1, 4, 4);
imshow(V, []);
title('V');
