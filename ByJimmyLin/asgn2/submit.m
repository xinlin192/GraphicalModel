function submit(partId, webSubmit)
%SUBMIT Submit your code and output to the pgm-class servers
%   SUBMIT() will connect to the pgm-class server and submit your solution
%   There is no penalty for submitting, so go ahead and try this!
%
%   If this function does not work for you, use the web-submission mechanism.
%   Call the submitWeb function, which will produce a file for the part you
%   wish to submit. Then, submit the file to the class servers using the 
%   "Web Submission" button on the Programming Assignments page on the course
%   website.
%   
%   webSubmit is a boolean variable that specifies whether to prepare
%   a file for web-submission (if webSubmit = 1) or to submit directly
%   to the server (if webSubmit = 0, or is not specified); you should call
%   submitWeb if you want to do a web-submission.

  warning off all;

  fprintf('==\n== [pgm-class] Submitting Solutions | Programming Assignment %s\n==\n', ...
          homework_id());
  if ~exist('partId', 'var') || isempty(partId)
    partId = promptPart();
  end
  
  if ~exist('webSubmit', 'var') || isempty(webSubmit)
    webSubmit = 0; % submit directly by default 
  end
  
  % Check valid partId
  partNames = validParts();
  if ~isValidPartId(partId)
    fprintf('!! Invalid assignment part selected.\n');
    fprintf('!! Expected an integer from 1 to %d.\n', numel(partNames) + 1);
    fprintf('!! Submission Cancelled\n');
    return
  end
  
  if ~exist('228_login_data.mat','file')
    [login password] = loginPrompt();
    save('228_login_data.mat','login','password');
  else  
    load('228_login_data.mat');
    [login password] = quickLogin(login,password);
    save('228_login_data.mat','login','password');
  end
  if isempty(login)
    fprintf('!! Submission Cancelled\n');
    return
  end

  fprintf('\n== Connecting to pgm-class ... '); 
  if exist('OCTAVE_VERSION') 
    fflush(stdout);
  end
  

  % Setup submit list
  if partId == numel(partNames) + 1
    submitParts = 1:numel(partNames);
  else
    submitParts = [partId];
  end

  for s = 1:numel(submitParts)
    % Submit this part
    partId = submitParts(s);
    
    samplePartId = 2 * (partId - 1) + 1;
    testPartId = samplePartId + 1;
    
    for thisPartId = [samplePartId testPartId]
        if (~webSubmit) % submit directly to server
            
            [login, ch, signature, auxstring] = getChallenge(login, thisPartId);
            if isempty(login) || isempty(ch) || isempty(signature)
                % Some error occured, error string in first return element.
                fprintf('\n!! Error: %s\n\n', login);
                return
            end
            
            % Attempt Submission with Challenge
            ch_resp = challengeResponse(login, password, ch);
            
            [result, str] = submitSolution(login, ch_resp, thisPartId, ...
                output(thisPartId, auxstring), source(partId), signature);
            
            if (~isTest(thisPartId))
                partName = partNames{partId};
            else
                partName = [partNames{partId} ' (test)'];
            end
            
            fprintf('\n== [pgm-class] Submitted Assignment %s - Part %d - %s\n', ...
                homework_id(), partId, partName);
            fprintf('== %s\n', strtrim(str));
            
            if exist('OCTAVE_VERSION')
                fflush(stdout);
            end
            
        else % make web submission files
            
            [result] = submitSolutionWeb(login, thisPartId, output(thisPartId), ...
                source(partId));
            result = base64encode(result);
            
            if (~isTest(thisPartId))
                partType = 'sample';
            else
                partType = 'test';
            end
            
            fprintf('\nSave as submission file [submit_pa%s_part%d_%s.txt (enter to accept default)]:', ...
                homework_id(), partId, partType);
            saveAsFile = input('', 's');
            if (isempty(saveAsFile))
                saveAsFile = sprintf('submit_pa%s_part%d_%s.txt', homework_id(), partId, partType);
            end
            
            fid = fopen(saveAsFile, 'w');
            if (fid)
                fwrite(fid, result);
                fclose(fid);
                fprintf('\nSaved your solutions to %s.\n\n', saveAsFile);
                fprintf(['You can now submit your solutions using the ' ...
                    'Web Submission button\non the Assignments page\n']);
            else
                fprintf('Unable to save to %s\n\n', saveAsFile);
                fprintf(['You can create a submission file by saving the \n' ...
                    'following text in a file: (press enter to continue)\n\n']);
                pause;
                fprintf(result);
            end
            
        end
    end
    
  end
  
