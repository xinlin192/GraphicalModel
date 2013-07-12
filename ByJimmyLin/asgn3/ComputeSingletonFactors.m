function factors = ComputeSingletonFactors (images, imageModel)
% This function computes the single OCR factors for all of the images in a
% word.
%
% Input:
%   images: An array of structs containing the 'img' value for each
%     character in the word. You could, for example, pass in allWords{1} to
%     use the first word of the provided dataset.
%   imageModel: The provided OCR image model.
%
% Output:
%   factors: An array of the OCR factors, one for every character in the
%   image.
%
% Hint: You will want to use ComputeImageFactor.m when computing the 'val'
% entry for each factor.
%
% Copyright (C) Daphne Koller, Stanford University, 2012

% The number of characters in the word
n = length(images);

% Preallocate the array of factors
factors = repmat(struct('var', [], 'card', [], 'val', []), n, 1);

% Your code here:
for j = 1:n, % the j-th image (character)
    % give assignment for the factor of each image
    factors(j).var = j;
    factors(j).card = [imageModel.K];
    factors(j).val = ComputeImageFactor (images(j).img, imageModel);
end
end
