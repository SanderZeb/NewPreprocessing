
for i=1:length(events)
   
    temp_events = events{i};
    temp_info = IMPORTANT(i);
    new_events = temp_events;
    
    for n=1:length(new_events)
       
        if strcmp(new_events(n).task_type, 'object')
            if temp_info.version == 1
                if new_events(n).identification == 41 & strcmp(new_events(n).object, 'animal')
                    new_events(n).corrected_id = 0;
                end
                if new_events(n).identification == 41 & strcmp(new_events(n).object, 'object')
                    new_events(n).corrected_id = 1;  
                end 
                if new_events(n).identification == 46 & strcmp(new_events(n).object, 'animal')
                    new_events(n).corrected_id = 1;
                end
                if new_events(n).identification == 46 & strcmp(new_events(n).object, 'object')
                    new_events(n).corrected_id = 0;  
                end
            end
            if temp_info.version == 2
                if new_events(n).identification == 41 & strcmp(new_events(n).object, 'animal')
                    new_events(n).corrected_id = 1;
                end
                if new_events(n).identification == 41 & strcmp(new_events(n).object, 'object')
                    new_events(n).corrected_id = 0;  
                end 
                if new_events(n).identification == 46 & strcmp(new_events(n).object, 'animal')
                    new_events(n).corrected_id = 0;
                end
                if new_events(n).identification == 46 & strcmp(new_events(n).object, 'object')
                    new_events(n).corrected_id = 1;  
                end
            end
        elseif strcmp(new_events(n).task_type, 'background')
                        if temp_info.version == 1
                if new_events(n).identification == 41 & strcmp(new_events(n).background, 'natural')
                    new_events(n).corrected_id = 0;
                end
                if new_events(n).identification == 41 & strcmp(new_events(n).background, 'artificial')
                    new_events(n).corrected_id = 1;  
                end 
                if new_events(n).identification == 46 & strcmp(new_events(n).background, 'natural')
                    new_events(n).corrected_id = 1;
                end
                if new_events(n).identification == 46 & strcmp(new_events(n).background, 'artificial')
                    new_events(n).corrected_id = 0;  
                end
            end
            if temp_info.version == 2
                if new_events(n).identification == 41 & strcmp(new_events(n).background, 'natural')
                    new_events(n).corrected_id = 1;
                end
                if new_events(n).identification == 41 & strcmp(new_events(n).background, 'artificial')
                    new_events(n).corrected_id = 0;  
                end 
                if new_events(n).identification == 46 & strcmp(new_events(n).background, 'natural')
                    new_events(n).corrected_id = 0;
                end
                if new_events(n).identification == 46 & strcmp(new_events(n).background, 'artificial')
                    new_events(n).corrected_id = 1;  
                end
            end
        end
        
        
        if isempty(new_events(n).task_type)
            idx(n) = 0;
        else
            idx(n) = 1;
        end
        
        
        new_events(n).version = temp_info.version
        new_events(n).task_order = temp_info.task_order
        new_events(n).participant = temp_info.participant
    end
   
    new_events_export{i} = new_events(logical(idx))
    
    clear idx new_events n temp_info temp_events
end







all_events = []
all_events_bgr = []
all_events_obj = []
for i=1:length(new_events_export)
    if i~=34
    clear temp idx
    temp = new_events_export{i}
    for n = 1:length(temp)
        if strcmp(temp(n).task_type, 'background') 
            
            temp(n).task_type_num = 1
        elseif strcmp(temp(n).task_type, 'object') 
            temp(n).task_type_num = 0
        end
    end
    %idx_bgr = ([temp.pas] == 4) & ([temp.duration] == 4) & [temp.task_type_num] == 1
    %idx_obj = ([temp.pas] == 4) & ([temp.duration] == 4) & [temp.task_type_num] == 0
    idx_bgr = [temp.task_type_num] == 1
    idx_obj = [temp.task_type_num] == 0
    
    all_events_bgr = cat(2, all_events_bgr, temp(idx_bgr))
    all_events_obj = cat(2, all_events_obj, temp(idx_obj))
    end
end

for i = 1:length(all_events_obj)
    idx_obj(i) = strcmp(all_events_obj(i).object, 'object');
    idx_anim(i) = strcmp(all_events_obj(i).object, 'animal');