end

% ================== CONFIGURABLES FOR EACH HOMEWORK ==================

function id = homework_id() 
  id = '2';
end

function [partNames] = validParts()
  partNames = { 'phenotypeGivenGenotypeMendelianFactor', ...
                'phenotypeGivenGenotypeFactor', ...
                'genotypeGivenAlleleFreqsFactor', ...
                'genotypeGivenParentsGenotypesFactor', ...
                'constructGeneticNetwork', ...
                'phenotypeGivenCopiesFactor', ...
                'constructDecoupledGeneticNetwork', ...
                'constructSigmoidPhenotypeFactor'
              };
end

function srcs = sources()
  % Separated by part
  srcs = { { 'phenotypeGivenGenotypeMendelianFactor.m' }, ...
           { 'phenotypeGivenGenotypeFactor.m' }, ...
           { 'genotypeGivenAlleleFreqsFactor.m' }, ...
           { 'genotypeGivenParentsGenotypesFactor.m' }, ...
           { 'constructGeneticNetwork.m' }, ...
           { 'phenotypeGivenCopiesFactor.m' }, ...
           { 'constructDecoupledGeneticNetwork.m' }, ...
           { 'constructSigmoidPhenotypeFactor.m' }
         };
end

% specifies which parts are test parts
function result = isTest(partId)
  if (mod(partId, 2) == 0) 
    result = true;
  else
    result = false;
  end
end

