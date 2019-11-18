function [ models, alphas, accplot ] = DSboosttrain( data, label, ncls )
% Train an adaboost classifier with 1-level decision tree.
% Input : data - N * dim
%         label - N * 1
%         ncls - 1 * 1 number of classifiers.
% Output: models    - cell
%         model     - struct-models{i}
%         model.n   - number
%         model.map - branch * 2
%         alphas    - ncls * 1
%         accplot   - 1 * ncls
% Shu Wang, 2019-11-17.

%% data preparation.
num = size(data, 1);
dim = size(data, 2);
dist = ones(num, 1) / num;

%% training parameters.
models = [];
alphas = [];
accplot = [];

%% Adaboost
for t = 1 : ncls
    % train a classifier.
    [ model, ~ ] = DStrain( data, label, dist );    % train model with dist
    models{end+1} = model;
    % get alpha
    h = DS( data, model );                          % get predictions
    I = (h ~= label);                               % get misclassification
    e = dist' * I;
    a = 0.5 * log((1 - e) / e);
    alphas(end+1, :) = a;
    % update distribution.
    dist = dist .* exp(- a * label .* h);
    dist = dist / sum(dist);
    % evaluation
    h = DSboost(data, models, alphas);
    accplot(end+1) = sum(h == label) / num;
end

plot(accplot);

end
