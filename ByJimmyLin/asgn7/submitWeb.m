% submitWeb Creates files from your code and output for web submission.
%
%   If the submit function does not work for you, use the web-submission mechanism.
%   Call this function to produce a file for the part you wish to submit. Then,
%   submit the file to the class servers using the "Web Submission" button on the 
%   Programming Assignments page on the course website.
%
% Copyright (C) Daphne Koller, Stanford Univerity, 2012

function submitWeb(partId)
  if ~exist('partId', 'var') || isempty(partId)
    partId = [];
  end
  
  submit(partId, 1);
end

