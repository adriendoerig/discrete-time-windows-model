function [dataLength4, dataLength8, dataLength18] = makeData()
%MAKEDATA reads data from excel file and formats it properly.
% format is a 1x6 cell for each experiment, containing the data
% for each of the six subjects (a vector with conditions
% in the same order as in the excel file:
% [V AVi AVii AViii VAVi VAVii VAViii VPVi VPVii VPViii].

% load from excel file NOTE: if an error comes up saying the worksheet 
% could not be activated, open the excel file, switch to Sheet1 and save.
% if it still doesn't work, close and reopen matlab.
rawDataLength4 = xlsread('Results Explosion Informed.xlsx', 'E4'); 
rawDataLength8 = xlsread('Results Explosion Informed.xlsx', 'E8');
rawDataLength18 = xlsread('Results Explosion Informed.xlsx', 'E18');

% remove useless entries (empty cells, nSubjects, etc) and shift averages
% to last column.
rawDataLength4(isnan(rawDataLength4(:,1)),:) = [];
rawDataLength4(:,[2 3]) = [];
rawDataLength4 = circshift(rawDataLength4,-1,2);
rawDataLength8(isnan(rawDataLength8(:,1)),:) = [];
rawDataLength8(:,[2 3]) = [];
rawDataLength8 = circshift(rawDataLength8,-1,2);
rawDataLength18(isnan(rawDataLength18(:,1)),:) = [];
rawDataLength18(:,[2 3]) = [];
rawDataLength18 = circshift(rawDataLength18,-1,2);

dataLength4 = cell(1,7);
dataLength8 = cell(1,7);
dataLength18 = cell(1,7);

% AVG is in position 7, and subjects 1->6 are in 1->6
for subject = 1:7
    dataLength4{subject} = rawDataLength4(:,subject);
    dataLength8{subject} = rawDataLength8(:,subject);
    dataLength18{subject} = rawDataLength18(:,subject);
end