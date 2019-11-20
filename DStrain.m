function [ model, acc ] = DStrain( data, label, dist )
% train a decision stump with sample distribution.
% Input : data - N * dim
%         label - N * 1
%         dist - N * 1
% Output: model - struct
%         model.n - number
%         model.map - branch * 2
%         acc - Training accuracy.
% Shu Wang, 2019-11-17.

%% check the aguement.
if nargin == 2
    dist = ones(size(label)) / length(label);
end

%% data preparation.
num = size(data, 1);
dim = size(data, 2);
gains = zeros(1, dim);
models = [];
% get the parent entropy
pn = sum( dist( find(label == -1) ) );
pp = sum( dist( find(label == +1) ) );
entropy = - pn * log2(pn) - pp * log2(pp);

%% get gains and models
for i = 1 : dim
    feat = data(:, i);          % i-th feature.
    feat_uni = unique(feat);    % unique feature.
    branch = length(feat_uni);  % number of possible value.
    % init models{i}
    models{i}.n = i;
    models{i}.map = [feat_uni, zeros(branch, 1)];
    
    % (Weighted) Average Entropy of Children
    entro = 0;
    for j = 1 : branch
        idx = find(feat == feat_uni(j));
        p = sum( dist(idx) );
        label_sub = label(idx);
        dist_sub = dist(idx);
        % Entropy of Children
        pn = sum( dist_sub( find(label_sub == -1) ) ) / p;
        pp = sum( dist_sub( find(label_sub == +1) ) ) / p;
        if (pn * pp)
            entro_sub = - pn * log2(pn) - pp * log2(pp);
        else
            entro_sub = 0;
        end
        % (Weighted) Average Entropy of Children
        entro = entro + p * entro_sub;
        % update model
        if (pn > pp)
            models{i}.map(j, 2) = -1;
        else
            models{i}.map(j, 2) = +1;
        end
    end
    % update gains
    gains(i) = entropy - entro;
end

%% determine
[~, index] = max(gains);
model = models{index};

%% accuracy
feat = data(:, model.n);
branch = size(model.map, 1);
predicts = zeros(size(label));
for i = 1 : branch
    predicts(find(feat == model.map(i, 1))) = model.map(i, 2);
end
acc = sum(dist(find(predicts == label)));

end

