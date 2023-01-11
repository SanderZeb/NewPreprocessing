load('C:\Users\user\Desktop\app_test\paths.mat')

for i = 1:length(paths)
if paths(i).exp1 == 1 & paths(i).exp3 == 1
idx(i).exp13 = 1 ;
else
idx(i).exp13 = 0;
end
end

for i = 1:length(paths)
if paths(i).exp3 == 1 & paths(i).exp4 == 1
idx(i).exp34 = 1 ;
else
idx(i).exp34 = 0;
end
end

for i = 1:length(paths)
if paths(i).exp1 == 1 & paths(i).exp4 == 1
idx(i).exp14 = 1 ;
else
idx(i).exp14 = 0;
end
end

for i = 1:length(paths)
if paths(i).exp1 == 1 & paths(i).exp2 == 1
idx(i).exp12 = 1 ;
else
idx(i).exp12 = 0;
end
end

for i = 1:length(paths)
if paths(i).exp3 == 1 & paths(i).exp5 == 1
idx(i).exp35 = 1 ;
else
idx(i).exp35 = 0;
end
end
for i = 1:length(paths)
if paths(i).exp4 == 1 & paths(i).exp5 == 1
idx(i).exp45 = 1 ;
else
idx(i).exp45 = 0;
end
end

sum([idx.exp13])
sum([idx.exp34])
sum([idx.exp14])
sum([idx.exp12])
sum([idx.exp35])
sum([idx.exp45])

events.exp1 = [];
events.exp2 = [];
events.exp3 = [];
events.exp4 = [];
events.exp5 = [];


for i = 1:length(paths)
    for n = 1:5
        temp = [];
        evokeEXP = ['exp' num2str(n)];
        evokeEvents = ['eventsEXP' num2str(n)];
        if paths(i).(evokeEXP) == 1
            temp = paths(i).(evokeEvents);
            for m=1:length(temp)
                temp(m).id = paths(i).id;
            end
            events.(evokeEXP) = cat(2, events.(evokeEXP), temp);
        end
    end
            
end



        
for n = 1:5
        evokeEXP = ['exp' num2str(n)];
        temp_events = events.(evokeEXP);
        temp_events = rmfield(temp_events, 'latency');
        temp_events = rmfield(temp_events, 'urevent');
        temp_events = rmfield(temp_events, 'id');
        fnames = fields(temp_events);
        

        figure(Visible="on"); hold on;
        title(evokeEXP);
        t = tiledlayout(3, ceil(length(fnames)/3), 'TileSpacing','normal');
        for i = 1:length(fnames)
        to_plot = [temp_events.(fnames{i, 1})];
        nexttile;
        histogram([to_plot], "NumBins", length(unique([to_plot])));     
        title((fnames{i, 1}));
        
        end
        hold off;

end