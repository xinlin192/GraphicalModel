load('PA4Sample.mat', 'OCRNetworkToRun');
maxMarginals = ComputeExactMarginalsBP(OCRNetworkToRun, [], 1);
MAPAssignment = MaxDecoding(maxMarginals);
DecodedMarginalsToChars(MAPAssignment)