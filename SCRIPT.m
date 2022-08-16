%Downloaded from https://osf.io/hnj7s/

gng_inh=zeros(100,100,144);
for i=1:144
    subid = sprintf('%03d',i);
    filename = strcat('Schaefer100_17_sub-',subid, '_gng_inhibition.txt');
    a= load(filename);
    gng_inh(:,:,i)=a;
end


gng_ini=zeros(100,100,144);
for i=1:144
    subid = sprintf('%03d',i);
    filename = strcat('Schaefer100_17_sub-',subid, '_gng_initiation.txt');
    a= load(filename);
    gng_ini(:,:,i)=a;
end

%save gng.mat gng_inh gng_ini

%gng_inh is 100 by 100 connectivity matrix of inhibition task for 144
%subjects. gng_ini is 100 by 100 connectivity matrix of initiation task for 144
%subjects. The same subject are used for two different tasks. 

thresholds=[0:0.01:1];
betti0=[];
for i=1:114
    [beta0, beta1, biggest0, biggest1] = PH_betti3(gng_ini(:,:,i), thresholds);
    betti0=[betti0; beta0];
end
mean_ini = mean(betti0,1);
betti0=[];
for i=1:114
    [beta0, beta1, biggest0, biggest1] = PH_betti3(gng_inh(:,:,i), thresholds);
    betti0=[betti0; beta0];
end
mean_inh = mean(betti0,1);

figure; 
subplot(1,2,1);
plot(thresholds,mean_ini, 'k', 'LineWidth',2,'LineStyle','-')
hold on; plot(thresholds,mean_inh, 'r', 'LineWidth',2,'LineStyle','--')
legend('Initiation', 'inhibition')
set(gca,'FontSize',25);
legend boxoff 
xlabel('Correlations');
ylabel('\beta_0');


%----------
%Betti-1

thresholds=[0:0.01:1];
betti1=[];
for i=1:114
    [beta0, beta1, biggest0, biggest1] = PH_betti3(gng_ini(:,:,i), thresholds);
    betti1=[betti1; beta1];
end
mean_ini = mean(betti1,1);

betti1=[];
for i=1:114
    [beta0, beta1, biggest0, biggest1] = PH_betti3(gng_inh(:,:,i), thresholds);
    betti1=[betti1; beta1];
end
mean_inh = mean(betti1,1);


subplot(1,2,2);
hold on; plot(thresholds,mean_ini, 'k', 'LineWidth',2,'LineStyle','-')
hold on; plot(thresholds,mean_inh, 'r', 'LineWidth',2,'LineStyle','--')
legend('Initiation', 'inhibition')
set(gca,'FontSize',25);
legend boxoff 
xlabel('Correlations');
ylabel('\beta_1');

figure_bg('w')
