
clear all
%start = 'D:\Drive\1 - Threshold\pwelch\pwelch_result';
%start = 'D:\Drive\3 - Mask\pwelch\pwelch_result';
start = 'D:\Drive\4 - Faces\pwelch\pwelch_result';
%start = 'D:\Drive\5 - Scenes\pwelch\pwelch_result\bgr\';
%start = 'D:\Drive\5 - Scenes\pwelch\pwelch_result\obj\';


root = [ start '\corrid\fooof']
files = dir(root)
files = dir([root '\*.mat'])
for i=1:length(files)
    temp = load([root '\' files(i).name]);
    data_highpas(i, 1, :) = temp.aperiodic_fit;
    data_highpas(i, 2, :) = temp.FOOOF_model;
    data_highpas(i, 3, :) = temp.Power_spectrum;
    data_highpas(i, 4, :) = temp.Spectrum_flat;
    data_highpas(i, 5, :) = temp.Spectrum_peak_rm;
    
    data_highpas_ap(i, :) = temp.aperiodic_params;
    
    data_highpas_model_fit(i, 1) = temp.r2;
    data_highpas_model_fit(i, 2) = temp.error;
    data_highpas_model_fit(i, 3, :) = temp.Central_freq; % central frequency of alpha peak
    data_highpas_model_fit(i, 4, :) = temp.Power_freq; % mean power for alpha peak
    data_highpas_model_fit(i, 5, :) = temp.Bandwith_freq; % bandwith of peak
    
end


root = [ start '\lowpas\fooof']
files = dir(root)
files = dir([root '\*.mat'])
for i=1:length(files)
    temp = load([root '\' files(i).name]);
    data_lowpas(i, 1, :) = temp.aperiodic_fit;
    data_lowpas(i, 2, :) = temp.FOOOF_model;
    data_lowpas(i, 3, :) = temp.Power_spectrum;
    data_lowpas(i, 4, :) = temp.Spectrum_flat;
    data_lowpas(i, 5, :) = temp.Spectrum_peak_rm;
    
    data_lowpas_ap(i, :) = temp.aperiodic_params;
    
    data_lowpas_model_fit(i, 1) = temp.r2;
    data_lowpas_model_fit(i, 2) = temp.error;
    data_lowpas_model_fit(i, 3, :) = temp.Central_freq; % central frequency of alpha peak
    data_lowpas_model_fit(i, 4, :) = temp.Power_freq; % mean power for alpha peak
    data_lowpas_model_fit(i, 5, :) = temp.Bandwith_freq; % bandwith of peak
end
root = [ start '\corrid\fooof']
files = dir(root)
files = dir([root '\*.mat'])
for i=1:length(files)
    temp = load([root '\' files(i).name]);
    data_corrid(i, 1, :) = temp.aperiodic_fit;
    data_corrid(i, 2, :) = temp.FOOOF_model;
    data_corrid(i, 3, :) = temp.Power_spectrum;
    data_corrid(i, 4, :) = temp.Spectrum_flat;
    data_corrid(i, 5, :) = temp.Spectrum_peak_rm;
    
    data_corrid_ap(i, :) = temp.aperiodic_params;
    
    data_corrid_model_fit(i, 1) = temp.r2;
    data_corrid_model_fit(i, 2) = temp.error;
    data_corrid_model_fit(i, 3, :) = temp.Central_freq; % central frequency of alpha peak
    data_corrid_model_fit(i, 4, :) = temp.Power_freq; % mean power for alpha peak
    data_corrid_model_fit(i, 5, :) = temp.Bandwith_freq; % bandwith of peak
end
root = [ start '\incid\fooof']
files = dir(root)
files = dir([root '\*.mat'])
for i=1:length(files)
    temp = load([root '\' files(i).name]);
    data_incid(i, 1, :) = temp.aperiodic_fit;
    data_incid(i, 2, :) = temp.FOOOF_model;
    data_incid(i, 3, :) = temp.Power_spectrum;
    data_incid(i, 4, :) = temp.Spectrum_flat;
    data_incid(i, 5, :) = temp.Spectrum_peak_rm;
    
    data_incid_ap(i, :) = temp.aperiodic_params;
    
    data_incid_model_fit(i, 1) = temp.r2;
    data_incid_model_fit(i, 2) = temp.error;
    data_incid_model_fit(i, 3, :) = temp.Central_freq; % central frequency of alpha peak
    data_incid_model_fit(i, 4, :) = temp.Power_freq; % mean power for alpha peak
    data_incid_model_fit(i, 5, :) = temp.Bandwith_freq; % bandwith of peak
end
participants = length(files);
load('freqs_mean.mat');


settings.threshold = 0.1;
idx.highpas = data_highpas_model_fit(:,2) < settings.threshold;
idx.lowpas = data_lowpas_model_fit(:,2) < settings.threshold;
idx.incid = data_incid_model_fit(:,2) < settings.threshold;
idx.corrid = data_incid_model_fit(:,2)< settings.threshold;

sum(idx.highpas)
sum(idx.lowpas)
sum(idx.incid)
sum(idx.corrid)

idx.intersect = idx.highpas & idx.lowpas & idx.incid & idx.corrid;
sum(idx.intersect)
data_highpas_clean = data_highpas(idx.intersect,:,:);
data_highpas_ap_clean = data_highpas_ap(idx.intersect,:);

data_lowpas_clean = data_lowpas(idx.intersect,:,:);
data_lowpas_ap_clean = data_lowpas_ap(idx.intersect,:);

data_corrid_clean = data_corrid(idx.intersect,:,:);
data_corrid_ap_clean = data_corrid_ap(idx.intersect,:);

data_incid_clean = data_incid(idx.intersect,:,:);
data_incid_ap_clean = data_incid_ap(idx.intersect,:);




%%

mkdir(start, 'csv_export')
cd([ start '/csv_export'])
clear aperiodic
aperiodic(1, :) = [1:participants]
aperiodic(2, :) = squeeze(mean(data_highpas(:, 1,  [freqs>7 & freqs< 14]), 3))
aperiodic(3, :) = squeeze(mean(data_lowpas(:, 1,  [freqs>7 & freqs< 14]), 3))
aperiodic(4, :) = squeeze(mean(data_corrid(:, 1,  [freqs>7 & freqs< 14]), 3))
aperiodic(5, :) = squeeze(mean(data_incid(:, 1,  [freqs>7 & freqs< 14]), 3))
aperiodic = aperiodic.'

writematrix(aperiodic,'aperiodic.csv') 

clear FOOOF
FOOOF(1, 1:participants) = [1:participants]
FOOOF(2, :) = squeeze(mean(data_highpas(:, 2,  [freqs>7 & freqs< 14]), 3))
FOOOF(3, :) = squeeze(mean(data_lowpas(:, 2,  [freqs>7 & freqs< 14]), 3))
FOOOF(4, :) = squeeze(mean(data_corrid(:, 2,  [freqs>7 & freqs< 14]), 3))
FOOOF(5, :) = squeeze(mean(data_incid(:, 2,  [freqs>7 & freqs< 14]), 3))
FOOOF = FOOOF.'

writematrix(FOOOF,'FOOOF.csv') 

clear spectra
spectra(1, 1:participants) = [1:participants]
spectra(2, :) = squeeze(mean(data_highpas(:, 3,  [freqs>7 & freqs< 14]), 3))
spectra(3, :) = squeeze(mean(data_lowpas(:, 3,  [freqs>7 & freqs< 14]), 3))
spectra(4, :) = squeeze(mean(data_corrid(:, 3,  [freqs>7 & freqs< 14]), 3))
spectra(5, :) = squeeze(mean(data_incid(:, 3,  [freqs>7 & freqs< 14]), 3))
spectra = spectra.'

writematrix(spectra,'spectra.csv') 

clear difference
difference(1, 1:participants) = [1:participants]
difference(2, :) = squeeze(mean(data_highpas(:, 3,  [freqs>7 & freqs< 14]), 3)) - squeeze(mean(data_highpas(:, 1,  [freqs>7 & freqs< 14]), 3))
difference(3, :) = squeeze(mean(data_lowpas(:, 3,  [freqs>7 & freqs< 14]), 3)) - squeeze(mean(data_lowpas(:, 1,  [freqs>7 & freqs< 14]), 3))
difference(4, :) = squeeze(mean(data_corrid(:, 3,  [freqs>7 & freqs< 14]), 3)) - squeeze(mean(data_corrid(:, 1,  [freqs>7 & freqs< 14]), 3))
difference(5, :) = squeeze(mean(data_incid(:, 3,  [freqs>7 & freqs< 14]), 3)) - squeeze(mean(data_incid(:, 1,  [freqs>7 & freqs< 14]), 3))
difference = difference.'

writematrix(difference,'difference.csv') 


clear spectrum_flat
spectrum_flat(1, 1:participants) = [1:participants]
spectrum_flat(2, :) = squeeze(mean(data_highpas(:, 4,  [freqs>7 & freqs< 14]), 3)) 
spectrum_flat(3, :) = squeeze(mean(data_lowpas(:, 4,  [freqs>7 & freqs< 14]), 3)) 
spectrum_flat(4, :) = squeeze(mean(data_corrid(:, 4,  [freqs>7 & freqs< 14]), 3))
spectrum_flat(5, :) = squeeze(mean(data_incid(:, 4,  [freqs>7 & freqs< 14]), 3)) 
spectrum_flat = spectrum_flat.'

writematrix(spectrum_flat,'spectrum_flat.csv') 

clear spectrum_peak_rm
spectrum_peak_rm(1, 1:participants) = [1:participants]
spectrum_peak_rm(2, :) = squeeze(mean(data_highpas(:, 5,  [freqs>7 & freqs< 14]), 3))
spectrum_peak_rm(3, :) = squeeze(mean(data_lowpas(:, 5,  [freqs>7 & freqs< 14]), 3)) 
spectrum_peak_rm(4, :) = squeeze(mean(data_corrid(:, 5,  [freqs>7 & freqs< 14]), 3))
spectrum_peak_rm(5, :) = squeeze(mean(data_incid(:, 5,  [freqs>7 & freqs< 14]), 3)) 
spectrum_peak_rm = spectrum_peak_rm.'

writematrix(spectrum_peak_rm,'spectrum_peak_rm.csv') 

clear exponent
exponent(1, 1:participants) = [1:participants]
exponent(2, :) = data_highpas_ap(:, 1);
exponent(3, :) = data_lowpas_ap(:, 1);
exponent(4, :) = data_corrid_ap(:, 1);
exponent(5, :) = data_incid_ap(:, 1);
exponent = exponent.'
writematrix(exponent, 'exponent.csv');


clear offset
offset(1, 1:participants) = [1:participants]
offset(2, :) = data_highpas_ap(:, 2);
offset(3, :) = data_lowpas_ap(:, 2);
offset(4, :) = data_corrid_ap(:, 2);
offset(5, :) = data_incid_ap(:, 2);
offset = offset.'
writematrix(offset, 'offset.csv');

clear central_freq
central_freq(1, 1:participants) = [1:participants]
central_freq(2,:) = data_highpas_model_fit(:, 3);
central_freq(3,:) = data_lowpas_model_fit(:, 3);
central_freq(4,:) = data_corrid_model_fit(:, 3);
central_freq(5,:) = data_incid_model_fit(:, 3);
central_freq = central_freq.'
writematrix(central_freq, 'central_freq.csv');

clear power_freq
power_freq(1, 1:participants) = [1:participants]
power_freq(2,:) = data_highpas_model_fit(:, 4);
power_freq(3,:) = data_lowpas_model_fit(:, 4);
power_freq(4,:) = data_corrid_model_fit(:, 4);
power_freq(5,:) = data_incid_model_fit(:, 4);
power_freq = power_freq.'
writematrix(power_freq, 'power_freq.csv');

clear bandwith_freq
bandwith_freq(1, 1:participants) = [1:participants]
bandwith_freq(2,:) = data_highpas_model_fit(:, 5);
bandwith_freq(3,:) = data_highpas_model_fit(:, 5);
bandwith_freq(4,:) = data_highpas_model_fit(:, 5);
bandwith_freq(5,:) = data_highpas_model_fit(:, 5);
bandwith_freq = bandwith_freq.'
writematrix(bandwith_freq, 'bandwith_freq.csv');



results_names = ["id_aperiodic", "aperiodic_highpas", "aperiodic_lowpas", "aperiodic_corrid", "aperiodic_incid", "id_fooof", "fooof_highpas", "fooof_lowpas", "fooof_corrid", "fooof_incid", "id_spectra", "spectra_highpas", "spectra_lowpas", "spectra_corrid", "spectra_incid", "id_difference", "difference_highpas", "difference_lowpas", "difference_corrid", "difference_incid", "id_spectrum_flat", "spectrum_flat_highpas", "spectrum_flat_lowpas", "spectrum_flat_corrid", "spectrum_flat_incid", "id_spectrum_peak_rm", "spectrum_peak_rm_highpas", "spectrum_peak_rm_lowpas", "spectrum_peak_rm_corrid", "spectrum_peak_rm_incid", "id_exponent", "exponent_highpas", "exponent_lowpas", "exponent_corrid", "exponent_incid", "id_offset", "offset_flat_highpas", "offset_flat_lowpas", "offset_flat_corrid", "offset_flat_incid", "id_central_freq", "central_freq_highpas", "central_freq_lowpas", "central_freq_corrid", "central_freq_incid", "id_power_freq", "power_freq_highpas", "power_freq_lowpas", "power_freq_corrid", "power_freq_incid", "id_bandwith", "bandwith_freq_highpas", "bandwith_freq_lowpas", "bandwith_freq_corrid", "bandwith_freq_incid"]
results = [aperiodic FOOOF spectra difference spectrum_flat spectrum_peak_rm, exponent offset central_freq power_freq bandwith_freq]

results_table = array2table(results, 'VariableNames', results_names)
writetable(results_table, 'results.csv');


%%
participants = sum(idx.intersect);
clear aperiodic
aperiodic(1, :) = [1:participants]
aperiodic(2, :) = squeeze(mean(data_highpas_clean(:, 1,  [freqs>7 & freqs< 14]), 3))
aperiodic(3, :) = squeeze(mean(data_lowpas_clean(:, 1,  [freqs>7 & freqs< 14]), 3))
aperiodic(4, :) = squeeze(mean(data_corrid_clean(:, 1,  [freqs>7 & freqs< 14]), 3))
aperiodic(5, :) = squeeze(mean(data_incid_clean(:, 1,  [freqs>7 & freqs< 14]), 3))
aperiodic = aperiodic.'

writematrix(aperiodic,'aperiodic.csv') 

clear FOOOF
FOOOF(1, 1:participants) = [1:participants]
FOOOF(2, :) = squeeze(mean(data_highpas_clean(:, 2,  [freqs>7 & freqs< 14]), 3))
FOOOF(3, :) = squeeze(mean(data_lowpas_clean(:, 2,  [freqs>7 & freqs< 14]), 3))
FOOOF(4, :) = squeeze(mean(data_corrid_clean(:, 2,  [freqs>7 & freqs< 14]), 3))
FOOOF(5, :) = squeeze(mean(data_incid_clean(:, 2,  [freqs>7 & freqs< 14]), 3))
FOOOF = FOOOF.'

writematrix(FOOOF,'FOOOF.csv') 

clear spectra
spectra(1, 1:participants) = [1:participants]
spectra(2, :) = squeeze(mean(data_highpas_clean(:, 3,  [freqs>7 & freqs< 14]), 3))
spectra(3, :) = squeeze(mean(data_lowpas_clean(:, 3,  [freqs>7 & freqs< 14]), 3))
spectra(4, :) = squeeze(mean(data_corrid_clean(:, 3,  [freqs>7 & freqs< 14]), 3))
spectra(5, :) = squeeze(mean(data_incid_clean(:, 3,  [freqs>7 & freqs< 14]), 3))
spectra = spectra.'

writematrix(spectra,'spectra.csv') 

clear difference
difference(1, 1:participants) = [1:participants]
difference(2, :) = squeeze(mean(data_highpas_clean(:, 3,  [freqs>7 & freqs< 14]), 3)) - squeeze(mean(data_highpas_clean(:, 1,  [freqs>7 & freqs< 14]), 3))
difference(3, :) = squeeze(mean(data_lowpas_clean(:, 3,  [freqs>7 & freqs< 14]), 3)) - squeeze(mean(data_lowpas_clean(:, 1,  [freqs>7 & freqs< 14]), 3))
difference(4, :) = squeeze(mean(data_corrid_clean(:, 3,  [freqs>7 & freqs< 14]), 3)) - squeeze(mean(data_corrid_clean(:, 1,  [freqs>7 & freqs< 14]), 3))
difference(5, :) = squeeze(mean(data_incid_clean(:, 3,  [freqs>7 & freqs< 14]), 3)) - squeeze(mean(data_incid_clean(:, 1,  [freqs>7 & freqs< 14]), 3))
difference = difference.'

writematrix(difference,'difference.csv') 

clear exponent
exponent(1, 1:participants) = [1:participants]
exponent(2, :) = data_highpas_ap_clean(:, 1);
exponent(3, :) = data_lowpas_ap_clean(:, 1);
exponent(4, :) = data_corrid_ap_clean(:, 1);
exponent(5, :) = data_incid_ap_clean(:, 1);
exponent = exponent.'
writematrix(exponent, 'exponent.csv');


clear offset
offset(1, 1:participants) = [1:participants]
offset(2, :) = data_highpas_ap_clean(:, 2);
offset(3, :) = data_lowpas_ap_clean(:, 2);
offset(4, :) = data_corrid_ap_clean(:, 2);
offset(5, :) = data_incid_ap_clean(:, 2);
offset = offset.'
writematrix(offset, 'offset.csv');







%%
%% additional plots




figure; hold on
plot(squeeze(mean(data_corrid(:, 1, :), 1)))
plot(squeeze(mean(data_corrid(:, 2, :), 1)))
plot(squeeze(mean(data_corrid(:, 3, :), 1)))
figure; hold on
plot(squeeze(mean(data_corrid_clean(:, 1, :), 1)))
plot(squeeze(mean(data_corrid_clean(:, 2, :), 1)))
plot(squeeze(mean(data_corrid_clean(:, 3, :), 1)))


figure; hold on
plot(squeeze(mean(data_incid(:, 1, :), 1)))
plot(squeeze(mean(data_incid(:, 2, :), 1)))
plot(squeeze(mean(data_incid(:, 3, :), 1)))


figure; hold on
plot(squeeze(mean(data_highpas(:, 1, :), 1)))
plot(squeeze(mean(data_highpas(:, 2, :), 1)))
plot(squeeze(mean(data_highpas(:, 3, :), 1)))


figure; hold on
plot(squeeze(mean(data_lowpas(:, 1, :), 1)))
plot(squeeze(mean(data_lowpas(:, 2, :), 1)))
plot(squeeze(mean(data_lowpas(:, 3, :), 1)))


figure; hold on
plot(squeeze(mean(data_incid(:, 1, :), 1)))
plot(squeeze(mean(data_corrid(:, 1, :), 1)))
plot(squeeze(mean(data_highpas(:, 1, :), 1)))
plot(squeeze(mean(data_lowpas(:, 1, :), 1)))

freqs = 1:40
logfreqs = log(freqs)
figure; hold on
plot(logfreqs, squeeze(mean(data_incid(:, 1, :), 1)), 'g')
plot(logfreqs, squeeze(mean(data_corrid(:, 1, :), 1)), 'y')
plot(logfreqs, squeeze(mean(data_highpas(:, 1, :), 1)), 'b')
plot(logfreqs, squeeze(mean(data_lowpas(:, 1, :), 1)), 'r')

figure; hold on
for i=1:size(data_corrid, 1)
plot(logfreqs, (squeeze(data_incid(i, 1, :))),'r')
plot(logfreqs, (squeeze(data_corrid(i, 1, :))),'b')
%plot(logfreqs, (squeeze(data_highpas(i, 1, :))), 'b')
%plot(logfreqs, (squeeze(data_lowpas(i, 1, :))), 'r')
%plot(logfreqs, (squeeze(data_incid(i, 2, :))))
%plot(logfreqs, (squeeze(data_incid(i, 3, :))))
end

figure; hold on
for i=1:size(data_corrid, 1)
plot(freqs, (squeeze(data_incid(i, 1, :))),'r')
plot(freqs, (squeeze(data_corrid(i, 1, :))),'b')
%plot(logfreqs, (squeeze(data_highpas(i, 1, :))), 'b')
%plot(logfreqs, (squeeze(data_lowpas(i, 1, :))), 'r')
%plot(logfreqs, (squeeze(data_incid(i, 2, :))))
%plot(logfreqs, (squeeze(data_incid(i, 3, :))))
end

figure; hold on

plot(squeeze(mean(data_incid(:, 2, :), 1)))
plot(squeeze(mean(data_corrid(:, 2, :), 1)))
plot(squeeze(mean(data_highpas(:, 2, :), 1)))
plot(squeeze(mean(data_lowpas(:, 2, :), 1)))

figure; hold on

plot(squeeze(mean(data_incid(:, 3, :), 1)))
plot(squeeze(mean(data_corrid(:, 3, :), 1)))
plot(squeeze(mean(data_highpas(:, 3, :), 1)))
plot(squeeze(mean(data_lowpas(:, 3, :), 1)))



figure; hold on 
for i=1:size(data_highpas, 1)
plot(mean(data_highpas(i, :, [freqs>8 & freqs< 14]), 3))
end

figure; hold on 
for i=1:size(data_highpas, 1)
plot(mean(data_lowpas(i, :, [freqs>8 & freqs< 14]), 3))
end



%%



clear aperiodic_fit fooof_model Power_spectrum difference*
% Top two plots
tiledlayout(2,2)
nexttile



for i=1:length(data_corrid)
aperiodic_fit(i,1) = mean(data_corrid(i, 1, [freqs>8 & freqs< 14]), 3);
aperiodic_fit(i,2) = mean(data_incid(i, 1, [freqs>8 & freqs< 14]), 3);
end

%figure; hold on; 
hold on;
title('aperiodic fit correct vs incorrect')
for i = 1:length(aperiodic_fit)
plot(aperiodic_fit(i, :))
end
%plot(mean(aperiodic_fit, 1), '--gs', 'LineWidth',2,'MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5])
X_plot = mean(aperiodic_fit, 1)
error = sem(aperiodic_fit)
errorbar(X_plot, error, '--gs', 'LineWidth',2,'MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5])
xticks([1, 2])
xticklabels({'correct', 'incorrect'})
hold off;
%%
nexttile
for i=1:length(data_corrid)
fooof_model(i,1) = mean(data_corrid(i, 2, [freqs>8 & freqs< 14]), 3);
fooof_model(i,2) = mean(data_incid(i, 2, [freqs>8 & freqs< 14]), 3);
end

%figure; hold on; 
hold on;
title('fooof model fit correct vs incorrect')
for i = 1:length(fooof_model)
plot(fooof_model(i, :))
end
%plot(mean(fooof_model, 1), '--gs', 'LineWidth',2,'MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5])
X_plot = mean(fooof_model, 1)
error = sem(fooof_model)
errorbar(X_plot, error, '--gs', 'LineWidth',2,'MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5])
xticks([1, 2])
xticklabels({'correct', 'incorrect'})
hold off;

%%
nexttile
for i=1:length(data_corrid)
Power_spectrum(i,1) = mean(data_corrid(i, 3, [freqs>8 & freqs< 14]), 3);
Power_spectrum(i,2) = mean(data_incid(i, 3, [freqs>8 & freqs< 14]), 3);
end

%figure; hold on; 
hold on
title('mean power spectrum for 8-14Hz correct vs incorrect')
for i = 1:length(Power_spectrum)
plot(Power_spectrum(i, :))
end
X_plot = mean(Power_spectrum, 1)
error = sem(Power_spectrum)
%plot(mean(Power_spectrum, 1), '--gs', 'LineWidth',2,'MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5])
errorbar(X_plot, error, '--gs', 'LineWidth',2,'MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5])
xticks([1, 2])
xticklabels({'correct', 'incorrect'})
hold off

%%
nexttile

hold on
title('overall model')

plot(squeeze(mean(data_corrid(:, 1, :), 1)))
plot(squeeze(mean(data_corrid(:, 2, :), 1)))
plot(squeeze(mean(data_corrid(:, 3, :), 1)))

plot(squeeze(mean(data_incid(:, 1, :), 1)))
plot(squeeze(mean(data_incid(:, 2, :), 1)))
plot(squeeze(mean(data_incid(:, 3, :), 1)))

legend('corrid aperiodic', 'corrid FOOOF model', 'corrid power spectrum', 'incid aperiodic', 'incid FOOOF model', 'incid power spectrum')
xlabel('Freqs')


%%
difference_corrid = data_corrid(:, 3, :) - data_corrid(:, 1, :)
difference_incid = data_incid(:, 3, :) - data_incid(:, 1, :)

figure; hold on;
title('power spectrum - aperiodic')
plot(squeeze(mean(difference_corrid, 1)))
plot(squeeze(mean(difference_incid, 1)))
legend('correct', 'incorrect')
xlabel('Freqs')










%%
%%
%%
%%
%%


clear aperiodic_fit fooof_model Power_spectrum difference*


% Top two plots
tiledlayout(2,2)
nexttile



for i=1:length(data_highpas)
aperiodic_fit(i,1) = mean(data_highpas(i, 1, [freqs>8 & freqs< 14]), 3);
aperiodic_fit(i,2) = mean(data_lowpas(i, 1, [freqs>8 & freqs< 14]), 3);
end

%figure; hold on; 
hold on;
title('aperiodic fit highpas vs lowpas')
for i = 1:length(aperiodic_fit)
plot(aperiodic_fit(i, :))
end
%plot(mean(aperiodic_fit, 1), '--gs', 'LineWidth',2,'MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5])
X_plot = mean(aperiodic_fit, 1)
error = sem(aperiodic_fit)
errorbar(X_plot, error, '--gs', 'LineWidth',2,'MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5])
xticks([1, 2])
xticklabels({'highpas', 'lowpas'})
hold off;
%%
nexttile
for i=1:length(data_highpas)
fooof_model(i,1) = mean(data_highpas(i, 2, [freqs>8 & freqs< 14]), 3);
fooof_model(i,2) = mean(data_lowpas(i, 2, [freqs>8 & freqs< 14]), 3);
end

%figure; hold on; 
hold on;
title('fooof model fit highpas vs lowpas')
for i = 1:length(fooof_model)
plot(fooof_model(i, :))
end
%plot(mean(fooof_model, 1), '--gs', 'LineWidth',2,'MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5])
X_plot = mean(fooof_model, 1)
error = sem(fooof_model)
errorbar(X_plot, error, '--gs', 'LineWidth',2,'MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5])
xticks([1, 2])
xticklabels({'highpas', 'lowpas'})
hold off;

%%
nexttile
for i=1:length(data_highpas)
Power_spectrum(i,1) = mean(data_highpas(i, 3, [freqs>8 & freqs< 14]), 3);
Power_spectrum(i,2) = mean(data_lowpas(i, 3, [freqs>8 & freqs< 14]), 3);
end

%figure; hold on; 
hold on
title('mean power spectrum for 8-14Hz highpas vs lowpas')
for i = 1:length(Power_spectrum)
plot(Power_spectrum(i, :))
end
X_plot = mean(Power_spectrum, 1)
error = sem(Power_spectrum)
%plot(mean(Power_spectrum, 1), '--gs', 'LineWidth',2,'MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5])
errorbar(X_plot, error, '--gs', 'LineWidth',2,'MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5])
xticks([1, 2])
xticklabels({'highpas', 'lowpas'})
hold off

%%
nexttile

hold on
title('overall model')

plot(squeeze(mean(data_highpas(:, 1, :), 1)))
plot(squeeze(mean(data_highpas(:, 2, :), 1)))
plot(squeeze(mean(data_highpas(:, 3, :), 1)))

plot(squeeze(mean(data_lowpas(:, 1, :), 1)))
plot(squeeze(mean(data_lowpas(:, 2, :), 1)))
plot(squeeze(mean(data_lowpas(:, 3, :), 1)))

legend('highpas aperiodic', 'highpas FOOOF model', 'highpas power spectrum', 'lowpas aperiodic', 'lowpas FOOOF model', 'lowpas power spectrum')
xlabel('Freqs')


%%
difference_corrid = data_highpas(:, 3, :) - data_highpas(:, 1, :)
difference_incid = data_lowpas(:, 3, :) - data_lowpas(:, 1, :)

figure; hold on;
title('power spectrum - aperiodic')
plot(squeeze(mean(difference_corrid, 1)))
plot(squeeze(mean(difference_incid, 1)))
legend('highpas', 'lowpas')
xlabel('Freqs')

