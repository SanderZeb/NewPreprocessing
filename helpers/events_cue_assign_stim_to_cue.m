function EEG = events_cue_assign_stim_to_cue(EEG)
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
% EEG.event(idx==1) = []
% k=1;
% for i = 1:length(EEG.event)
%     
%     %if i<length(EEG.event) & EEG.event(i).epoch == EEG.event(i+1).epoch
%     %    to_reject(k) = i;
%     %    k=k+1;
%     %end
%     if i>1 & EEG.event(i).epoch == EEG.event(i-1).epoch
%         to_reject(k) = i;
%         k=k+1;
%     end
% end
% if k>1
%     EEG.event(to_reject) = []
%     clear to_reject k i
% end
% clear idx
EEG = pop_selectevent( EEG, 'type',[61 62 63 64] ,'deleteevents','on','deleteepochs','on','invertepochs','off');
end