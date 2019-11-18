function [ data, label ] = readdata()
% Read data from file.
% Output: data - N * dim;
%         label - N * 1
% Shu Wang, 2019-11-16.

if ~exist('samples.mat')
    label = [];
    data = [];
    
    fid = fopen('house-votes-84.data', 'r');
    while true
        line = fgetl(fid);
        if ~ischar(line)
            break; 
        end
        info = split(line, ',');

        len = length(info);
        if strcmp(info{1}, 'republican') == 1
            label(end+1) = 1;
        else
            label(end+1) = -1;
        end

        feat = [];
        for i = 2 : len
            if strcmp(info{i}, 'y') == 1
                feat(end+1) = 1;
            elseif strcmp(info{i}, 'n') == 1
                feat(end+1) = -1;
            else
                feat(end+1) = 0;
            end
        end

        data = [data; feat];
    end
    label = label';
    fclose(fid);

    save samples.mat data label;
else
    load samples.mat;
end

end