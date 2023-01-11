path_csvs = 'C:\Users\user\Desktop\Behawior\Scenes\';
list_csvs = dir([path_csvs '*.csv'])

load('D:\Drive\5 - Scenes\events.mat');


for i = 1:length(events)

    id(i,:) = events{i}(1).participant;

end


for i = 1:length(list_csvs)
    
    if any(contains(string([id(:, 1:5)]), list_csvs(i).name(1:5) ))
        idx.listcsvs(i) = 1;
        idx.events(i) = find(contains(string([id(:, 1:5)]), list_csvs(i).name(1:5) ) == 1);
        to_load(i).csv = list_csvs(i).name;
        to_load(i).events = events(find(contains(string([id(:, 1:5)]), list_csvs(i).name(1:5) ) == 1));
    else
        idx(i) = 0;
    end
end