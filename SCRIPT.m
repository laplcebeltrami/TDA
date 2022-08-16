% The script explains how to compute and display monotone Betti-0 
% and Betti-1 curves over graph filtations introduced in
%
% Chung, M.K., Lee, H. Ombao. H., Solo, V. 2019 Exact topological inference 
% of the resting-state brain networks in twins, Network Neuroscience 3:674-694
% https://pages.stat.wisc.edu/~mchung/papers/chung.2019.NN
%
% Chung, M.K., Huang, S.-G., Gritsenko, A., Shen, L., Lee, H. 2019 Statistical 
% inference on the number of cycles in brain networks. IEEE International 
% Symposium on Biomedical Imaging (ISBI) 113-116 
% https://pages.stat.wisc.edu/~mchung/papers/chung.2019.ISBI.pdf
%
%
% (C) 2022 Moo K. Chung
%  University of Wisconsin-Madison
%
% The codes are downloaded from https://github.com/laplcebeltrami/TDA


load gng.mat %gng.mat contains variables gng_inh gng_ini
%gng_inh is 100 by 100 connectivity matrix of inhibition task for 144
%subjects. gng_ini is 100 by 100 connectivity matrix of initiation task for 144
%subjects. The same subject are used for two different tasks. 

%-----------
%Computing Betti-0 curves

thresholds=[0:0.01:1];
betti0=[];
for i=1:114
    [beta0, beta1, biggest0, biggest1] = PH_betti3(gng_ini(:,:,i), thresholds);
    betti0=[betti0; beta0];
end
mean_ini = mean(betti0,1); %average Betti-0 curve

betti0=[];
for i=1:114
    [beta0, beta1, biggest0, biggest1] = PH_betti3(gng_inh(:,:,i), thresholds);
    betti0=[betti0; beta0];
end
mean_inh = mean(betti0,1); %average Betti-0 curve  


%Visualizing Betti-0 curves
figure; 
subplot(1,2,1);
plot(thresholds,mean_ini, 'k', 'LineWidth',2,'LineStyle','-')
hold on; plot(thresholds,mean_inh, 'r', 'LineWidth',2,'LineStyle','--')
legend('Initiation', 'inhibition')
set(gca,'FontSize',25);
legend boxoff 
xlabel('Correlations');
ylabel('\beta_0'); box on;


%-----------
%Computing Betti-1 curves

thresholds=[0:0.01:1];
betti1=[];
for i=1:114
    [beta0, beta1, biggest0, biggest1] = PH_betti3(gng_ini(:,:,i), thresholds);
    betti1=[betti1; beta1];
end
mean_ini = mean(betti1,1); %average Betti-1 curve

betti1=[];
for i=1:114
    [beta0, beta1, biggest0, biggest1] = PH_betti3(gng_inh(:,:,i), thresholds);
    betti1=[betti1; beta1]; 
end
mean_inh = mean(betti1,1); %average Betti-1 curve

%Visualizing Betti-1 curves
subplot(1,2,2);
hold on; plot(thresholds,mean_ini, 'k', 'LineWidth',2,'LineStyle','-')
hold on; plot(thresholds,mean_inh, 'r', 'LineWidth',2,'LineStyle','--')
legend('Initiation', 'inhibition')
set(gca,'FontSize',25);
legend boxoff 
xlabel('Correlations');
ylabel('\beta_1'); box on;
figure_bg('w')
