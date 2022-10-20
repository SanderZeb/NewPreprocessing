addpath 'C:\Users\user\Desktop\eeglab-eeglab2021.0'
addpath 'C:\Program Files\MATLAB\R2019b\toolbox\stats\stats'
cd('C:\Program Files\MATLAB\R2019b\toolbox\stats\stats')
eeglab nogui
root = 'D:\Drive\5 - Scenes\';
pathLoadData= [root '\MARA\'];
list=dir([pathLoadData '*.set'  ]);
mkdir(root, 'pwelch');
parthSaveData = [root '\pwelch\'];

for s=[31:length(list)]

    file=list(s).name;
    EEG = pop_loadset('filename',file,'filepath',pathLoadData);

        clear tfdata
        tic
        for(i=1:64)
			for(n=1:size(EEG.data, 3))
                addpath('C:\Program Files\MATLAB\R2019b\toolbox\signal\signal');
					[psds, freqs] = pwelch(EEG.data(i,:,n), 500, [], [], EEG.srate);
                    
                    % Transpose, to make inputs row vectors
                    %freqs = freqs';
                    psds = psds';
                    
					data_psds(i, n, :) = psds;
					%data_freqs(i, n, :) = freqs;

					clear freqs psds
			end
		end
		toc
                       save([  parthSaveData '/pwelch_participant_' num2str(s)], 'data_psds', '-v7.3')  ;
			
            close all

        
        display(['processing: ' num2str(s) ' out of ' num2str(length(list))]);
      
end