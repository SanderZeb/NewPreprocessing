function runICA(settings.paradigm, root)
% close all
% clear all
% settings.paradigm = 6; % 1 - threshold; 2 - cue; 3 - mask; 4 - faces; 5 - scenes; 6 - Kinga
% 
% 
% addpath('C:\Users\user\Desktop\eeglab2022.0')
% addpath('C:\Program Files\MATLAB\R2019b\toolbox\signal\signal\')
% addpath('C:\Program Files\MATLAB\R2019b\toolbox\stats\stats\')
% 
% 
% 
% if settings.paradigm == 1
%     root = 'D:\Drive\1 - Threshold\';
% elseif settings.paradigm == 2
%     root = 'D:\Drive\2 - Cue\';
% elseif settings.paradigm == 3
%     root = 'D:\Drive\3 - Mask\';
% elseif settings.paradigm == 4
%     root = 'D:\Drive\4 - Faces\';
% elseif settings.paradigm == 5
%     root = 'D:\Drive\5 - Scenes\';
% elseif settings.paradigm == 6
%     root='D:\Drive\6 - Kinga\';
% end

pathLoadData = [root '\Epoching_EpochRejection\']
mkdir([root, '\ICA_newpipeline'])
pathSaveData=[root '\ICA_newpipeline\'];
mkdir([pathSaveData, '\additional_info'])
eeglab nogui
list=dir([pathLoadData '\*.set'  ])
participants = length(list)


for s=[1:participants]
    try
        
        file=list(s).name;
        EEG = pop_loadset('filename',file,'filepath',pathLoadData);
       
        EEG = pop_reref( EEG, []);
        EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1, 'pca', 50, 'interrupt','on');
  
        
        EEG = pop_saveset( EEG, 'filename', file ,'filepath', pathSaveData);
      
             
        
        fileID = fopen([root '\log.txt'],'a');
        fprintf(fileID, 'success in ICA\n\n');
        fprintf(fileID,'%s %s \n',list(s).name, '\n');
        fclose(fileID);
    catch
        warning('Something went wrong.');
        fileID = fopen([root '\log.txt'],'a');
        fprintf(fileID, 'Error in pipeline\n');
        fprintf(fileID,'%s %s \n',list(s).name, '\n');
        fclose(fileID);
    end
end
end