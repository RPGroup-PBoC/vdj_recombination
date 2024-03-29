function invfunc_bin(ragANAL_RMS)

% Convert RMS to base pair length
for i=1:size(ragANAL_RMS,2)
    for l=1:length(ragANAL_RMS{1,i}(1,:))
        ragANAL_bp{1,i}(1,l) = real((-0.14 + ...
            sqrt(0.0196 - 4*(-1.77*10^-5)*(89.9-ragANAL_RMS{1,i}(1,l))))./...
            (-3.54*10^-5));
    end
end


%Compress all data onto one 2d array
data = [];

for i = 1:size(ragANAL_RMS,2)
    data(end+1:end+size(ragANAL_RMS{i},2)) = ragANAL_RMS{i};
end

for l=1:length(data)
    data_bp(l) = real((-0.14 + ...
        sqrt(0.0196 - 4*(-1.77*10^-5)*(89.9-data(l))))./...
        (-3.54*10^-5));
end

% Plot all trajectories with histogram to the side
binvect = 500:1:3000;
figure(110)
for i=1:size(ragANAL_bp,2)
    x{1,i} = linspace(0,length(ragANAL_bp{1,i})./30,length(ragANAL_bp{1,i}));
    
    subplot(1,2,1)
    plot(x{1,i},ragANAL_bp{1,i})
    
    hold on
    plot([0 4000], [2352 2352], '--r','LineWidth',2)
    plot([0 4000], [1419 1419], '--g','LineWidth',2)
    
    xlabel('Time (s)')
    ylabel('Effective DNA Length (bp)')
    plot([3600 3600], [0, 3000], ':g','LineWidth',2)
    %{
    % Plot unlooped DNA length
    plot([0 4000], [1571 1577], '--r')
    % Plot singly bound state
    plot([0 4000], [1516 1516], '--g')
    % Plot doubly bound state
    plot([0 4000], [1461 1461], '--k')
    % Plot looped state
    plot([0 4000], [952 952], '--b')
    %}
    set(gca, 'xscale','linear', 'yscale',...
        'linear','ylim',[binvect(1) binvect(end)],...
        'xlim',[0 4000],'fontsize',20);
end

subplot(1,2,2),
[n, xout] = hist(data_bp,binvect);
prob = n./sum(n(2:end-1));
barh(xout, prob)
ylim([binvect(1) binvect(end)]);
xlim([0 0.005]);



end




