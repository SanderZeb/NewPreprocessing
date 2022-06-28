close all
clear all

addpath('C:\Users\user\Desktop\eeglab2022.0')
addpath('C:\Program Files\MATLAB\R2019b\toolbox\signal\signal\')
addpath('C:\Program Files\MATLAB\R2019b\toolbox\stats\stats\')
root='D:\Drive\3 - Mask\';
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
