
load('D:\Drive\5 - Scenes\tfdata\corrected_exp5_scenes_alpha.mat')
load('D:\Drive\5 - Scenes\behawior.mat')

alpha = struct2table(new_alpha)
listEEGData = dir(['D:\Drive\5 - Scenes\MARA\*.set']);
%listEEGData(34) = []; % bad one;
listRemovedEpochs = dir(['D:\Drive\5 - Scenes\Epoching_EpochRejection\additional_info\*.mat']);
listRemovedEpochs([34 40 42]) = []; % bad one;
participants = unique(alpha.participant);
participants([34 40 42]) = [];
behawior.ID(28201:28800, :) = 56533; % replacing NaN values for ID


mix = [];
mix_all = [];
for i = 1 : length(participants)
    %if i ~= 41
    %if i ~= 40 % because we dropped part. 34
    current_participant = participants(i);
    current_participant_ID = str2num(listEEGData(current_participant).name(1:5));
    if current_participant_ID == 32381
        current_participant_ID = 32281;
    elseif current_participant_ID == 51127
        current_participant_ID = 51927;
    end
    current_alpha = alpha(alpha.participant == current_participant, :);
    
    current_alpha.Properties.VariableNames(2) = "object_alpha";
    current_alpha.Properties.VariableNames(3) = "task_type_alpha";
    current_alpha.Properties.VariableNames(4) = "duration_alpha";
    current_alpha.Properties.VariableNames(5) = "background_alpha";
    current_alpha.Properties.VariableNames(6) = "congruency_alpha";
    current_alpha.Properties.VariableNames(7) = "pas_alpha";
    current_alpha.Properties.VariableNames(9) = "version_alpha";
    current_alpha.Properties.VariableNames(10) = "task_order_alpha";
    current_behawior = behawior(behawior.ID == current_participant_ID, :);
    current_removed_epochs = load([listRemovedEpochs(i).folder '\' listRemovedEpochs(i).name]);

    backupbeh = current_behawior;


    %%
    clear idx t1 test curr_alpha curr_behawior
    current_behawior = behawior(behawior.ID == current_participant_ID, :);
    for n = 1:size(current_behawior, 1)
        current_behawior.trial(n) = current_behawior.thisTrialN(n)+1;
        if n >= 301
        current_behawior.trial(n) = current_behawior.thisTrialN(n)+301;
        end
    end



      index_behawior = 1;
      s = 1;
      for index_behawior = 1:size(current_behawior, 1)

        if current_alpha.type(s) == current_behawior.trigger(index_behawior) & current_alpha.pas_alpha(s) == current_behawior.pas(index_behawior) 
            idx(index_behawior) = 0;
            if s < size(current_alpha, 1)
                s=s+1;
            end
        else
            idx(index_behawior) = 1;
           
        end
        
      end


      if length(idx) < size(current_behawior,1)
          diff = size(current_behawior,1) - length(idx);
          for i = 1:diff
              diff = diff-1;
              idx(length(idx)+i) = 1;
          end
      end
    curr_behaw = current_behawior([idx]==0, :);
    curr_alpha = current_alpha;
% 
% 
% 
% 
% 
% 
% 
% 
% 
%         [current_alpha, current_behawior] = search_for_extradropouts(curr_alpha, current_behawior);
%     current_behawior_mess = current_behawior; 
%     s=1;
%     idx_clean_alpha = zeros(size(current_alpha, 1), 1);
%     idx_clean_behaw = zeros(size(current_behawior, 1), 1);
%     index_beh = 1;
%         display(['participant ' num2str(current_participant_ID)]);
%         display(['alpha epochs: ' num2str(size(current_alpha,1))]);
%     for index_alpha = 1:size(current_alpha, 1)
%         s=1;
%         display(['current alpha index: ' num2str(index_alpha)]);
%         while s ~= size(current_behawior, 1)
%             if current_behawior.trigger(s) == current_alpha.type(index_alpha)
%                 if current_behawior.pas(s) == current_alpha.pas_alpha(index_alpha)
%                     idx_clean_behaw(index_beh) = 1;
%                     idx_clean_alpha(index_alpha) = 1;
%                     index_beh = index_beh + 1;
%                     current_behawior(s,:) = [];
%                     display(['matching beh id: ' num2str(s)]);
%                     display(['matching beh trial: ' num2str(current_behawior.trial(s))]);
%                     display(['matching alpha trial: ' num2str(current_alpha.epoch(index_alpha))]);
%                     display(['matching alpha type: ' num2str(current_alpha.type(index_alpha))]);
%                     display(['matching beh trigger: ' num2str(current_behawior.trigger(s))]);
%                     display(['matching alpha pas: ' num2str(current_alpha.pas_alpha(index_alpha))]);
%                     display(['matching beh pas: ' num2str(current_behawior.pas(s))]);
%                     display(['====================================================']);
%                     
%                     break
% %                 else
% %                     display('trigger sie zgadza, ale pas nie');
%                 end
%             end
%                     current_behawior(s,:) = [];
% 
%             s=s+1;
%         end
%     end
%     curr_alpha = current_alpha(logical(idx_clean_alpha), :);
%     curr_behaw = current_behawior_mess(logical(idx_clean_behaw), :);
% 

% 
%     while s ~= size(current_behawior, 1)
%         %disp([num2str(s) ' ' num2str(index_alpha)]);
%         if current_behawior.trigger(s) == current_alpha.type(index_alpha)
%             if current_behawior.pas(s) == current_alpha.pas_alpha(index_alpha)
%                 idx_clean_behaw(s) = 1;
%                 idx_clean_alpha(index_alpha) = 1;
%                 if index_alpha<size(current_alpha,1)
%                     index_alpha=index_alpha+1;
%                 else
%                     break
%                 end
%             else
%                 display('trigger sie zgadza, ale pas nie');
%             end
%         end
%         s=s+1;
%     end
%     curr_alpha = current_alpha(logical(idx_clean_alpha), :);
%     curr_behaw = current_behawior(logical(idx_clean_behaw), :);
%     test3 = test1.trial - test2.trigger;
%     test4 = test1.pas_alpha - test2.pas;
%     test5 = test1.id2 - test2.corrected_id;

    
% 
%     for n = 1:size(current_behawior, 1)
%         if n < 301
%             current_behawior.trial(n) = current_behawior.trial(n);
%         else
%             if current_behawior.trigger(n) == current_alpha.type(n) & current_behawior.pas(n) == current_alpha.pas_alpha(n)
%                 current_behawior.trial(n) = current_behawior.trial(n)+300;
%             elseif current_behawior.trigger(n) == current_alpha.type(n-1) & current_behawior.pas(n) == current_alpha.pas_alpha(n-1)
%                 current_behawior.trial(n) = current_behawior.trial(n)+301;
%             elseif current_behawior.trigger(n) == current_alpha.type(n+1) & current_behawior.pas(n) == current_alpha.pas_alpha(n+1)
%                 current_behawior.trial(n) = current_behawior.trial(n)+299;
%             end
%         end
%     end
% 
%     for n=1:size(current_alpha,1)
%         idx(n) = find([current_behawior.trial] == current_alpha.trials_old(n));
%     end
%     test = current_behawior(idx,:);
% 
%     t1(:, 1) = test.trial;
%     t1(:,2) = test.trigger;
%     t1(:,3) = current_alpha.type;
%     t1(:,4) = current_alpha.epoch;
% 


    %% 
    %current_behawior(current_removed_epochs.to_reject, :) =[];
    
    if size(curr_alpha, 1) == size(curr_behaw,1)

        disp('OK');

        mix = cat(2, curr_alpha, curr_behaw);
        mix_all = cat(1, mix_all, mix);
%     else
%         disp('error');
%         disp(['diff: ' num2str(size(curr_alpha, 1) - size(curr_behaw,1)) ]);
%         [curr_alpha, curr_behaw] = search_for_extradropouts(curr_alpha, curr_behaw);
%         mix = cat(2, curr_alpha, curr_behaw);
%         mix_all = cat(1, mix_all, mix);
    end
%end
end


unique(mix_all.type- mix_all.trigger)
 unique(mix_all.pas_alpha- mix_all.pas)


        save(['D:\Drive\5 - Scenes\behawior_alpha.mat'],'mix_all');
        writetable(mix_all, ['D:\Drive\5 - Scenes\behawior_alpha.csv']);