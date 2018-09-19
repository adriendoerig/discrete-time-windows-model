stims = [50 0 40;
    50 40 40;
    50 90 40;
    50 130 40;
    50 170 40]; %in ms

perfs = zeros(1,size(stims,1));

for i = 1:size(stims,1)
    i
    [~, perfs(i)] = decisionNeuralExplosion(stims(i,:)./1000, [0.1   22  35 .3 0.01, 0.5]);
end

figure()
plot(1:size(stims,1),perfs)