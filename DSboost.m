function [ predicts ] = DSboost( data, models, alphas )
% calculate the predicts of DS boosting model
%   Detailed explanation goes here

T = length(alphas);

out = 0;
for i = 1 : T
    out = out + alphas(i) * DS(data, models{i});
end

predicts = sign(out);

end