function out = output(partId, auxstring)

  if partId == 1
    isDominant = 1;
    genotypeVar = 1;
    phenotypeVar = 3;
    pggmf(1) = phenotypeGivenGenotypeMendelianFactor(isDominant, genotypeVar, phenotypeVar);
    pggmf(1) = SortFactorLaterVars(pggmf(1));
    out = SerializeFactorsFg(pggmf);
  elseif partId == 2
    isDominant = 0;
    genotypeVar = 1;
    phenotypeVar = 3;
    pggmf(1) = phenotypeGivenGenotypeMendelianFactor(isDominant, genotypeVar, phenotypeVar);
    pggmf(1) = SortFactorLaterVars(pggmf(1));
    out = SerializeFactorsFg(pggmf);
  elseif partId == 3
    alphaList = [0.8; 0.6; 0.1];
    genotypeVar = 1;
    phenotypeVar = 3;
    pggf(1) = phenotypeGivenGenotypeFactor(alphaList, genotypeVar, phenotypeVar);
    pggf(1) = SortFactorLaterVars(pggf(1));
    out = SerializeFactorsFg(pggf);
  elseif partId == 4
    alphaList = [0.2; 0.5; 0.9];
    genotypeVar = 1;
    phenotypeVar = 3;
    pggf(1) = phenotypeGivenGenotypeFactor(alphaList, genotypeVar, phenotypeVar);
    pggf(1) = SortFactorLaterVars(pggf(1));
    out = SerializeFactorsFg(pggf);
  elseif partId == 5
    alleleFreqs = [0.1; 0.9];
    genotypeVar = 1;
    ggaff(1) = genotypeGivenAlleleFreqsFactor(alleleFreqs, genotypeVar);
    out = SerializeFactorsFg(ggaff);
  elseif partId == 6
    alleleFreqs = [0.98; 0.02];
    genotypeVar = 1;
    ggaff(1) = genotypeGivenAlleleFreqsFactor(alleleFreqs, genotypeVar);
    out = SerializeFactorsFg(ggaff);
  elseif partId == 7
    alleleList = {'F', 'f'};
    genotypeVarChild = 3;
    genotypeVarParentOne = 1;
    genotypeVarParentTwo = 2;
    ggpgf(1) = genotypeGivenParentsGenotypesFactor(length(alleleList), genotypeVarChild, genotypeVarParentOne, genotypeVarParentTwo);
    ggpgf(1) = SortFactorLaterVars(ggpgf(1));
    out = SerializeFactorsFg(ggpgf);
  elseif partId == 8
    alleleList = {'A', 'a', 'n'};
    genotypeVarChild = 3;
    genotypeVarParentOne = 1;
    genotypeVarParentTwo = 2;
    ggpgf(1) = genotypeGivenParentsGenotypesFactor(length(alleleList), genotypeVarChild, genotypeVarParentOne, genotypeVarParentTwo);
    ggpgf(1) = SortFactorLaterVars(ggpgf(1));
    out = SerializeFactorsFg(ggpgf);
  elseif partId == 9
    alleleFreqs = [0.1; 0.9];
    alphaList = [0.8; 0.6; 0.1];
    pedigree = struct('parents', [0,0;1,3;0,0;1,3;2,6;0,0;2,6;4,9;0,0]);
    pedigree.names = {'Ira','James','Robin','Eva','Jason','Rene','Benjamin','Sandra','Aaron'};
    cgn = constructGeneticNetwork(pedigree, alleleFreqs, alphaList);
    for i = 1:length(cgn)
        cgn(i) = SortFactorLaterVars(cgn(i));
    end
    out = SerializeFactorsFg(sortStruct(cgn));
  elseif partId == 10
    alleleFreqs = [0.1; 0.9];
    alphaList = [0.8; 0.6; 0.1];
    pedigree = struct('parents', [0,0;0,0;2,1;0,0;2,1;0,0;0,0;3,4;5,7;5,6]);
	pedigree.names = {'Alan','Vivian','Alice','Larry','Beth','Henry','Leon','Frank','Amy', 'Martin'};
    cgn = constructGeneticNetwork(pedigree, alleleFreqs, alphaList);
    for i = 1:length(cgn)
        cgn(i) = SortFactorLaterVars(cgn(i));
    end
    out = SerializeFactorsFg(sortStruct(cgn));
  elseif partId == 11
    alphaListThree = [0.8; 0.6; 0.1; 0.5; 0.05; 0.01];
    phenotypeVar = 3;
    genotypeVarMotherCopy = 1;
    genotypeVarFatherCopy = 2;
    numAlleles = 3;
    pgpaf(1) = phenotypeGivenCopiesFactor(alphaListThree, numAlleles, genotypeVarMotherCopy, genotypeVarFatherCopy, phenotypeVar);
    pgpaf(1) = SortFactorLaterVars(pgpaf(1));
    out = SerializeFactorsFg(pgpaf);
  elseif partId == 12
    alphaListThree = [0.001; 0.009; 0.3; 0.2; 0.75; 0.95];
    phenotypeVar = 3;
    genotypeVarMotherCopy = 1;
    genotypeVarFatherCopy = 2;
    numAlleles = 3;
    pgpaf(1) = phenotypeGivenCopiesFactor(alphaListThree, numAlleles, genotypeVarMotherCopy, genotypeVarFatherCopy, phenotypeVar);
    pgpaf(1) = SortFactorLaterVars(pgpaf(1));
    out = SerializeFactorsFg(pgpaf);
  elseif partId == 13
    pedigree = struct('parents', [0,0;1,3;0,0;1,3;2,6;0,0;2,6;4,9;0,0]);
    pedigree.names = {'Ira','James','Robin','Eva','Jason','Rene','Benjamin','Sandra','Aaron'};
    alphaListThree = [0.8; 0.6; 0.1; 0.5; 0.05; 0.01];
    alleleFreqsThree = [0.1; 0.7; 0.2];
    cdgn = constructDecoupledGeneticNetwork(pedigree, alleleFreqsThree, alphaListThree);
    for i = 1:length(cdgn)
        cdgn(i) = SortFactorLaterVars(cdgn(i));
    end
    out = SerializeFactorsFg(sortStruct(cdgn));
  elseif partId == 14
    pedigree = struct('parents', [0,0;0,0;2,1;0,0;2,1;0,0;0,0;3,4;5,7;5,6]);
	pedigree.names = {'Alan','Vivian','Alice','Larry','Beth','Henry','Leon','Frank','Amy', 'Martin'};
    alphaListThree = [0.8; 0.6; 0.1; 0.5; 0.05; 0.01];
    alleleFreqsThree = [0.1; 0.7; 0.2];
    cdgn = constructDecoupledGeneticNetwork(pedigree, alleleFreqsThree, alphaListThree);
    for i = 1:length(cdgn)
        cdgn(i) = SortFactorLaterVars(cdgn(i));
    end
    out = SerializeFactorsFg(sortStruct(cdgn));
  elseif partId == 15
    alleleWeights = {[3, -3], [0.9, -0.8]};
    phenotypeVar = 3;
    geneCopyVarParentOneList = [1; 2];
    geneCopyVarParentTwoList = [4; 5];
    cspf(1) = constructSigmoidPhenotypeFactor(alleleWeights, geneCopyVarParentOneList, geneCopyVarParentTwoList, phenotypeVar);
    cspf(1) = SortFactorLaterVars(cspf(1));
    out = SerializeFactorsFg(cspf);
  elseif partId == 16
    alleleWeights = {[0.01, -.2], [1, -.5]};
    phenotypeVar = 3;
    geneCopyVarParentOneList = [1; 2];
    geneCopyVarParentTwoList = [4; 5];
    cspf(1) = constructSigmoidPhenotypeFactor(alleleWeights, geneCopyVarParentOneList, geneCopyVarParentTwoList, phenotypeVar);
    cspf(1) = SortFactorLaterVars(cspf(1));
    out = SerializeFactorsFg(cspf);
  end
