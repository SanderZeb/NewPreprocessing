load('D:\export\exp4_behawior_alpha.mat');
load('D:\export\exp1_behawior_alpha.mat');
load('D:\export\exp5_behawior_alpha.mat');
load('D:\export\exp3_behawior_alpha.mat');
load('D:\chanlocs.mat');



for i = 1:4
    if i == 1
        settings.paradigm = 1;
        savepath = 'D:\export\exp1_bootstraps\'

        tbl = exp1;
        participants = unique([tbl.ID_data]);
        for m = 1:size(tbl,1)
            tbl.participant(m) = find(strcmp(participants, tbl.ID_data(m)));
        end
    elseif i == 2
        tbl = exp3;
        participants = unique([tbl.ID_data]);
        for m = 1:size(tbl,1)
            tbl.participant(m) = find(strcmp(participants, tbl.ID_data(m)));
        end
        settings.paradigm = 3;
        savepath = 'D:\export\exp3_bootstraps\'
    elseif i == 3
        tbl = exp4;
        participants = unique([tbl.ID_data]);
        for m = 1:size(tbl,1)
            tbl.participant(m) = find(strcmp(participants, tbl.ID_data(m)));
        end
        settings.paradigm = 4;
        savepath = 'D:\export\exp4_bootstraps\'
    elseif i == 4
        tbl = exp5;
        participants = unique([tbl.ID_data]);
