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
        if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [100 101 106 107])
            EEG.event(i).identification = EEG.event(i+1).type
        end
        if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
            EEG.event(i).pas = EEG.event(i+2).type
        elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
            EEG.event(i).pas = EEG.event(i+3).type
        elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
            EEG.event(i).pas = EEG.event(i+4).type
        end
    end
end