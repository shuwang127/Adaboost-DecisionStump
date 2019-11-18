function [ predicts ] = DSboost( data, models, alphas )
% calculate the predicts of DS boosting model
% Input : data - N * dim
%         models - a cell with model{i}
%         model - struct
%         model.n - 1 * 1
%         model.map - branch * 2
%         alphas - T * 1
% Output: predicts - N * 1

T = length(alphas);

out = 0;
for i = 1 : T
    out = out + alphas(i) * DS(data, models{i});
end

predicts = sign(out);

end