end

debug_obj = all_events_obj(idx_obj);
debug_anim = all_events_obj(idx_anim);

debug_res.anim = sum([debug_anim.corrected_id])
debug_res.anim_all = length(debug_anim)
debug_res.obj = sum([debug_obj.corrected_id])
debug_res.obj_all = length(debug_obj)


for i = 1:length(all_events_bgr)
    idx_artif(i) = strcmp(all_events_bgr(i).background, 'artificial');
    idx_natural(i) = strcmp(all_events_bgr(i).background, 'natural');
end

debug_artif = all_events_bgr(idx_artif);
debug_natural = all_events_bgr(idx_natural);

debug_res.artif = sum([debug_artif.corrected_id])
debug_res.artif_all = length(debug_artif)
debug_res.natural = sum([debug_natural.corrected_id])
debug_res.natural_all = length(debug_natural)

debug_res.percentage_artif = (debug_res.artif / debug_res.artif_all ) *100
debug_res.percentage_natural = (debug_res.natural / debug_res.natural_all ) *100
debug_res.percentage_anim = (debug_res.anim / debug_res.anim_all ) *100
debug_res.percentage_obj = (debug_res.obj / debug_res.obj_all ) *100



events_2 = events;
events = evnew_events_export;















% ([x.identification] == 41) & strcmp([x.task_type], 'object') & strcmp([x.object], 'object')
% 
% sum(([x.identification] == 41) & ([x.task_type_1] == 1) & ([x.object_1]== 1))
% 
% 
% 
% 
% 
% sum(([x.identification] == 41) & ([x.task_type_1] == 0) & ([x.object_1]== 0))
% 
% idx = strfind([x.task_type], 'object');
% idx2 = strfind([x.object], 'object');
% 
% idx3 = intersect(idx, idx2)
% 
% sum(x(idx3).identification == 41)
% 
% 
% 
% 
% 
% 
% 
% clear participant_event participant_event2 idx idx2 idx3 empty* x to_include temp temp2 
% for participantID=1:length(events)
%  participant_event = events{participantID};
%  
%  
%     for i=1:length(participant_event)
%         if isempty(participant_event(i).task_type)
%          idx(i) = 0;
%         else
%         idx(i) = 1;
%         end
%     end
% 
%     
%     participant_event2 = participant_event(boolean(idx))
%    % to_include = [participant_event2.epoch];
%     
%    
%     
%     x = participant_event2;
%     x = rmfield(x, 'type');
%     x = rmfield(x, 'latency');
%     x = rmfield(x, 'urevent');
%     x = rmfield(x, 'epoch');
%     x = rmfield(x, 'stimulus');
% 
% for i =1 :length(x)
%     
%    if strcmp(x(i).background, 'artificial')
%                x(i).background_1 = 1;
%            elseif strcmp(x(i).background, 'natural' )
%                x(i).background_1 = 0;
%            end
%            
%            if strcmp(x(i).object,'object')
%                x(i).object_1 = 1;
%            elseif strcmp(x(i).object, 'animal' )
%                x(i).object_1 = 0;
%            end
%            
%            if strcmp(x(i).task_type,'object')
%                x(i).task_type_1 = 1;
%            elseif strcmp(x(i).task_type, 'background')
%                x(i).task_type_1 = 0;
%    end 
%     
% end
% 
% try
% % test(participantID).participant = participantID;
% % test(participantID).objectXobjectX41 = sum(([x.identification] == 41) & ([x.task_type_1] == 1) & ([x.object_1]== 1));
% % test(participantID).objectXobjectX46 =sum(([x.identification] == 46) & ([x.task_type_1] == 1) & ([x.object_1]== 1));
% % test(participantID).objectXanimalX41 = sum(([x.identification] == 41) & ([x.task_type_1] == 1) & ([x.object_1]== 0));
% % test(participantID).objectXanimalX46 = sum(([x.identification] == 46) & ([x.task_type_1] == 1) & ([x.object_1]== 0));
% % test(participantID).backgroundXobjectX41 = sum(([x.identification] == 41) & ([x.task_type_1] == 0) & ([x.background_1]== 1));
% % test(participantID).backgroundXobjectX46 =sum(([x.identification] == 46) & ([x.task_type_1] == 0) & ([x.background_1]== 1));
% % test(participantID).backgroundXanimalX41 = sum(([x.identification] == 41) & ([x.task_type_1] == 0) & ([x.background_1]== 0));
% % test(participantID).backgroundXanimalX46 = sum(([x.identification] == 46) & ([x.task_type_1] == 0) & ([x.background_1]== 0));
% 
% % test(participantID).participant = participantID;
% % test(participantID).objectXobjectX41 = sum(([x.corrected_id] == 1) & ([x.task_type_1] == 1) & ([x.object_1]== 1));
% % test(participantID).objectXobjectX46 =sum(([x.corrected_id] == 0) & ([x.task_type_1] == 1) & ([x.object_1]== 1));
% % test(participantID).objectXanimalX41 = sum(([x.corrected_id] == 1) & ([x.task_type_1] == 1) & ([x.object_1]== 0));
% % test(participantID).objectXanimalX46 = sum(([x.corrected_id] == 0) & ([x.task_type_1] == 1) & ([x.object_1]== 0));
% % test(participantID).backgroundXobjectX41 = sum(([x.corrected_id] == 1) & ([x.task_type_1] == 0) & ([x.background_1]== 1));
% % test(participantID).backgroundXobjectX46 =sum(([x.corrected_id] == 0) & ([x.task_type_1] == 0) & ([x.background_1]== 1));
% % test(participantID).backgroundXanimalX41 = sum(([x.corrected_id] == 1) & ([x.task_type_1] == 0) & ([x.background_1]== 0));
% % test(participantID).backgroundXanimalX46 = sum(([x.corrected_id] == 0) & ([x.task_type_1] == 0) & ([x.background_1]== 0));
% 
% 
% test(participantID).task_object_stim_artif_reaction_artif = sum(([x.corrected_id] == 1) & ([x.task_type_1] == 1) & ([x.object_1]== 1));
% test(participantID).task_object_stim_artif_reaction_41 = sum(([x.identification] == 41) & ([x.task_type_1] == 1) & ([x.object_1]== 1));
% test(participantID).task_object_stim_artif_reaction_46 = sum(([x.identification] == 46) & ([x.task_type_1] == 1) & ([x.object_1]== 1));
% 
% test(participantID).task_object_stim_nat_reaction_anim = sum(([x.corrected_id] == 1) & ([x.task_type_1] == 1) & ([x.object_1]== 0));
% test(participantID).task_object_stim_nat_reaction_41 = sum(([x.identification] == 41) & ([x.task_type_1] == 1) & ([x.object_1]== 0));
% test(participantID).task_object_stim_nat_reaction_46 = sum(([x.identification] == 46) & ([x.task_type_1] == 1) & ([x.object_1]== 0));
% 
% 
% test(participantID).task_bgr_stim_artif_reaction_artif = sum(([x.corrected_id] == 1) & ([x.task_type_1] == 0) & ([x.background_1]== 1));
% test(participantID).task_bgr_stim_artif_reaction_41 = sum(([x.identification] == 41) & ([x.task_type_1] == 0) & ([x.background_1]== 1));
% test(participantID).task_bgr_stim_artif_reaction_46 = sum(([x.identification] == 46) & ([x.task_type_1] == 0) & ([x.background_1]== 1));
% 
% 
% test(participantID).task_bgr_stim_nat_reaction_anim = sum(([x.corrected_id] == 1) & ([x.task_type_1] == 0) & ([x.background_1]== 0));
% test(participantID).task_bgr_stim_nat_reaction_41 = sum(([x.identification] == 41) & ([x.task_type_1] == 0) & ([x.background_1]== 0));
% test(participantID).task_bgr_stim_nat_reaction_46= sum(([x.identification] == 46) & ([x.task_type_1] == 0) & ([x.background_1]== 0));
% 
% test(participantID).version = x(1).version
% test(participantID).task_ord = x(1).task_order
% catch
% end
% clear participant_event participant_event2 idx idx2 idx3 empty* x to_include temp temp2 
% end
% 
% 
% 







