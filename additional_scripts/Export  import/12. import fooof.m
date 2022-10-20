root = 'C:\Users\user\Desktop\Nowy folder\participants';

temp = dir;
dirs = length(temp)-2;
for i =1:(dirs)

        pathLoadData= [root '\\' num2str(i) '\\'];
        list=dir([pathLoadData '*.mat'  ]);

        
        for n = 1:length(list)
            file = list(n).name;
            B = regexp(file,'\d*','Match')
            
            
            data(i, n) = load([pathLoadData list(n).name]);
            data(i,n).participant = B{1,1}
            data(i,n).channel = B{1,2}
            data(i,n).trial = B{1,3}
        end
        
end
for n = 1:length(list)
            file = list(n).name;
            B = regexp(file,'\d*','Match')
            
            
            data(n) = load([pathLoadData list(n).name]);
            data(n).participant = B{1,1}
            data(n).channel = B{1,2}
            data(n).trial = B{1,3}
end


participants = unique([data.participant]);

for i = 1:length(participants)
    if (sum([data.participant] == participants(i) & [data.channel] == 1)) == length(events{participants(i)})
    
        participant_events = events{participants(i)};
        
    end
end

highpas_indexes = [participant_events.pas] >=3;
lowpas_indexes = [participant_events.pas] < 3;

idx = 1:364

idx2 = idx(highpas_indexes)
idx2_2 = idx(lowpas_indexes)
data2 = data([data.participant] == 1 & [data.channel] == 60)

data3 = data(any(find([data2.trial], idx2)))

for i=1:length(data2)
    
test1(i) = data2(i).aperiodic_params(1,1);
test2(i) = data2(i).aperiodic_params(1,2);
end

scatter(test1, test2, [], [participant_events.pas])






