% Copyright (C) Daphne Koller, Stanford University, 2012

function DecodedMarginalsToChars(decodedMarginals)
    chars = 'abcdefghijklmnopqrstuvwxyz';
    fprintf('%c', chars(decodedMarginals));
    fprintf('\n');
end
