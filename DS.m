function [ predicts ] = DS( data, model )
% Output the results for decision stump.
% Input : data      - N * (dim + 1) padded with 1.
%         model     - struct
%         model.n   - number
%         model.map - branch * 2
% Output: predicts  - N * 1  [-1, +1]

feat = data(:, model.n);
branch = size(model.map, 1);
predicts = zeros(size(data, 1), 1);
for i = 1 : branch
    predicts(find(feat == model.map(i, 1))) = model.map(i, 2);
end

end

