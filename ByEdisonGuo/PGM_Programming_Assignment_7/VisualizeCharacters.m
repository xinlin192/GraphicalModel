function VisualizeCharacters (X)
% VisualizeCharacters(X) displays the characters of observation X. The
% input X should be a numCharacters x 32 matrix, since each character is
% 8x4 and is stored in one row. The entries are 1's and 2's corresponding
% to white and black pixels, respectively. This is the format of the
% provided data for PA7, so this function should "just work" on the
% provided data.
%
% Copyright (C) Daphne Koller, Stanford Univerity, 2012

if (~isequal(size(X, 2), 32))
    error('Input to VisualizeCharacters.m of incorrect size.');
end

if (any(X(:) == 2))
    X = X - 1;
end

len = size(X, 1);
totalWidth = 5 * len + 1;

im = zeros(8, totalWidth);
for i = 1:len
    charIm = reshape(X(i,:), 8, 4);
    im(:, (2:5) + (5 * (i-1))) = charIm;
end

figure;
colormap(gray);
imagesc(1 - im);
axis equal;
[height, width] = size(im);
axis([0 width 0 height]);

end