%         for m = 1:size(tbl,1)
%             tbl.participant(m) = find(strcmp(participants, tbl.ID_data(m)));
%         end
        settings.paradigm = 5;
        savepath = 'D:\export\exp5_bootstraps\'
    end

    settings.bootstraps = 1000; % number of bootstraps
    settings.participants_in_batch = 0;
    settings.participants = unique([tbl.ID_data]);
    settings.threshold_lme = 0.05;

    settings.formula1 = 'accuracy~alpha_dB+(1+alpha_dB|participant)';        %Identification ~ alpha + (1 + alpha | ID)
    settings.formula2 = 'PAS~alpha_dB+(1+alpha_dB|participant)';				%PAS ~ alpha + (1 + alpha | ID)


    channels(1).M1 = find(strcmp({chanlocs.labels}, 'M1')==1);  			%INDEX CHANNEL
    channels.M2 = find(strcmp({chanlocs.labels}, 'M2')==1);              	%INDEX CHANNEL
    channels.CP1 = find(strcmp({chanlocs.labels}, 'CP1')==1);
    channels.CPz = find(strcmp({chanlocs.labels}, 'CPz')==1);
    channels.CP2 = find(strcmp({chanlocs.labels}, 'CP2')==1);
    channels.P1 = find(strcmp({chanlocs.labels}, 'P1')==1);
    channels.Pz = find(strcmp({chanlocs.labels}, 'Pz')==1);
    channels.P2 = find(strcmp({chanlocs.labels}, 'P2')==1);
    channels.O1 = find(strcmp({chanlocs.labels}, 'O1')==1);
    channels.Oz = find(strcmp({chanlocs.labels}, 'Oz')==1);
    channels.O2 = find(strcmp({chanlocs.labels}, 'O2')==1);
    channels.PO7 = find(strcmp({chanlocs.labels}, 'PO7')==1);
    channels.PO8 = find(strcmp({chanlocs.labels}, 'PO8')==1);
    channels.PO3 = find(strcmp({chanlocs.labels}, 'PO3')==1);
    channels.PO4 = find(strcmp({chanlocs.labels}, 'PO4')==1);
    channels.POz = find(strcmp({chanlocs.labels}, 'POz')==1);
    channels.Iz = find(strcmp({chanlocs.labels}, 'Iz')==1);
    channels.VEOG = find(strcmp({chanlocs.labels}, 'VEOG')==1);									%INDEX CHANNEL
    channels.HEOG = find(strcmp({chanlocs.labels}, 'HEOG')==1);									%INDEX CHANNEL


    settings.selected_channels = [channels.O1 channels.Oz channels.O2 channels.PO7 channels.PO8 channels.PO3 channels.PO4 channels.POz channels.Iz channels.P1 channels.Pz channels.P2];

    backup = []
    pval = []
    % tbl.identification2 = double(tbl.identification2)
    %
    %
    %
    % emptypas = cellfun(@isempty,tbl.pas);
    % idx_empty_pas = find(emptypas);
    % for i=1:length(idx_empty_pas)
    %     display('found empty pas entry');
    %    tbl.pas{idx_empty_pas(i)} = 1 ; % couple of records is broken..?
    % end
    %
    % pas = double([tbl.pas{:, 1}]);
    % tbl.pas = pas.';



    if settings.paradigm ~= 5
    for n=1:10
        settings.participants_in_batch = settings.participants_in_batch+10;
        for s=1:settings.bootstraps
            selected_participants = randi(length(settings.participants),settings.participants_in_batch,1); % generate random list of participants
            tbl_idx = tbl.participant == [selected_participants.'];
            tbl_idx2 = any(tbl_idx, 2);
            newtable = tbl(tbl_idx2, :);

            addpath 'C:\Program Files\MATLAB\R2022b\toolbox\stats\stats'
            lme1 = fitlm(newtable.accuracy, newtable.alpha_dB);
            lme2 = fitlm(newtable.PAS, newtable.alpha_dB);
            lme3 = fitlme(newtable, settings.formula1);
            lme4 = fitlme(newtable, settings.formula2);
            %lme3 = fitlme(newtable, settings.formula3);
            %lme4 = fitlme(newtable, settings.formula4);


            data(s).number_of_participants = settings.participants_in_batch;
            data(s).selected_channels = settings.selected_channels;
            data(s).trials = sum(tbl_idx2);
            data(s).bootstraps = settings.bootstraps;
            data(s).participants_list = selected_participants;

            p_value_formula1_identification(n,s) =  lme1.Coefficients.pValue(2);
            p_value_formula2_pas(n,s) =  lme2.Coefficients.pValue(2)		;
            p_value_formula1_identification_lme(n,s) =  lme3.Coefficients.pValue(2);
            p_value_formula2_pas_lme(n,s) =  lme4.Coefficients.pValue(2)			;
            display([' Currently we are in ' num2str(s) ' out of ' num2str(settings.bootstraps) ' from ' num2str(settings.participants_in_batch) ' participants']);
            clear selected_participants lme1 lme2 lme3 lme4 temp_tbl
        end

    end
        significant_vals.identification_lme = [p_value_formula1_identification_lme] < settings.threshold_lme;
        significant_vals.identification = [p_value_formula1_identification] <0.05
        significant_vals.pas_lme = [p_value_formula2_pas_lme] <settings.threshold_lme;
        significant_vals.pas = [p_value_formula2_pas] <0.05

        significant_vals.identification_lme_sum = sum(significant_vals.identification_lme.')
        significant_vals.identification_sum = sum(significant_vals.identification.')
        significant_vals.pas_lme_sum = sum(significant_vals.pas_lme.')
        significant_vals.pas_sum = sum(significant_vals.pas.')

             if i == 1
                 save([savepath '\exp1_significant_vals.mat'],'significant_vals')
            elseif i == 2
                 save([savepath '\exp3_significant_vals.mat'],'significant_vals')
            elseif i == 3
                 save([savepath '\exp4_significant_vals.mat'],'significant_vals')
            end
        

    end

    if settings.paradigm == 5

        for i =1:size(exp5, 1)
            idx(i) = strcmp('object', exp5(i,:).task_type);
        end
        all_object = exp5(idx,:)
        all_background = exp5(~idx, :)


        % object
        %tbl = struct2table(all_object)
        tbl = all_object;
        for n=1:10
            settings.participants_in_batch = settings.participants_in_batch+10;
            for s=1:settings.bootstraps
                selected_participants = randi(length(settings.participants),settings.participants_in_batch,1); % generate random list of participants
                tbl_idx = tbl.participant == [selected_participants.'];
                tbl_idx2 = any(tbl_idx, 2);
                newtable = tbl(tbl_idx2, :);

                addpath 'C:\Program Files\MATLAB\R2022b\toolbox\stats\stats'
                lme1 = fitlm(newtable.accuracy, newtable.alpha_dB);
                lme2 = fitlm(newtable.PAS, newtable.alpha_dB);
                lme3 = fitlme(newtable, settings.formula1);
                lme4 = fitlme(newtable, settings.formula2);
                %lme3 = fitlme(newtable, settings.formula3);
                %lme4 = fitlme(newtable, settings.formula4);


                data(s).number_of_participants = settings.participants_in_batch;
                data(s).selected_channels = settings.selected_channels;
                data(s).trials = sum(tbl_idx2);
                data(s).bootstraps = settings.bootstraps;
                data(s).participants_list = selected_participants;
                %     data(s).result_formula1 = lme1;
                %     data(s).result_formula2 = lme2;
                %     data(s).result_formula1_lme = lme3;
                %     data(s).result_formula2_lme = lme4;cellfuc

                p_value_formula1_identification(n,s) =  lme1.Coefficients.pValue(2);
                p_value_formula2_pas(n,s) =  lme2.Coefficients.pValue(2)		;
                p_value_formula1_identification_lme(n,s) =  lme3.Coefficients.pValue(2);
                p_value_formula2_pas_lme(n,s) =  lme4.Coefficients.pValue(2)			;
                display([' Currently we are in ' num2str(s) ' out of ' num2str(settings.bootstraps) ' from ' num2str(settings.participants_in_batch) ' participants']);
                clear selected_participants lme1 lme2 lme3 lme4 temp_tbl
            end

        end

        significant_vals.identification_lme = [p_value_formula1_identification_lme] < settings.threshold_lme;
        significant_vals.identification = [p_value_formula1_identification] <0.05
        significant_vals.pas_lme = [p_value_formula2_pas_lme] <settings.threshold_lme;
        significant_vals.pas = [p_value_formula2_pas] <0.05

        significant_vals.identification_lme_sum = sum(significant_vals.identification_lme.')
        significant_vals.identification_sum = sum(significant_vals.identification.')
        significant_vals.pas_lme_sum = sum(significant_vals.pas_lme.')
        significant_vals.pas_sum = sum(significant_vals.pas.')

         
        save([savepath '\significant vals - bootstraping_object.mat'],'significant_vals')


        clear tbl significant_vals
        % background
        settings.participants_in_batch = 0;
        settings.participants = unique([exp5.participant]);

        %tbl = struct2table(all_background)
        tbl = all_background;
        for n=1:10
            settings.participants_in_batch = settings.participants_in_batch+10;
            for s=1:settings.bootstraps
                selected_participants = randi(length(settings.participants),settings.participants_in_batch,1); % generate random list of participants
                tbl_idx = tbl.participant == [selected_participants.'];
                tbl_idx2 = any(tbl_idx, 2);
                newtable = tbl(tbl_idx2, :);

                addpath 'C:\Program Files\MATLAB\R2022b\toolbox\stats\stats'
                lme1 = fitlm(newtable.accuracy, newtable.alpha_dB);
                lme2 = fitlm(newtable.PAS, newtable.alpha_dB);
                lme3 = fitlme(newtable, settings.formula1);
                lme4 = fitlme(newtable, settings.formula2);
                %lme3 = fitlme(newtable, settings.formula3);
                %lme4 = fitlme(newtable, settings.formula4);


                data(s).number_of_participants = settings.participants_in_batch;
                data(s).selected_channels = settings.selected_channels;
                data(s).trials = sum(tbl_idx2);
                data(s).bootstraps = settings.bootstraps;
                data(s).participants_list = selected_participants;
                data(s).result_formula1 = lme1;
                data(s).result_formula2 = lme2;
                data(s).result_formula1_lme = lme3;
                data(s).result_formula2_lme = lme4;

                p_value_formula1_identification(n,s) =  lme1.Coefficients.pValue(2);
                p_value_formula2_pas(n,s) =  lme2.Coefficients.pValue(2)		;
                p_value_formula1_identification_lme(n,s) =  lme3.Coefficients.pValue(2);
                p_value_formula2_pas_lme(n,s) =  lme4.Coefficients.pValue(2)			;
                display([' Currently we are in ' num2str(s) ' out of ' num2str(settings.bootstraps) ' from ' num2str(settings.participants_in_batch) ' participants']);
                clear selected_participants lme1 lme2 lme3 lme4 temp_tbl
            end

        end

        significant_vals.identification_lme = [p_value_formula1_identification_lme] <settings.threshold_lme;
        significant_vals.identification = [p_value_formula1_identification] <0.05
        significant_vals.pas_lme = [p_value_formula2_pas_lme] <settings.threshold_lme;
        significant_vals.pas = [p_value_formula2_pas] <0.05

        significant_vals.identification_lme_sum = sum(significant_vals.identification_lme.')
        significant_vals.identification_sum = sum(significant_vals.identification.')
        significant_vals.pas_lme_sum = sum(significant_vals.pas_lme.')
        significant_vals.pas_sum = sum(significant_vals.pas.')
        save([savepath '\significant vals - bootstraping_background.mat'],'significant_vals')
        clear tbl significant_vals

    end


end
%
%
%
%
% histo.toplot = p_value_formula2_pas_lme
% histo.nbins = 20
% [histo.h1, histo.edges] = histcounts(histo.toplot(1,:), histo.nbins);
% [histo.h2]              = histcounts(histo.toplot(2,:), histo.nbins);
% [histo.h3]              = histcounts(histo.toplot(3,:), histo.nbins);
% [histo.h4]              = histcounts(histo.toplot(4,:), histo.nbins);
% [histo.h5]              = histcounts(histo.toplot(5,:), histo.nbins);
% [histo.h6]              = histcounts(histo.toplot(6,:), histo.nbins);
% [histo.h7]              = histcounts(histo.toplot(7,:), histo.nbins);
% [histo.h8]              = histcounts(histo.toplot(8,:), histo.nbins);
% [histo.h9]              = histcounts(histo.toplot(9,:), histo.nbins);
% [histo.h10]              = histcounts(histo.toplot(10,:), histo.nbins);
% bar(histo.edges(1:end-1),[histo.h1; histo.h2; histo.h3; histo.h4; histo.h5; histo.h6; histo.h7; histo.h8; histo.h9; histo.h10]')
%
%
% % Put up legend.
% histo.legend1 = 'n=10';
% histo.legend2 = 'n=20';
% histo.legend3 = 'n=30';
% histo.legend4 = 'n=40';
% histo.legend5 = 'n=50';
% histo.legend6 = 'n=60';
% histo.legend7 = 'n=70';
% histo.legend8 = 'n=80';
% histo.legend9 = 'n=90';
% histo.legend10 = 'n=100';
% legend({histo.legend1, histo.legend2, histo.legend3, histo.legend4, histo.legend5, histo.legend6, histo.legend7, histo.legend8, histo.legend9, histo.legend10});
%

for i=1:length(data)

    temp(i) = data(i).result_formula2_lme.Coefficients.pValue(2)

end


%%

significant_vals.identification_lme = [p_value_formula1_identification_lme] <settings.threshold_lme;
significant_vals.identification = [p_value_formula1_identification] <0.05
significant_vals.pas_lme = [p_value_formula2_pas_lme] <settings.threshold_lme;
significant_vals.pas = [p_value_formula2_pas] <0.05

significant_vals.identification_lme_sum = sum(significant_vals.identification_lme.')
significant_vals.identification_sum = sum(significant_vals.identification.')
significant_vals.pas_lme_sum = sum(significant_vals.pas_lme.')
significant_vals.pas_sum = sum(significant_vals.pas.')


save([savepath '\significant vals - bootstraping.mat'],'significant_vals')


participants_in_batch = [10 20 30 40 50 60 70 80 90 100]
figure;
plot(participants_in_batch, significant_vals.identification_lme_sum)
ylim([0 1000])
title('identification task, significance level < 0.05')
figure;
plot(participants_in_batch, significant_vals.pas_lme_sum)
ylim([0 1000])
title('PAS task, significance level < 0.05')



