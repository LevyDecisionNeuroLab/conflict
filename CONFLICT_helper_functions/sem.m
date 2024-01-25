function [sem_v] = sem(v)
%SEM Summary of this function goes here
%   Detailed explanation goes here
sem_v = std(v)./sqrt(length(v)-1);
end

