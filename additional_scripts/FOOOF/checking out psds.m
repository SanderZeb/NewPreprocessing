
%start = 'D:\Drive\1 - Threshold';
start = 'D:\Drive\4 - Faces';
root = [ start '\pwelch\pwelch_result\corrid']
files = dir(root)
files = dir([root '\*.mat'])
for i=1:length(files)
    temp = load([root '\' files(i).name])
    data_corrid(i,:) = temp.corr_id
end


root = [ start '\pwelch\pwelch_result\incid']
files = dir(root)
files = dir([root '\*.mat'])
for i=1:length(files)
    temp = load([root '\' files(i).name])
    data_incid(i,:) = temp.inc_id
end



root = [ start '\pwelch\pwelch_result\highpas']
files = dir(root)
files = dir([root '\*.mat'])
for i=1:length(files)
    temp = load([root '\' files(i).name])
    data_highpas(i,:) = temp.highpas
end


root = [ start '\pwelch\pwelch_result\lowpas']
files = dir(root)
files = dir([root '\*.mat'])
for i=1:length(files)
    temp = load([root '\' files(i).name])
    data_lowpas(i,:) = temp.lowpas
end

bin_low = min(min(data))
bin_max = max(max(data))

histogram(data, [bin_low bin_max])
histogram(mean(data))


bar(mean(data_corrid))
bar(mean(data_incid))
bar(mean(data_lowpas))
bar(mean(data_highpas))


bar(median(data_corrid))
bar(median(data_incid))
bar(median(data_lowpas))
bar(median(data_highpas))




bar(median(data_highpas.'))
bar(mean(data_highpas.'))
highpas to drop = 74 85 
data_highpas([74 85 ], :) = []

bar(median(data_lowpas.'))
bar(mean(data_lowpas.'))
lowpas to drop = 74 85  39
data_lowpas([74 85 39], :) = []


bar(median(data_corrid.'))
bar(mean(data_corrid.'))
corrid to drop = 74 85 
data_corrid([74 85], :) = []


bar(median(data_incid.'))
bar(mean(data_incid.'))
corrid to drop = 39 74 85
data_incid([74 85 39], :) = []


figure; hold on
plot(freqs, mean(data_highpas))
plot(freqs, mean(data_lowpas))
ylim([0, 4.5])

figure; hold on
plot(freqs, mean(data_corrid))
plot(freqs, mean(data_incid))
ylim([0, 4.5])