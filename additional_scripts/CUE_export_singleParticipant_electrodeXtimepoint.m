eeglab nogui
pathLoadData='D:\Drive\2 - Cue\MARA\';
list=dir([pathLoadData '\*.set'  ]);
mkdir(pathLoadData, '\export');
savePath = [pathLoadData, '\export\'];
participants = length(list);

% for n=1:3 %currElectrodes
% indS=1
for s=1:participants
    clear idx*
    %if (s ~= 0)%[4 6 16 26]) %participants to drop (optional, replace 0 with id
        
        file=list(s).name;
        EEG = pop_loadset('filename',file,'filepath',pathLoadData);
        
        for i=1:length(EEG.event)
        if EEG.event(i).type > 60 & EEG.event(i).type < 65 & i+1<= length(EEG.event) & ~isempty(EEG.event(i+1).cue)
            EEG.event(i).detection = EEG.event(i+1).detection;
            EEG.event(i).identification = EEG.event(i+1).identification;
            EEG.event(i).corr_corr = EEG.event(i+1).corr_corr;
            EEG.event(i).pas = EEG.event(i+1).pas;
            EEG.event(i).cue = EEG.event(i+1).cue;
            EEG.event(i).detection2 = EEG.event(i+1).detection2;
            EEG.event(i).identification2 =EEG.event(i+1).identification2;
            EEG.event(i).stimulus = EEG.event(i+1).type;
            idx(i) = 0;
        else
            idx(i) = 1;
        end
        end
    EEG.event(idx==1) = []
    
    
    EEG = pop_selectevent( EEG, 'type',[61:64] ,'deleteevents','on','deleteepochs','off','invertepochs','off');
    
        %EEG = pop_rmbase( EEG, [300    500]);
    EEG = pop_epoch( EEG, {  '61'  '62'  '63'  '64'  }, [-0.2  1.8]);
    EEG = pop_rmbase( EEG, [-199    00]);
    elec.CP1 = find(strcmp({EEG.chanlocs.labels}, 'CP1')==1)	;
    elec.CPz = find(strcmp({EEG.chanlocs.labels}, 'CPz')==1)	;
    elec.CP2 = find(strcmp({EEG.chanlocs.labels}, 'CP2')==1)	;
    elec.CP3 = find(strcmp({EEG.chanlocs.labels}, 'CP3')==1)	;
    elec.CP4 = find(strcmp({EEG.chanlocs.labels}, 'CP4')==1)	;
    elec.P1 = find(strcmp({EEG.chanlocs.labels}, 'P1')==1)	;
    elec.P2 = find(strcmp({EEG.chanlocs.labels}, 'P2')==1)	;
    elec.P3 = find(strcmp({EEG.chanlocs.labels}, 'P3')==1)	;
    elec.P4 = find(strcmp({EEG.chanlocs.labels}, 'P4')==1)	;
    elec.Pz = find(strcmp({EEG.chanlocs.labels}, 'Pz')==1)	;
    elec.O1 = find(strcmp({EEG.chanlocs.labels}, 'O1')==1)	;
    elec.Oz = find(strcmp({EEG.chanlocs.labels}, 'Oz')==1)	;
    elec.O2 = find(strcmp({EEG.chanlocs.labels}, 'O2')==1)   ;
    elec.PO7 = find(strcmp({EEG.chanlocs.labels}, 'PO7')==1)	;
    elec.PO8 = find(strcmp({EEG.chanlocs.labels}, 'PO8')==1) ;
    elec.PO3 = find(strcmp({EEG.chanlocs.labels}, 'PO3')==1) ;
    elec.PO4 = find(strcmp({EEG.chanlocs.labels}, 'PO4')==1) ;
    
    
    currElectrode = [elec.P3 elec.P1 elec.Pz elec.P2 elec.P4 elec.CP3 elec.CP1 elec.CPz elec.CP2 elec.CP4 elec.O1 elec.Oz elec.O2 elec.PO7 elec.PO8];
    
    
    to_export_data = EEG.data(currElectrode, :, :);
    to_export_data2 = reshape(to_export_data,[],size(to_export_data,3),1); % elec * timepoint X event 
    participant(1:length(EEG.event)) = str2num(file(1:5));
    to_export_events = cat(1, participant, squeeze(cell2mat(struct2cell( EEG.event))))';
    to_export_merge = cat(1, to_export_events', to_export_data2)';
    
    
    
    for i=1:length(currElectrode)
        for ii =1:length(EEG.times)
            titles(i, ii) = string(EEG.chanlocs(currElectrode(i)).labels) + " " + string( int64(EEG.times(ii)));
        end
    end
    titles_data = reshape(titles,[],1);
    titles_events = ["participant", "trigger_type", "latency", "urevent", "detection response", "identification response", "pas response", "both correct", "cue2", "detection correctness", "identification correctness", "epoch id","stimulus"];
    titles_to_export = cat(1, titles_events', titles_data)';
    
    
    
    
    final_export = cat(1, titles_to_export, to_export_merge);
    writematrix(final_export,[savePath (file(1:5)) '.csv']) ;
    clear to_export_data to_export_data2 to_export_events to_export_merge participant final_export titles_to_export
     
end