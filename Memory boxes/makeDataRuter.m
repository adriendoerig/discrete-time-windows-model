function data = makeDataRuter()
%MAKEDATA creates data for rüter's expmt and formats it properly.
% format is a 1x8 cell for each experiment, containing the data
% for each of the six subjects (a vector with conditions
% in the same order as in the excel file:
% the conditions are vernier [s]- anti-vernier [s]
% 0.004, 0.016;
% 0.01,  0.01;
% 0.016, 0.004;
% 0.008, 0.032;
% 0.02,  0.02;
% 0.032, 0.008;
% 0.016, 0.064;
% 0.04,  0.04;
% 0.064, 0.016;
% 0.032, 0.128;
% 0.08,  0.08;
% 0.128, 0.032


data = cell(1,9);

% AVG is in position 9, and subjects 1->8 are in 1->8
data{1} = [28,39,65,16,30,65.5,17,21.5,57.5,10.5,38.5,55.5];
data{2} = [38.3,50.26,65.43,34.58,53.35,64.17,25.82,42.86,63.64,25.33,41.42,69.61];
data{3} = [22.17,47.5,75,23.5,44.25,72.25,18.3,43.86,70.5,20.6,37.34,74.12];
data{4} = [19.80,47.18,79.7,13.6,38.5,82.05,11.9,28.5,71.14,4.79,29.59,77.08];
data{5} = [22.08,45.98,74.56,16.5,39.44,68.43,15.19,26.45,67.59,12.85,19.75,57];
data{6} = [36.68,46.7,61.42,29.72,45.71,68.09,27.37,39.35,69.05,22.61,36.93,72.22];
data{7} = [35.95,52.9,71.78,29.19,50.67,67.21,20.28,42.42,73.38,23.13,47.97,74.01];
data{8} = [21.65,40.1,78.84,11.89,28.8,60.32,13.23,26.46,71.66,8.38,17.95,48.44];

% fill data{9} with average values
nConds = length(data{1});
nSubjects = 8;
data{9} = zeros(1,nConds);
for c = 1:nConds
    for s = 1:nSubjects
        data{9}(c) = data{9}(c)+data{s}(c)/nSubjects;
    end
end