end

function out = SerializeFactorsFg(F)
% Serializes a factor struct array into the .fg format for libDAI
% http://cs.ru.nl/~jorism/libDAI/doc/fileformats.html
%
% To avoid incompatibilities with EOL markers, make sure you write the
% string to a file using the appropriate file type ('wt' for windows, 'w'
% for unix)

lines = cell(5*numel(F) + 1, 1);

lines{1} = sprintf('%d\n', numel(F));
lineIdx = 2;
for i = 1:numel(F)
  lines{lineIdx} = sprintf('\n%d\n', numel(F(i).var));
  lineIdx = lineIdx + 1;
  
  lines{lineIdx} = sprintf('%s\n', num2str(F(i).var(:)')); % ensure that we put in a row vector
  lineIdx = lineIdx + 1;
  
  lines{lineIdx} = sprintf('%s\n', num2str(F(i).card(:)')); % ensure that we put in a row vector
  lineIdx = lineIdx + 1;
  
  lines{lineIdx} = sprintf('%d\n', numel(F(i).val));
  lineIdx = lineIdx + 1;
  
  % Internal storage of factor vals is already in the same indexing order
  % as what libDAI expects, so we don't need to convert the indices.
  vals = [0:(numel(F(i).val) - 1); F(i).val(:)'];
  lines{lineIdx} = sprintf('%d %0.8g\n', vals);
  lineIdx = lineIdx + 1;
end

out = sprintf('%s', lines{:});

end

function out = SerializePedigree(pedigree)
% SerializePedigree Serializes a pedigree into a text string.

numPeople = numel(pedigree.names);

lines = cell(2*numPeople + 1, 1);

lines{1} = sprintf('%d\n', numPeople);
lineIdx = 2;
for i = 1:numPeople
  lines{lineIdx} = sprintf('%s\n', pedigree.names{i});
  lineIdx = lineIdx + 1;
end

for i = 1:numPeople
  lines{lineIdx} = sprintf('%d %d\n', pedigree.parents(i, 1), pedigree.parents(i, 2));
  lineIdx = lineIdx + 1;
end

out = sprintf('%s', lines{:});
end

function G = SortFactorLaterVars(F)
% SortFactorLaterVars Returns the input factor with a sorted variable
% ordering but leaves the first variable alone.
%   
% SortFactorLaterVars(F) returns a new factor that contains exactly the same
% variables and values but in which the variables are ordered differently
% (the ordering is as specified in the .var field). Specifically, the
% returned factor will have its first variable  ordered in ascending order.
%
% For instance, if F.var = [3 1 2], and G = SortFactorVars(F), tnen 
% G.var = [1 2 3], and G.card, G.val will have been appropriately reordered
% (from F.card and F.val) with respect to this sorted variable ordering.
%

if (numel(F.var) > 1)
  laterVars = F.var(2:end);
  [slVars, lorder] = sort(laterVars);
  G.var = [F.var(1) slVars];
  
  order = [1 (lorder+1)];
  
  G.card = F.card(order);  
  G.val = zeros(numel(F.val), 1); 

  assignmentsInF = IndexToAssignment(1:numel(F.val), F.card);
  assignmentsInG = assignmentsInF(:, order);
  G.val(AssignmentToIndex(assignmentsInG, G.card)) = F.val;
  
else % nothing to do
  G = F;
end

end

function sListSorted = sortStruct(sList)

for i = 1 : length(sList)
  S{i} = sprintf('%d%d%f', sList(i).var, sList(i).card, sList(i).val);  
end

[S I] = sort(S);
sListSorted = sList(I);

end


%%% Remove -staging when you deploy!
function url = challenge_url()
  url = 'http://class.coursera.org/pgm-003/assignment/challenge';
end

%%% Remove -staging when you deploy!
function url = submit_url()
  url = 'http://class.coursera.org/pgm-003/assignment/submit';
end

% ========================= CHALLENGE HELPERS =========================

function src = source(partId)
  src = '';
  src_files = sources();
  if partId <= numel(src_files)
      flist = src_files{partId};
      for i = 1:numel(flist)
          fid = fopen(flist{i});
          if (fid == -1) 
            error('Error opening %s (is it missing?)', flist{i});
          end
          line = fgets(fid);
          while ischar(line)
            src = [src line];            
            line = fgets(fid);
          end
          fclose(fid);
          src = [src '||||||||'];
      end
  end
end

function ret = isValidPartId(partId)
  partNames = validParts();
  ret = (~isempty(partId)) && (partId >= 1) && (partId <= numel(partNames) + 1);
end

function partId = promptPart()
  fprintf('== Select which part(s) to submit:\n', ...
          homework_id());
  partNames = validParts();
  srcFiles = sources();
  for i = 1:numel(partNames)
    fprintf('==   %d) %s [', i, partNames{i});
    fprintf(' %s ', srcFiles{i}{:});
    fprintf(']\n');
  end
  fprintf('==   %d) All of the above \n==\nEnter your choice [1-%d]: ', ...
          numel(partNames) + 1, numel(partNames) + 1);
  selPart = input('', 's');
  partId = str2num(selPart);
  if ~isValidPartId(partId)
    partId = -1;
  end
end

function [email,ch,signature,auxstring] = getChallenge(email, part)
  str = urlread(challenge_url(), 'post', {'email_address', email, 'assignment_part_sid', [homework_id() '-' num2str(part)], 'response_encoding', 'delim'});

  str = strtrim(str);
  r = struct;
  while(numel(str) > 0)
    [f, str] = strtok (str, '|');
    [v, str] = strtok (str, '|');
    r = setfield(r, f, v);
  end

  email = getfield(r, 'email_address');
  ch = getfield(r, 'challenge_key');
  signature = getfield(r, 'state');
  auxstring = getfield(r, 'challenge_aux_data');
end

function [result, str] = submitSolutionWeb(email, part, output, source)

  result = ['{"assignment_part_sid":"' base64encode([homework_id() '-' num2str(part)], '') '",' ...
            '"email_address":"' base64encode(email, '') '",' ...
            '"submission":"' base64encode(output, '') '",' ...
            '"submission_aux":"' base64encode(source, '') '"' ...
            '}'];
  str = 'Web-submission';
end

function [result, str] = submitSolution(email, ch_resp, part, output, ...
                                        source, signature)

  params = {'assignment_part_sid', [homework_id() '-' num2str(part)], ...
            'email_address', email, ...
            'submission', base64encode(output, ''), ...
            'submission_aux', base64encode(source, ''), ...
            'challenge_response', ch_resp, ...
            'state', signature};

  str = urlread(submit_url(), 'post', params);
 
  % Parse str to read for success / failure
  result = 0;

end

% =========================== LOGIN HELPERS ===========================

function [login password] = loginPrompt()
  % Prompt for password
  [login password] = basicPrompt();
  
  if isempty(login) || isempty(password)
    login = []; password = [];
  end
end


function [login password] = basicPrompt()
  login = input('Login (Email address): ', 's');
  password = input('Submission Password (from Assignments page): ', 's');
end

function [login password] = quickLogin(login,password)
  cont_token = input(['You are currently logged in as ' login '. Is this you? (y/n - type n to reenter password)'],'s');
  if(cont_token(1)=='Y'||cont_token(1)=='y')
    return;
  else
    [login password] = loginPrompt();
  end
end


function [str] = challengeResponse(email, passwd, challenge)
  str = sha1([challenge passwd]);
end


% =============================== SHA-1 ================================

function hash = sha1(str)
  
  % Initialize variables
  h0 = uint32(1732584193);
  h1 = uint32(4023233417);
  h2 = uint32(2562383102);
  h3 = uint32(271733878);
  h4 = uint32(3285377520);
  
  % Convert to word array
  strlen = numel(str);

  % Break string into chars and append the bit 1 to the message
  mC = [double(str) 128];
  mC = [mC zeros(1, 4-mod(numel(mC), 4), 'uint8')];
  
  numB = strlen * 8;
  if exist('idivide')
    numC = idivide(uint32(numB + 65), 512, 'ceil');
  else
    numC = ceil(double(numB + 65)/512);
  end
  numW = numC * 16;
  mW = zeros(numW, 1, 'uint32');
  
  idx = 1;
  for i = 1:4:strlen + 1
    mW(idx) = bitor(bitor(bitor( ...
                  bitshift(uint32(mC(i)), 24), ...
                  bitshift(uint32(mC(i+1)), 16)), ...
                  bitshift(uint32(mC(i+2)), 8)), ...
                  uint32(mC(i+3)));
    idx = idx + 1;
  end
  
  % Append length of message
  mW(numW - 1) = uint32(bitshift(uint64(numB), -32));
  mW(numW) = uint32(bitshift(bitshift(uint64(numB), 32), -32));

  % Process the message in successive 512-bit chs
  for cId = 1 : double(numC)
    cSt = (cId - 1) * 16 + 1;
    cEnd = cId * 16;
    ch = mW(cSt : cEnd);
    
    % Extend the sixteen 32-bit words into eighty 32-bit words
    for j = 17 : 80
      ch(j) = ch(j - 3);
      ch(j) = bitxor(ch(j), ch(j - 8));
      ch(j) = bitxor(ch(j), ch(j - 14));
      ch(j) = bitxor(ch(j), ch(j - 16));
      ch(j) = bitrotate(ch(j), 1);
    end
  
    % Initialize hash value for this ch
    a = h0;
    b = h1;
    c = h2;
    d = h3;
    e = h4;
    
    % Main loop
    for i = 1 : 80
      if(i >= 1 && i <= 20)
        f = bitor(bitand(b, c), bitand(bitcmp(b), d));
        k = uint32(1518500249);
      elseif(i >= 21 && i <= 40)
        f = bitxor(bitxor(b, c), d);
        k = uint32(1859775393);
      elseif(i >= 41 && i <= 60)
        f = bitor(bitor(bitand(b, c), bitand(b, d)), bitand(c, d));
        k = uint32(2400959708);
      elseif(i >= 61 && i <= 80)
        f = bitxor(bitxor(b, c), d);
        k = uint32(3395469782);
      end
      
      t = bitrotate(a, 5);
      t = bitadd(t, f);
      t = bitadd(t, e);
      t = bitadd(t, k);
      t = bitadd(t, ch(i));
      e = d;
      d = c;
      c = bitrotate(b, 30);
      b = a;
      a = t;
      
    end
    h0 = bitadd(h0, a);
    h1 = bitadd(h1, b);
    h2 = bitadd(h2, c);
    h3 = bitadd(h3, d);
    h4 = bitadd(h4, e);

  end

  hash = reshape(dec2hex(double([h0 h1 h2 h3 h4]), 8)', [1 40]);
  
  hash = lower(hash);

end

function ret = bitadd(iA, iB)
  ret = double(iA) + double(iB);
  ret = bitset(ret, 33, 0);
  ret = uint32(ret);
end

function ret = bitrotate(iA, places)
  t = bitshift(iA, places - 32);
  ret = bitshift(iA, places);
  ret = bitor(ret, t);
end

% =========================== Base64 Encoder ============================
% Thanks to Peter John Acklam
%

function y = base64encode(x, eol)
%BASE64ENCODE Perform base64 encoding on a string.
%
%   BASE64ENCODE(STR, EOL) encode the given string STR.  EOL is the line ending
%   sequence to use; it is optional and defaults to '\n' (ASCII decimal 10).
%   The returned encoded string is broken into lines of no more than 76
%   characters each, and each line will end with EOL unless it is empty.  Let
%   EOL be empty if you do not want the encoded string broken into lines.
%
%   STR and EOL don't have to be strings (i.e., char arrays).  The only
%   requirement is that they are vectors containing values in the range 0-255.
%
%   This function may be used to encode strings into the Base64 encoding
%   specified in RFC 2045 - MIME (Multipurpose Internet Mail Extensions).  The
%   Base64 encoding is designed to represent arbitrary sequences of octets in a
%   form that need not be humanly readable.  A 65-character subset
%   ([A-Za-z0-9+/=]) of US-ASCII is used, enabling 6 bits to be represented per
%   printable character.
%
%   Examples
%   --------
%
%   If you want to encode a large file, you should encode it in chunks that are
%   a multiple of 57 bytes.  This ensures that the base64 lines line up and
%   that you do not end up with padding in the middle.  57 bytes of data fills
%   one complete base64 line (76 == 57*4/3):
%
%   If ifid and ofid are two file identifiers opened for reading and writing,
%   respectively, then you can base64 encode the data with
%
%      while ~feof(ifid)
%         fwrite(ofid, base64encode(fread(ifid, 60*57)));
%      end
%
%   or, if you have enough memory,
%
%      fwrite(ofid, base64encode(fread(ifid)));
%
%   See also BASE64DECODE.

%   Author:      Peter John Acklam
%   Time-stamp:  2004-02-03 21:36:56 +0100
%   E-mail:      pjacklam@online.no
%   URL:         http://home.online.no/~pjacklam

   if isnumeric(x)
      x = num2str(x);
   end

   % make sure we have the EOL value
   if nargin < 2
      eol = sprintf('\n');
   else
      if sum(size(eol) > 1) > 1
         error('EOL must be a vector.');
      end
      if any(eol(:) > 255)
         error('EOL can not contain values larger than 255.');
      end
   end

   if sum(size(x) > 1) > 1
      error('STR must be a vector.');
   end

   x   = uint8(x);
   eol = uint8(eol);

   ndbytes = length(x);                 % number of decoded bytes
   nchunks = ceil(ndbytes / 3);         % number of chunks/groups
   nebytes = 4 * nchunks;               % number of encoded bytes

   % add padding if necessary, to make the length of x a multiple of 3
   if rem(ndbytes, 3)
      x(end+1 : 3*nchunks) = 0;
   end

   x = reshape(x, [3, nchunks]);        % reshape the data
   y = repmat(uint8(0), 4, nchunks);    % for the encoded data

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % Split up every 3 bytes into 4 pieces
   %
   %    aaaaaabb bbbbcccc ccdddddd
   %
   % to form
   %
   %    00aaaaaa 00bbbbbb 00cccccc 00dddddd
   %
   y(1,:) = bitshift(x(1,:), -2);                  % 6 highest bits of x(1,:)

   y(2,:) = bitshift(bitand(x(1,:), 3), 4);        % 2 lowest bits of x(1,:)
   y(2,:) = bitor(y(2,:), bitshift(x(2,:), -4));   % 4 highest bits of x(2,:)

   y(3,:) = bitshift(bitand(x(2,:), 15), 2);       % 4 lowest bits of x(2,:)
   y(3,:) = bitor(y(3,:), bitshift(x(3,:), -6));   % 2 highest bits of x(3,:)

   y(4,:) = bitand(x(3,:), 63);                    % 6 lowest bits of x(3,:)

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % Now perform the following mapping
   %
   %   0  - 25  ->  A-Z
   %   26 - 51  ->  a-z
   %   52 - 61  ->  0-9
   %   62       ->  +
   %   63       ->  /
   %
   % We could use a mapping vector like
   %
   %   ['A':'Z', 'a':'z', '0':'9', '+/']
   %
   % but that would require an index vector of class double.
   %
   z = repmat(uint8(0), size(y));
   i =           y <= 25;  z(i) = 'A'      + double(y(i));
   i = 26 <= y & y <= 51;  z(i) = 'a' - 26 + double(y(i));
   i = 52 <= y & y <= 61;  z(i) = '0' - 52 + double(y(i));
   i =           y == 62;  z(i) = '+';
   i =           y == 63;  z(i) = '/';
   y = z;

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % Add padding if necessary.
   %
   npbytes = 3 * nchunks - ndbytes;     % number of padding bytes
   if npbytes
      y(end-npbytes+1 : end) = '=';     % '=' is used for padding
   end

   if isempty(eol)

      % reshape to a row vector
      y = reshape(y, [1, nebytes]);

   else

      nlines = ceil(nebytes / 76);      % number of lines
      neolbytes = length(eol);          % number of bytes in eol string

      % pad data so it becomes a multiple of 76 elements
      y = [y(:) ; zeros(76 * nlines - numel(y), 1)];
      y(nebytes + 1 : 76 * nlines) = 0;
      y = reshape(y, 76, nlines);

      % insert eol strings
      eol = eol(:);
      y(end + 1 : end + neolbytes, :) = eol(:, ones(1, nlines));

      % remove padding, but keep the last eol string
      m = nebytes + neolbytes * (nlines - 1);
      n = (76+neolbytes)*nlines - neolbytes;
      y(m+1 : n) = '';

      % extract and reshape to row vector
      y = reshape(y, 1, m+neolbytes);

   end

   % output is a character array
   y = char(y);

end
