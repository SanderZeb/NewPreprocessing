clear all
% 
% results_exp1 = readtable('D:\Drive\1 - Threshold\pwelch\pwelch_result\csv_export\results.csv')
% results_exp3 = readtable('D:\Drive\3 - Mask\pwelch\pwelch_result\csv_export\results.csv')
% 
% settings.plot_4th = 1;
% if settings.plot_4th == 1
%     results_exp4 = readtable('D:\Drive\4 - Faces\pwelch\pwelch_result\csv_export\results.csv')
%     results_exp5_obj = readtable('D:\Drive\5 - Scenes\pwelch\pwelch_result\obj\csv_export\results.csv')
%     results_exp5_bgr = readtable('D:\Drive\5 - Scenes\pwelch\pwelch_result\bgr\csv_export\results.csv')
% end

results_exp1 = readtable('D:\Drive\1 - Threshold\\pwelch_adjusted_timewindow\pwelch_result\csv_export\results.csv')
results_exp3 = readtable('D:\Drive\3 - Mask\pwelch_adjusted_timewindow\\pwelch_result\csv_export\results.csv')

settings.plot_4th = 1;
if settings.plot_4th == 1
    results_exp4 = readtable('D:\Drive\4 - Faces\\pwelch_adjusted_timewindow\pwelch_result\csv_export\results.csv')
    results_exp5_obj = readtable('D:\Drive\5 - Scenes\\pwelch_adjusted_timewindow\pwelch_result\obj\csv_export\results.csv')
    results_exp5_bgr = readtable('D:\Drive\5 - Scenes\\pwelch_adjusted_timewindow\pwelch_result\bgr\csv_export\results.csv')
end


addpath('C:\Users\user\Documents\GitHub\NewPreprocessing\helpers')



for i = 1:size(results_exp1, 1)
    for n = 1:size(results_exp1, 2)
       if results_exp1{i, n} == 0
            results_exp1{i, n} = NaN;
       end
    end
end
for i = 1:size(results_exp3, 1)
    for n = 1:size(results_exp3, 2)
       if results_exp3{i, n} == 0
            results_exp3{i, n} = NaN;
       end
    end
end
for i = 1:size(results_exp4, 1)
    for n = 1:size(results_exp4, 2)
       if results_exp4{i, n} == 0
            results_exp4{i, n} = NaN;
       end
    end
end
for i = 1:size(results_exp5_obj, 1)
    for n = 1:size(results_exp5_obj, 2)
       if results_exp5_obj{i, n} == 0
            results_exp5_obj{i, n} = NaN;
       end
    end
end
for i = 1:size(results_exp5_bgr, 1)
    for n = 1:size(results_exp5_bgr, 2)
       if results_exp5_bgr{i, n} == 0
            results_exp5_bgr{i, n} = NaN;
       end
    end
end


fit_thresh = 0.1;


results_exp1(results_exp1.model_fit_corrid > fit_thresh, "aperiodic_corrid") = {NaN};
results_exp1(results_exp1.model_fit_corrid > fit_thresh, "fooof_corrid") = {NaN};
results_exp1(results_exp1.model_fit_corrid > fit_thresh, "spectra_corrid") = {NaN};
results_exp1(results_exp1.model_fit_corrid > fit_thresh, "difference_corrid") = {NaN};
results_exp1(results_exp1.model_fit_corrid > fit_thresh, "spectrum_flat_corrid") = {NaN};
results_exp1(results_exp1.model_fit_corrid > fit_thresh, "spectrum_peak_rm_corrid") = {NaN};
results_exp1(results_exp1.model_fit_corrid > fit_thresh, "exponent_corrid") = {NaN};
results_exp1(results_exp1.model_fit_corrid > fit_thresh, "offset_flat_corrid") = {NaN};
results_exp1(results_exp1.model_fit_corrid > fit_thresh, "central_freq_corrid") = {NaN};
results_exp1(results_exp1.model_fit_corrid > fit_thresh, "r2_corrid") = {NaN};
results_exp1(results_exp1.model_fit_corrid > fit_thresh, "power_freq_corrid") = {NaN};
results_exp1(results_exp1.model_fit_corrid > fit_thresh, "modelfit_corrid") = {NaN};
results_exp1(results_exp1.model_fit_corrid > fit_thresh, "bandwith_freq_corrid") = {NaN};

results_exp1(results_exp1.model_fit_incid > fit_thresh, "aperiodic_incid") = {NaN};
results_exp1(results_exp1.model_fit_incid > fit_thresh, "fooof_incid") = {NaN};
results_exp1(results_exp1.model_fit_incid > fit_thresh, "spectra_incid") = {NaN};
results_exp1(results_exp1.model_fit_incid > fit_thresh, "difference_incid") = {NaN};
results_exp1(results_exp1.model_fit_incid > fit_thresh, "spectrum_flat_incid") = {NaN};
results_exp1(results_exp1.model_fit_incid > fit_thresh, "spectrum_peak_rm_incid") = {NaN};
results_exp1(results_exp1.model_fit_incid > fit_thresh, "exponent_incid") = {NaN};
results_exp1(results_exp1.model_fit_incid > fit_thresh, "offset_flat_incid") = {NaN};
results_exp1(results_exp1.model_fit_incid > fit_thresh, "central_freq_incid") = {NaN};
results_exp1(results_exp1.model_fit_incid > fit_thresh, "r2_incid") = {NaN};
results_exp1(results_exp1.model_fit_incid > fit_thresh, "power_freq_incid") = {NaN};
results_exp1(results_exp1.model_fit_incid > fit_thresh, "modelfit_incid") = {NaN};
results_exp1(results_exp1.model_fit_incid > fit_thresh, "bandwith_freq_incid") = {NaN};



results_exp3(results_exp3.model_fit_corrid > fit_thresh, "aperiodic_corrid") = {NaN};
results_exp3(results_exp3.model_fit_corrid > fit_thresh, "fooof_corrid") = {NaN};
results_exp3(results_exp3.model_fit_corrid > fit_thresh, "spectra_corrid") = {NaN};
results_exp3(results_exp3.model_fit_corrid > fit_thresh, "difference_corrid") = {NaN};
results_exp3(results_exp3.model_fit_corrid > fit_thresh, "spectrum_flat_corrid") = {NaN};
results_exp3(results_exp3.model_fit_corrid > fit_thresh, "spectrum_peak_rm_corrid") = {NaN};
results_exp3(results_exp3.model_fit_corrid > fit_thresh, "exponent_corrid") = {NaN};
results_exp3(results_exp3.model_fit_corrid > fit_thresh, "offset_flat_corrid") = {NaN};
results_exp3(results_exp3.model_fit_corrid > fit_thresh, "central_freq_corrid") = {NaN};
results_exp3(results_exp3.model_fit_corrid > fit_thresh, "r2_corrid") = {NaN};
results_exp3(results_exp3.model_fit_corrid > fit_thresh, "power_freq_corrid") = {NaN};
results_exp3(results_exp3.model_fit_corrid > fit_thresh, "modelfit_corrid") = {NaN};
results_exp3(results_exp3.model_fit_corrid > fit_thresh, "bandwith_freq_corrid") = {NaN};

results_exp3(results_exp3.model_fit_incid > fit_thresh, "aperiodic_incid") = {NaN};
results_exp3(results_exp3.model_fit_incid > fit_thresh, "fooof_incid") = {NaN};
results_exp3(results_exp3.model_fit_incid > fit_thresh, "spectra_incid") = {NaN};
results_exp3(results_exp3.model_fit_incid > fit_thresh, "difference_incid") = {NaN};
results_exp3(results_exp3.model_fit_incid > fit_thresh, "spectrum_flat_incid") = {NaN};
results_exp3(results_exp3.model_fit_incid > fit_thresh, "spectrum_peak_rm_incid") = {NaN};
results_exp3(results_exp3.model_fit_incid > fit_thresh, "exponent_incid") = {NaN};
results_exp3(results_exp3.model_fit_incid > fit_thresh, "offset_flat_incid") = {NaN};
results_exp3(results_exp3.model_fit_incid > fit_thresh, "central_freq_incid") = {NaN};
results_exp3(results_exp3.model_fit_incid > fit_thresh, "r2_incid") = {NaN};
results_exp3(results_exp3.model_fit_incid > fit_thresh, "power_freq_incid") = {NaN};
results_exp3(results_exp3.model_fit_incid > fit_thresh, "modelfit_incid") = {NaN};
results_exp3(results_exp3.model_fit_incid > fit_thresh, "bandwith_freq_incid") = {NaN};



results_exp4(results_exp4.model_fit_corrid > fit_thresh, "aperiodic_corrid") = {NaN};
results_exp4(results_exp4.model_fit_corrid > fit_thresh, "fooof_corrid") = {NaN};
results_exp4(results_exp4.model_fit_corrid > fit_thresh, "spectra_corrid") = {NaN};
results_exp4(results_exp4.model_fit_corrid > fit_thresh, "difference_corrid") = {NaN};
results_exp4(results_exp4.model_fit_corrid > fit_thresh, "spectrum_flat_corrid") = {NaN};
results_exp4(results_exp4.model_fit_corrid > fit_thresh, "spectrum_peak_rm_corrid") = {NaN};
results_exp4(results_exp4.model_fit_corrid > fit_thresh, "exponent_corrid") = {NaN};
results_exp4(results_exp4.model_fit_corrid > fit_thresh, "offset_flat_corrid") = {NaN};
results_exp4(results_exp4.model_fit_corrid > fit_thresh, "central_freq_corrid") = {NaN};
results_exp4(results_exp4.model_fit_corrid > fit_thresh, "r2_corrid") = {NaN};
results_exp4(results_exp4.model_fit_corrid > fit_thresh, "power_freq_corrid") = {NaN};
results_exp4(results_exp4.model_fit_corrid > fit_thresh, "modelfit_corrid") = {NaN};
results_exp4(results_exp4.model_fit_corrid > fit_thresh, "bandwith_freq_corrid") = {NaN};

results_exp4(results_exp4.model_fit_incid > fit_thresh, "aperiodic_incid") = {NaN};
results_exp4(results_exp4.model_fit_incid > fit_thresh, "fooof_incid") = {NaN};
results_exp4(results_exp4.model_fit_incid > fit_thresh, "spectra_incid") = {NaN};
results_exp4(results_exp4.model_fit_incid > fit_thresh, "difference_incid") = {NaN};
results_exp4(results_exp4.model_fit_incid > fit_thresh, "spectrum_flat_incid") = {NaN};
results_exp4(results_exp4.model_fit_incid > fit_thresh, "spectrum_peak_rm_incid") = {NaN};
results_exp4(results_exp4.model_fit_incid > fit_thresh, "exponent_incid") = {NaN};
results_exp4(results_exp4.model_fit_incid > fit_thresh, "offset_flat_incid") = {NaN};
results_exp4(results_exp4.model_fit_incid > fit_thresh, "central_freq_incid") = {NaN};
results_exp4(results_exp4.model_fit_incid > fit_thresh, "r2_incid") = {NaN};
results_exp4(results_exp4.model_fit_incid > fit_thresh, "power_freq_incid") = {NaN};
results_exp4(results_exp4.model_fit_incid > fit_thresh, "modelfit_incid") = {NaN};
results_exp4(results_exp4.model_fit_incid > fit_thresh, "bandwith_freq_incid") = {NaN};


results_exp5_bgr(results_exp5_bgr.model_fit_corrid > fit_thresh, "aperiodic_corrid") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_corrid > fit_thresh, "fooof_corrid") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_corrid > fit_thresh, "spectra_corrid") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_corrid > fit_thresh, "difference_corrid") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_corrid > fit_thresh, "spectrum_flat_corrid") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_corrid > fit_thresh, "spectrum_peak_rm_corrid") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_corrid > fit_thresh, "exponent_corrid") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_corrid > fit_thresh, "offset_flat_corrid") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_corrid > fit_thresh, "central_freq_corrid") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_corrid > fit_thresh, "r2_corrid") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_corrid > fit_thresh, "power_freq_corrid") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_corrid > fit_thresh, "modelfit_corrid") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_corrid > fit_thresh, "bandwith_freq_corrid") = {NaN};

results_exp5_bgr(results_exp5_bgr.model_fit_incid > fit_thresh, "aperiodic_incid") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_incid > fit_thresh, "fooof_incid") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_incid > fit_thresh, "spectra_incid") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_incid > fit_thresh, "difference_incid") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_incid > fit_thresh, "spectrum_flat_incid") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_incid > fit_thresh, "spectrum_peak_rm_incid") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_incid > fit_thresh, "exponent_incid") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_incid > fit_thresh, "offset_flat_incid") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_incid > fit_thresh, "central_freq_incid") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_incid > fit_thresh, "r2_incid") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_incid > fit_thresh, "power_freq_incid") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_incid > fit_thresh, "modelfit_incid") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_incid > fit_thresh, "bandwith_freq_incid") = {NaN};




results_exp5_obj(results_exp5_obj.model_fit_corrid > fit_thresh, "aperiodic_corrid") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_corrid > fit_thresh, "fooof_corrid") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_corrid > fit_thresh, "spectra_corrid") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_corrid > fit_thresh, "difference_corrid") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_corrid > fit_thresh, "spectrum_flat_corrid") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_corrid > fit_thresh, "spectrum_peak_rm_corrid") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_corrid > fit_thresh, "exponent_corrid") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_corrid > fit_thresh, "offset_flat_corrid") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_corrid > fit_thresh, "central_freq_corrid") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_corrid > fit_thresh, "r2_corrid") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_corrid > fit_thresh, "power_freq_corrid") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_corrid > fit_thresh, "modelfit_corrid") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_corrid > fit_thresh, "bandwith_freq_corrid") = {NaN};

results_exp5_obj(results_exp5_obj.model_fit_incid > fit_thresh, "aperiodic_incid") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_incid > fit_thresh, "fooof_incid") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_incid > fit_thresh, "spectra_incid") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_incid > fit_thresh, "difference_incid") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_incid > fit_thresh, "spectrum_flat_incid") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_incid > fit_thresh, "spectrum_peak_rm_incid") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_incid > fit_thresh, "exponent_incid") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_incid > fit_thresh, "offset_flat_incid") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_incid > fit_thresh, "central_freq_incid") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_incid > fit_thresh, "r2_incid") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_incid > fit_thresh, "power_freq_incid") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_incid > fit_thresh, "modelfit_incid") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_incid > fit_thresh, "bandwith_freq_incid") = {NaN};


%temp1 = results_exp1;
results_exp1(isnan(results_exp1.aperiodic_corrid), :) = [];
results_exp1(isnan(results_exp1.aperiodic_incid), :) = [];
results_exp1(isnan(results_exp1.spectra_corrid), :) = [];
results_exp1(isnan(results_exp1.spectra_incid), :) = [];
results_exp1(isnan(results_exp1.difference_corrid), :) = [];
results_exp1(isnan(results_exp1.difference_incid), :) = [];
results_exp1(isnan(results_exp1.spectrum_flat_corrid), :) = [];
results_exp1(isnan(results_exp1.spectrum_flat_incid), :) = [];
results_exp1(isnan(results_exp1.spectrum_peak_rm_corrid), :) = [];
results_exp1(isnan(results_exp1.spectrum_peak_rm_incid), :) = [];
results_exp1(isnan(results_exp1.exponent_corrid), :) = [];
results_exp1(isnan(results_exp1.exponent_incid), :) = [];
results_exp1(isnan(results_exp1.offset_flat_corrid), :) = [];
results_exp1(isnan(results_exp1.offset_flat_incid), :) = [];
results_exp1(isnan(results_exp1.central_freq_corrid), :) = [];
results_exp1(isnan(results_exp1.central_freq_incid), :) = [];
results_exp1(isnan(results_exp1.power_freq_corrid), :) = [];
results_exp1(isnan(results_exp1.power_freq_incid), :) = [];
results_exp1(isnan(results_exp1.bandwith_freq_corrid), :) = [];
results_exp1(isnan(results_exp1.modelfit_incid), :) = [];


results_exp3(isnan(results_exp3.aperiodic_corrid), :) = [];
results_exp3(isnan(results_exp3.aperiodic_incid), :) = [];
results_exp3(isnan(results_exp3.spectra_corrid), :) = [];
results_exp3(isnan(results_exp3.spectra_incid), :) = [];
results_exp3(isnan(results_exp3.difference_corrid), :) = [];
results_exp3(isnan(results_exp3.difference_incid), :) = [];
results_exp3(isnan(results_exp3.spectrum_flat_corrid), :) = [];
results_exp3(isnan(results_exp3.spectrum_flat_incid), :) = [];
results_exp3(isnan(results_exp3.spectrum_peak_rm_corrid), :) = [];
results_exp3(isnan(results_exp3.spectrum_peak_rm_incid), :) = [];
results_exp3(isnan(results_exp3.exponent_corrid), :) = [];
results_exp3(isnan(results_exp3.exponent_incid), :) = [];
results_exp3(isnan(results_exp3.offset_flat_corrid), :) = [];
results_exp3(isnan(results_exp3.offset_flat_incid), :) = [];
results_exp3(isnan(results_exp3.central_freq_corrid), :) = [];
results_exp3(isnan(results_exp3.central_freq_incid), :) = [];
results_exp3(isnan(results_exp3.power_freq_corrid), :) = [];
results_exp3(isnan(results_exp3.power_freq_incid), :) = [];
results_exp3(isnan(results_exp3.bandwith_freq_corrid), :) = [];
results_exp3(isnan(results_exp3.modelfit_incid), :) = [];



results_exp4(isnan(results_exp4.aperiodic_corrid), :) = [];
results_exp4(isnan(results_exp4.aperiodic_incid), :) = [];
results_exp4(isnan(results_exp4.spectra_corrid), :) = [];
results_exp4(isnan(results_exp4.spectra_incid), :) = [];
results_exp4(isnan(results_exp4.difference_corrid), :) = [];
results_exp4(isnan(results_exp4.difference_incid), :) = [];
results_exp4(isnan(results_exp4.spectrum_flat_corrid), :) = [];
results_exp4(isnan(results_exp4.spectrum_flat_incid), :) = [];
results_exp4(isnan(results_exp4.spectrum_peak_rm_corrid), :) = [];
results_exp4(isnan(results_exp4.spectrum_peak_rm_incid), :) = [];
results_exp4(isnan(results_exp4.exponent_corrid), :) = [];
results_exp4(isnan(results_exp4.exponent_incid), :) = [];
results_exp4(isnan(results_exp4.offset_flat_corrid), :) = [];
results_exp4(isnan(results_exp4.offset_flat_incid), :) = [];
results_exp4(isnan(results_exp4.central_freq_corrid), :) = [];
results_exp4(isnan(results_exp4.central_freq_incid), :) = [];
results_exp4(isnan(results_exp4.power_freq_corrid), :) = [];
results_exp4(isnan(results_exp4.power_freq_incid), :) = [];
results_exp4(isnan(results_exp4.bandwith_freq_corrid), :) = [];
results_exp4(isnan(results_exp4.modelfit_incid), :) = [];

results_exp5_bgr(isnan(results_exp5_bgr.aperiodic_corrid), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.aperiodic_incid), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.spectra_corrid), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.spectra_incid), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.difference_corrid), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.difference_incid), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.spectrum_flat_corrid), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.spectrum_flat_incid), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.spectrum_peak_rm_corrid), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.spectrum_peak_rm_incid), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.exponent_corrid), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.exponent_incid), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.offset_flat_corrid), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.offset_flat_incid), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.central_freq_corrid), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.central_freq_incid), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.power_freq_corrid), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.power_freq_incid), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.bandwith_freq_corrid), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.modelfit_incid), :) = [];

results_exp5_obj(isnan(results_exp5_obj.aperiodic_corrid), :) = [];
results_exp5_obj(isnan(results_exp5_obj.aperiodic_incid), :) = [];
results_exp5_obj(isnan(results_exp5_obj.spectra_corrid), :) = [];
results_exp5_obj(isnan(results_exp5_obj.spectra_incid), :) = [];
results_exp5_obj(isnan(results_exp5_obj.difference_corrid), :) = [];
results_exp5_obj(isnan(results_exp5_obj.difference_incid), :) = [];
results_exp5_obj(isnan(results_exp5_obj.spectrum_flat_corrid), :) = [];
results_exp5_obj(isnan(results_exp5_obj.spectrum_flat_incid), :) = [];
results_exp5_obj(isnan(results_exp5_obj.spectrum_peak_rm_corrid), :) = [];
results_exp5_obj(isnan(results_exp5_obj.spectrum_peak_rm_incid), :) = [];
results_exp5_obj(isnan(results_exp5_obj.exponent_corrid), :) = [];
results_exp5_obj(isnan(results_exp5_obj.exponent_incid), :) = [];
results_exp5_obj(isnan(results_exp5_obj.offset_flat_corrid), :) = [];
results_exp5_obj(isnan(results_exp5_obj.offset_flat_incid), :) = [];
results_exp5_obj(isnan(results_exp5_obj.central_freq_corrid), :) = [];
results_exp5_obj(isnan(results_exp5_obj.central_freq_incid), :) = [];
results_exp5_obj(isnan(results_exp5_obj.power_freq_corrid), :) = [];
results_exp5_obj(isnan(results_exp5_obj.power_freq_incid), :) = [];
results_exp5_obj(isnan(results_exp5_obj.bandwith_freq_corrid), :) = [];
results_exp5_obj(isnan(results_exp5_obj.modelfit_incid), :) = [];

writetable((results_exp1), 'D:\FOOOF results\exp1_corrected_objective.csv')
writetable((results_exp3), 'D:\FOOOF results\exp3_corrected_objective.csv')
writetable((results_exp4), 'D:\FOOOF results\exp4_corrected_objective.csv')
writetable((results_exp5_bgr), 'D:\FOOOF results\exp5_bgr_corrected_objective.csv')
writetable((results_exp5_obj), 'D:\FOOOF results\exp5_obj_corrected_objective.csv')

%% Plotting objective task

figure;


labels = {'EXP 1 - Threshold'; ''; 'EXP 2 - Mask'; ''; 'EXP 3 - Faces';''; 'EXP 4.1 - Background'; ''; 'EXP 4.2 - Object'; '';}

subplot(2,3,1)
hold on



scatter(1, squeeze(mean(results_exp1.difference_incid, 'omitnan')), "red")
errorbar(1, squeeze(mean(results_exp1.difference_incid, 'omitnan')),semNAN(results_exp1.difference_incid) , "red")
scatter(2, squeeze(mean(results_exp1.difference_corrid, 'omitnan')), "blue")
errorbar(2, squeeze(mean(results_exp1.difference_corrid, 'omitnan')),semNAN(results_exp1.difference_corrid), "blue")

scatter(3, squeeze(mean(results_exp3.difference_incid, 'omitnan')), "red")
errorbar(3, squeeze(mean(results_exp3.difference_incid, 'omitnan')),semNAN(results_exp3.difference_incid), "red")
scatter(4, squeeze(mean(results_exp3.difference_corrid, 'omitnan')), "blue")
errorbar(4, squeeze(mean(results_exp3.difference_corrid, 'omitnan')),semNAN(results_exp3.difference_corrid), "blue")
if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.difference_incid, 'omitnan')), "red")
    errorbar(5, squeeze(mean(results_exp4.difference_incid, 'omitnan')),semNAN(results_exp4.difference_incid), "red")
    scatter(6, squeeze(mean(results_exp4.difference_corrid, 'omitnan')), "blue")
    errorbar(6, squeeze(mean(results_exp4.difference_corrid, 'omitnan')),semNAN(results_exp4.difference_corrid), "blue")


    scatter(7, squeeze(mean(results_exp5_obj.difference_incid, 'omitnan')), "red")
    errorbar(7, squeeze(mean(results_exp5_obj.difference_incid, 'omitnan')),semNAN(results_exp5_obj.difference_incid), "red")
    scatter(8, squeeze(mean(results_exp5_obj.difference_corrid, 'omitnan')), "blue")
    errorbar(8, squeeze(mean(results_exp5_obj.difference_corrid, 'omitnan')),semNAN(results_exp5_obj.difference_corrid), "blue")


    scatter(9, squeeze(mean(results_exp5_bgr.difference_incid, 'omitnan')), "red")
    errorbar(9, squeeze(mean(results_exp5_bgr.difference_incid, 'omitnan')),semNAN(results_exp5_bgr.difference_incid), "red")
    scatter(10, squeeze(mean(results_exp5_bgr.difference_corrid, 'omitnan')), "blue")
    errorbar(10, squeeze(mean(results_exp5_bgr.difference_corrid, 'omitnan')),semNAN(results_exp5_bgr.difference_corrid), "blue")
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.difference_corrid, 'omitnan') mean(results_exp1.difference_incid, 'omitnan') mean(results_exp3.difference_corrid, 'omitnan') mean(results_exp3.difference_incid, 'omitnan') mean(results_exp4.difference_corrid, 'omitnan') mean(results_exp4.difference_incid, 'omitnan')  mean(results_exp5_obj.difference_corrid, 'omitnan') mean(results_exp5_obj.difference_incid, 'omitnan')  mean(results_exp5_bgr.difference_corrid, 'omitnan') mean(results_exp5_bgr.difference_incid, 'omitnan')]));
    ylim_max = max(max([mean(results_exp1.difference_corrid, 'omitnan') mean(results_exp1.difference_incid, 'omitnan') mean(results_exp3.difference_corrid, 'omitnan') mean(results_exp3.difference_incid, 'omitnan') mean(results_exp4.difference_corrid, 'omitnan') mean(results_exp4.difference_incid, 'omitnan') mean(results_exp5_obj.difference_corrid, 'omitnan') mean(results_exp5_obj.difference_incid, 'omitnan')  mean(results_exp5_bgr.difference_corrid, 'omitnan') mean(results_exp5_bgr.difference_incid, 'omitnan')]));
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
ylim_min = min(min([mean(results_exp1.difference_corrid, 'omitnan') mean(results_exp1.difference_incid, 'omitnan') mean(results_exp3.difference_corrid, 'omitnan') mean(results_exp3.difference_incid, 'omitnan')]));
ylim_max = max(max([mean(results_exp1.difference_corrid, 'omitnan') mean(results_exp1.difference_incid, 'omitnan') mean(results_exp3.difference_corrid, 'omitnan') mean(results_exp3.difference_incid, 'omitnan')]));
ylim([ylim_min-(abs(ylim_min)*1) ylim_max+(abs(ylim_max)*0.3)])
end

xlabel(' ')
if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'Incorrect'; 'Correct';'Incorrect'; 'Correct'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6, 7, 8, 9, 10])
%label_pas = {'Incorrect';'Correct'; 'Incorrect'; 'Correct'; 'Incorrect'; 'Correct'; ' Obj Incorrect'; ' Obj Correct'; ' Bgr Incorrect'; ' Bgr Correct';}
%xticklabels(label_pas)
xticklabels(labels)
xline(2.5)
xline(4.5)
xline(6.5)
xline(8.5)
xlim([0 11])
end
title('Adjusted power')
hold off;




subplot(2,3,2)
hold on
scatter(2, squeeze(mean(results_exp1.central_freq_corrid,'omitnan')), "blue")
errorbar(2, squeeze(mean(results_exp1.central_freq_corrid, 'omitnan')), semNAN(results_exp1.central_freq_corrid), "blue")
scatter(1, squeeze(mean(results_exp1.central_freq_incid, 'omitnan')), "red")
errorbar(1, squeeze(mean(results_exp1.central_freq_incid, 'omitnan')),semNAN(results_exp1.central_freq_incid), "red")

scatter(4, squeeze(mean(results_exp3.central_freq_corrid,'omitnan')), "blue")
errorbar(4, squeeze(mean(results_exp3.central_freq_corrid, 'omitnan')), semNAN(results_exp3.central_freq_corrid), "blue")
scatter(3, squeeze(mean(results_exp3.central_freq_incid, 'omitnan')), "red")
errorbar(3, squeeze(mean(results_exp3.central_freq_incid, 'omitnan')), semNAN(results_exp3.central_freq_incid), "red")

if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.central_freq_incid,'omitnan')), "red")
    errorbar(5, squeeze(mean(results_exp4.central_freq_incid, 'omitnan')), semNAN(results_exp4.central_freq_incid), "red")
    scatter(6, squeeze(mean(results_exp4.central_freq_corrid,'omitnan')), "blue")
    errorbar(6, squeeze(mean(results_exp4.central_freq_corrid, 'omitnan')), semNAN(results_exp4.central_freq_corrid), "blue")


    scatter(7, squeeze(mean(results_exp5_obj.central_freq_incid,'omitnan')), "red")
    errorbar(7, squeeze(mean(results_exp5_obj.central_freq_incid, 'omitnan')), semNAN(results_exp5_obj.central_freq_incid), "red")
    scatter(8, squeeze(mean(results_exp5_obj.central_freq_corrid,'omitnan')), "blue")
    errorbar(8, squeeze(mean(results_exp5_obj.central_freq_corrid, 'omitnan')), semNAN(results_exp5_obj.central_freq_corrid), "blue")


    scatter(9, squeeze(mean(results_exp5_bgr.central_freq_incid,'omitnan')), "red")
    errorbar(9, squeeze(mean(results_exp5_bgr.central_freq_incid, 'omitnan')), semNAN(results_exp5_bgr.central_freq_incid), "red")
    scatter(10, squeeze(mean(results_exp5_bgr.central_freq_corrid,'omitnan')), "blue")
    errorbar(10, squeeze(mean(results_exp5_bgr.central_freq_corrid, 'omitnan')), semNAN(results_exp5_bgr.central_freq_corrid), "blue")
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.central_freq_corrid,'omitnan') mean(results_exp1.central_freq_incid,'omitnan') mean(results_exp3.central_freq_corrid,'omitnan') mean(results_exp3.central_freq_incid,'omitnan') mean(results_exp4.central_freq_corrid,'omitnan') mean(results_exp4.central_freq_incid)  mean(results_exp5_obj.central_freq_corrid,'omitnan') mean(results_exp5_obj.central_freq_incid)  mean(results_exp5_bgr.central_freq_corrid,'omitnan') mean(results_exp5_bgr.central_freq_incid,'omitnan')]));
    ylim_max = max(max([mean(results_exp1.central_freq_corrid,'omitnan') mean(results_exp1.central_freq_incid,'omitnan') mean(results_exp3.central_freq_corrid,'omitnan') mean(results_exp3.central_freq_incid,'omitnan') mean(results_exp4.central_freq_corrid,'omitnan') mean(results_exp4.central_freq_incid)  mean(results_exp5_obj.central_freq_corrid,'omitnan') mean(results_exp5_obj.central_freq_incid)  mean(results_exp5_bgr.central_freq_corrid,'omitnan') mean(results_exp5_bgr.central_freq_incid,'omitnan')]));
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
    ylim_min = min(min([mean(results_exp1.central_freq_corrid,'omitnan') mean(results_exp1.central_freq_incid,'omitnan') mean(results_exp3.central_freq_corrid,'omitnan') mean(results_exp3.central_freq_incid,'omitnan')]));
    ylim_max = max(max([mean(results_exp1.central_freq_corrid,'omitnan') mean(results_exp1.central_freq_incid,'omitnan') mean(results_exp3.central_freq_corrid,'omitnan') mean(results_exp3.central_freq_incid,'omitnan')]))
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
xlabel(' ')
if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'Incorrect'; 'Correct';'Incorrect'; 'Correct'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6, 7, 8, 9, 10])
%label_pas = {'Incorrect';'Correct'; 'Incorrect'; 'Correct'; 'Incorrect'; 'Correct'; ' Obj Incorrect'; ' Obj Correct'; ' Bgr Incorrect'; ' Bgr Correct';}
%xticklabels(label_pas)
xticklabels(labels)
xline(2.5)
xline(4.5)
xline(6.5)
xline(8.5)
xlim([0 11])
end
title('Central Frequency')
hold off;



subplot(2,3,3)
hold on
scatter(2, squeeze(mean(results_exp1.bandwith_freq_corrid,'omitnan')), "blue")
errorbar(2, squeeze(mean(results_exp1.bandwith_freq_corrid, 'omitnan')), semNAN(results_exp1.bandwith_freq_corrid), "blue")
scatter(1, squeeze(mean(results_exp1.bandwith_freq_incid,'omitnan')), "red")
errorbar(1, squeeze(mean(results_exp1.bandwith_freq_incid, 'omitnan')), semNAN(results_exp1.bandwith_freq_incid), "red")

scatter(4, squeeze(mean(results_exp3.bandwith_freq_corrid,'omitnan')), "blue")
errorbar(4, squeeze(mean(results_exp3.bandwith_freq_corrid, 'omitnan')), semNAN(results_exp3.bandwith_freq_corrid), "blue")
scatter(3, squeeze(mean(results_exp3.bandwith_freq_incid,'omitnan')), "red")
errorbar(3, squeeze(mean(results_exp3.bandwith_freq_incid, 'omitnan')), semNAN(results_exp3.bandwith_freq_incid), "red")


if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.bandwith_freq_incid,'omitnan')), "red")
    errorbar(5, squeeze(mean(results_exp4.bandwith_freq_incid, 'omitnan')), semNAN(results_exp4.bandwith_freq_incid), "red")
    scatter(6, squeeze(mean(results_exp4.bandwith_freq_corrid,'omitnan')), "blue")
    errorbar(6, squeeze(mean(results_exp4.bandwith_freq_corrid, 'omitnan')), semNAN(results_exp4.bandwith_freq_corrid), "blue")


    scatter(7, squeeze(mean(results_exp5_obj.bandwith_freq_incid,'omitnan')), "red")
    errorbar(7, squeeze(mean(results_exp5_obj.bandwith_freq_incid, 'omitnan')), semNAN(results_exp5_obj.bandwith_freq_incid), "red")
    scatter(8, squeeze(mean(results_exp5_obj.bandwith_freq_corrid,'omitnan')), "blue")
    errorbar(8, squeeze(mean(results_exp5_obj.bandwith_freq_corrid, 'omitnan')), semNAN(results_exp5_obj.bandwith_freq_corrid), "blue")


    scatter(9, squeeze(mean(results_exp5_bgr.bandwith_freq_incid,'omitnan')), "red")
    errorbar(9, squeeze(mean(results_exp5_bgr.bandwith_freq_incid, 'omitnan')), semNAN(results_exp5_bgr.bandwith_freq_incid), "red")
    scatter(10, squeeze(mean(results_exp5_bgr.bandwith_freq_corrid,'omitnan')), "blue")
    errorbar(10, squeeze(mean(results_exp5_bgr.bandwith_freq_corrid, 'omitnan')), semNAN(results_exp5_bgr.bandwith_freq_corrid), "blue")
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.bandwith_freq_corrid,'omitnan') mean(results_exp1.bandwith_freq_incid,'omitnan') mean(results_exp3.bandwith_freq_corrid,'omitnan') mean(results_exp3.bandwith_freq_incid,'omitnan') mean(results_exp4.bandwith_freq_corrid,'omitnan') mean(results_exp4.bandwith_freq_incid)  mean(results_exp5_obj.bandwith_freq_corrid,'omitnan') mean(results_exp5_obj.bandwith_freq_incid)  mean(results_exp5_bgr.bandwith_freq_corrid,'omitnan') mean(results_exp5_bgr.bandwith_freq_incid,'omitnan')]));
    ylim_max = max(max([mean(results_exp1.bandwith_freq_corrid,'omitnan') mean(results_exp1.bandwith_freq_incid,'omitnan') mean(results_exp3.bandwith_freq_corrid,'omitnan') mean(results_exp3.bandwith_freq_incid,'omitnan') mean(results_exp4.bandwith_freq_corrid,'omitnan') mean(results_exp4.bandwith_freq_incid)  mean(results_exp5_obj.bandwith_freq_corrid,'omitnan') mean(results_exp5_obj.bandwith_freq_incid)  mean(results_exp5_bgr.bandwith_freq_corrid,'omitnan') mean(results_exp5_bgr.bandwith_freq_incid,'omitnan')]));
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
    ylim_min = min(min([mean(results_exp1.bandwith_freq_corrid,'omitnan') mean(results_exp1.bandwith_freq_incid,'omitnan') mean(results_exp3.bandwith_freq_corrid,'omitnan') mean(results_exp3.bandwith_freq_incid,'omitnan')]));
    ylim_max = max(max([mean(results_exp1.bandwith_freq_corrid,'omitnan') mean(results_exp1.bandwith_freq_incid,'omitnan') mean(results_exp3.bandwith_freq_corrid,'omitnan') mean(results_exp3.bandwith_freq_incid,'omitnan')]))
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end

xlabel(' ')

if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'Incorrect'; 'Correct';'Incorrect'; 'Correct'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6, 7, 8, 9, 10])
%label_pas = {'Incorrect';'Correct'; 'Incorrect'; 'Correct'; 'Incorrect'; 'Correct'; ' Obj Incorrect'; ' Obj Correct'; ' Bgr Incorrect'; ' Bgr Correct';}
%xticklabels(label_pas)
xticklabels(labels)
xline(2.5)
xline(4.5)
xline(6.5)
xline(8.5)
xlim([0 11])
end
title('Bandwith')
hold off;







hold on; 
subplot(2,3,4)
hold on;
scatter(1, squeeze(mean(results_exp1.aperiodic_incid,'omitnan')), "red")
errorbar(1, squeeze(mean(results_exp1.aperiodic_incid, 'omitnan')), semNAN(results_exp1.aperiodic_incid), "red")
scatter(2, squeeze(mean(results_exp1.aperiodic_corrid,'omitnan')), "blue")
errorbar(2, squeeze(mean(results_exp1.aperiodic_corrid, 'omitnan')), semNAN(results_exp1.aperiodic_corrid), "blue")

scatter(3, squeeze(mean(results_exp3.aperiodic_incid,'omitnan')), "red")
errorbar(3, squeeze(mean(results_exp3.aperiodic_incid, 'omitnan')), semNAN(results_exp3.aperiodic_incid), "red")
scatter(4, squeeze(mean(results_exp3.aperiodic_corrid,'omitnan')), "blue")
errorbar(4, squeeze(mean(results_exp3.aperiodic_corrid, 'omitnan')), semNAN(results_exp3.aperiodic_corrid), "blue")

if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.aperiodic_incid,'omitnan')), "red")
    errorbar(5, squeeze(mean(results_exp4.aperiodic_incid, 'omitnan')), semNAN(results_exp4.aperiodic_incid), "red")
    scatter(6, squeeze(mean(results_exp4.aperiodic_corrid,'omitnan')), "blue")
    errorbar(6, squeeze(mean(results_exp4.aperiodic_corrid, 'omitnan')), semNAN(results_exp4.aperiodic_corrid), "blue")


    scatter(7, squeeze(mean(results_exp5_obj.aperiodic_incid,'omitnan')), "red")
    errorbar(7, squeeze(mean(results_exp5_obj.aperiodic_incid, 'omitnan')), semNAN(results_exp5_obj.aperiodic_incid), "red")
    scatter(8, squeeze(mean(results_exp5_obj.aperiodic_corrid,'omitnan')), "blue")
    errorbar(8, squeeze(mean(results_exp5_obj.aperiodic_corrid, 'omitnan')), semNAN(results_exp5_obj.aperiodic_corrid), "blue")


    scatter(9, squeeze(mean(results_exp5_bgr.aperiodic_incid,'omitnan')), "red")
    errorbar(9, squeeze(mean(results_exp5_bgr.aperiodic_incid, 'omitnan')), semNAN(results_exp5_bgr.aperiodic_incid), "red")
    scatter(10, squeeze(mean(results_exp5_bgr.aperiodic_corrid,'omitnan')), "blue")
    errorbar(10, squeeze(mean(results_exp5_bgr.aperiodic_corrid, 'omitnan')), semNAN(results_exp5_bgr.aperiodic_corrid), "blue")
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.aperiodic_corrid,'omitnan') mean(results_exp1.aperiodic_incid,'omitnan') mean(results_exp3.aperiodic_corrid,'omitnan') mean(results_exp3.aperiodic_incid,'omitnan') mean(results_exp4.aperiodic_corrid,'omitnan') mean(results_exp4.aperiodic_incid,'omitnan') mean(results_exp5_obj.aperiodic_corrid,'omitnan') mean(results_exp5_obj.aperiodic_incid)  mean(results_exp5_bgr.aperiodic_corrid,'omitnan') mean(results_exp5_bgr.aperiodic_incid,'omitnan')]));
    ylim_max = max(max([mean(results_exp1.aperiodic_corrid,'omitnan') mean(results_exp1.aperiodic_incid,'omitnan') mean(results_exp3.aperiodic_corrid,'omitnan') mean(results_exp3.aperiodic_incid,'omitnan') mean(results_exp4.aperiodic_corrid,'omitnan') mean(results_exp4.aperiodic_incid,'omitnan') mean(results_exp5_obj.aperiodic_corrid,'omitnan') mean(results_exp5_obj.aperiodic_incid)  mean(results_exp5_bgr.aperiodic_corrid,'omitnan') mean(results_exp5_bgr.aperiodic_incid,'omitnan')]));
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
    ylim_min = min(min([mean(results_exp1.aperiodic_corrid,'omitnan') mean(results_exp1.aperiodic_incid,'omitnan') mean(results_exp3.aperiodic_corrid,'omitnan') mean(results_exp3.aperiodic_incid,'omitnan')]));
    ylim_max = max(max([mean(results_exp1.aperiodic_corrid,'omitnan') mean(results_exp1.aperiodic_incid,'omitnan') mean(results_exp3.aperiodic_corrid,'omitnan') mean(results_exp3.aperiodic_incid,'omitnan')]))
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end

    xlabel(' ')

if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'Incorrect';'Correct'; 'Incorrect'; 'Correct';}
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6, 7, 8, 9, 10])
%label_pas = {'Incorrect';'Correct'; 'Incorrect'; 'Correct'; 'Incorrect'; 'Correct'; ' Obj Incorrect'; ' Obj Correct'; ' Bgr Incorrect'; ' Bgr Correct';}
%xticklabels(label_pas)
xticklabels(labels)
xline(2.5)
xline(4.5)
xline(6.5)
xline(8.5)
xlim([0 11])
end

title('Aperiodic Activity')
hold off;


subplot(2,3,5)
hold on
scatter(2, squeeze(mean(results_exp1.exponent_corrid,'omitnan')), "blue")
errorbar(2, squeeze(mean(results_exp1.exponent_corrid, 'omitnan')), semNAN(results_exp1.exponent_corrid), "blue")
scatter(1, squeeze(mean(results_exp1.exponent_incid,'omitnan')), "red")
errorbar(1, squeeze(mean(results_exp1.exponent_incid, 'omitnan')), semNAN(results_exp1.exponent_incid), "red")

scatter(4, squeeze(mean(results_exp3.exponent_corrid,'omitnan')), "blue")
errorbar(4, squeeze(mean(results_exp3.exponent_corrid, 'omitnan')), semNAN(results_exp3.exponent_corrid), "blue")
scatter(3, squeeze(mean(results_exp3.exponent_incid,'omitnan')), "red")
errorbar(3, squeeze(mean(results_exp3.exponent_incid, 'omitnan')), semNAN(results_exp3.exponent_incid), "red")

if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.exponent_incid,'omitnan')), "red")
    errorbar(5, squeeze(mean(results_exp4.exponent_incid, 'omitnan')), semNAN(results_exp4.exponent_incid), "red")
    scatter(6, squeeze(mean(results_exp4.exponent_corrid,'omitnan')), "blue")
    errorbar(6, squeeze(mean(results_exp4.exponent_corrid, 'omitnan')), semNAN(results_exp4.exponent_corrid), "blue")


    scatter(7, squeeze(mean(results_exp5_obj.exponent_incid,'omitnan')), "red")
    errorbar(7, squeeze(mean(results_exp5_obj.exponent_incid, 'omitnan')), semNAN(results_exp5_obj.exponent_incid), "red")
    scatter(8, squeeze(mean(results_exp5_obj.exponent_corrid,'omitnan')), "blue")
    errorbar(8, squeeze(mean(results_exp5_obj.exponent_corrid, 'omitnan')), semNAN(results_exp5_obj.exponent_corrid), "blue")


    scatter(9, squeeze(mean(results_exp5_bgr.exponent_incid,'omitnan')), "red")
    errorbar(9, squeeze(mean(results_exp5_bgr.exponent_incid, 'omitnan')), semNAN(results_exp5_bgr.exponent_incid), "red")
    scatter(10, squeeze(mean(results_exp5_bgr.exponent_corrid,'omitnan')), "blue")
    errorbar(10, squeeze(mean(results_exp5_bgr.exponent_corrid, 'omitnan')), semNAN(results_exp5_bgr.exponent_corrid), "blue")
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.exponent_corrid,'omitnan') mean(results_exp1.exponent_incid,'omitnan') mean(results_exp3.exponent_corrid,'omitnan') mean(results_exp3.exponent_incid,'omitnan') mean(results_exp4.exponent_corrid,'omitnan') mean(results_exp4.exponent_incid,'omitnan') mean(results_exp5_obj.exponent_corrid,'omitnan') mean(results_exp5_obj.exponent_incid)  mean(results_exp5_bgr.exponent_corrid,'omitnan') mean(results_exp5_bgr.exponent_incid,'omitnan')]));
    ylim_max = max(max([mean(results_exp1.exponent_corrid,'omitnan') mean(results_exp1.exponent_incid,'omitnan') mean(results_exp3.exponent_corrid,'omitnan') mean(results_exp3.exponent_incid,'omitnan') mean(results_exp4.exponent_corrid,'omitnan') mean(results_exp4.exponent_incid,'omitnan') mean(results_exp5_obj.exponent_corrid,'omitnan') mean(results_exp5_obj.exponent_incid)  mean(results_exp5_bgr.exponent_corrid,'omitnan') mean(results_exp5_bgr.exponent_incid,'omitnan')]));
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
ylim_min = min(min([mean(results_exp1.exponent_corrid,'omitnan') mean(results_exp1.exponent_incid,'omitnan') mean(results_exp3.exponent_corrid,'omitnan') mean(results_exp3.exponent_incid,'omitnan')]));
ylim_max = max(max([mean(results_exp1.exponent_corrid,'omitnan') mean(results_exp1.exponent_incid,'omitnan') mean(results_exp3.exponent_corrid,'omitnan') mean(results_exp3.exponent_incid,'omitnan')]));
ylim([ylim_min-(abs(ylim_min)*1) ylim_max+(abs(ylim_max)*0.3)])
end
xlabel(' ')
if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'Incorrect'; 'Correct';'Incorrect'; 'Correct'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6, 7, 8, 9, 10])
%label_pas = {'Incorrect';'Correct'; 'Incorrect'; 'Correct'; 'Incorrect'; 'Correct'; ' Obj Incorrect'; ' Obj Correct'; ' Bgr Incorrect'; ' Bgr Correct';}
%xticklabels(label_pas)
xticklabels(labels)
xline(2.5)
xline(4.5)
xline(6.5)
xline(8.5)
xlim([0 11])
end
title('Exponent')
hold off;

subplot(2,3,6)
hold on
scatter(2, squeeze(mean(results_exp1.offset_flat_corrid,'omitnan')), "blue")
errorbar(2, squeeze(mean(results_exp1.offset_flat_corrid, 'omitnan')), semNAN(results_exp1.offset_flat_corrid), "blue")
scatter(1, squeeze(mean(results_exp1.offset_flat_incid,'omitnan')), "red")
errorbar(1, squeeze(mean(results_exp1.offset_flat_incid, 'omitnan')), semNAN(results_exp1.offset_flat_incid), "red")

scatter(4, squeeze(mean(results_exp3.offset_flat_corrid,'omitnan')), "blue")
errorbar(4, squeeze(mean(results_exp3.offset_flat_corrid, 'omitnan')), semNAN(results_exp3.offset_flat_corrid), "blue")
scatter(3, squeeze(mean(results_exp3.offset_flat_incid,'omitnan')), "red")
errorbar(3, squeeze(mean(results_exp3.offset_flat_incid, 'omitnan')), semNAN(results_exp3.offset_flat_incid), "red")

if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.offset_flat_incid,'omitnan')), "red")
    errorbar(5, squeeze(mean(results_exp4.offset_flat_incid, 'omitnan')), semNAN(results_exp4.offset_flat_incid), "red")
    scatter(6, squeeze(mean(results_exp4.offset_flat_corrid,'omitnan')), "blue")
    errorbar(6, squeeze(mean(results_exp4.offset_flat_corrid, 'omitnan')), semNAN(results_exp4.offset_flat_corrid), "blue")


    scatter(7, squeeze(mean(results_exp5_obj.offset_flat_incid,'omitnan')), "red")
    errorbar(7, squeeze(mean(results_exp5_obj.offset_flat_incid, 'omitnan')), semNAN(results_exp5_obj.offset_flat_incid), "red")
    scatter(8, squeeze(mean(results_exp5_obj.offset_flat_corrid,'omitnan')), "blue")
    errorbar(8, squeeze(mean(results_exp5_obj.offset_flat_corrid, 'omitnan')), semNAN(results_exp5_obj.offset_flat_corrid), "blue")


    scatter(9, squeeze(mean(results_exp5_bgr.offset_flat_incid,'omitnan')), "red")
    errorbar(9, squeeze(mean(results_exp5_bgr.offset_flat_incid, 'omitnan')), semNAN(results_exp5_bgr.offset_flat_incid), "red")
    scatter(10, squeeze(mean(results_exp5_bgr.offset_flat_corrid,'omitnan')), "blue")
    errorbar(10, squeeze(mean(results_exp5_bgr.offset_flat_corrid, 'omitnan')), semNAN(results_exp5_bgr.offset_flat_corrid), "blue")
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.offset_flat_corrid,'omitnan') mean(results_exp1.offset_flat_incid,'omitnan') mean(results_exp3.offset_flat_corrid,'omitnan') mean(results_exp3.offset_flat_incid,'omitnan') mean(results_exp4.offset_flat_corrid,'omitnan') mean(results_exp4.offset_flat_incid,'omitnan') mean(results_exp5_obj.offset_flat_corrid,'omitnan') mean(results_exp5_obj.offset_flat_incid)  mean(results_exp5_bgr.offset_flat_corrid,'omitnan') mean(results_exp5_bgr.offset_flat_incid,'omitnan')]));
    ylim_max = max(max([mean(results_exp1.offset_flat_corrid,'omitnan') mean(results_exp1.offset_flat_incid,'omitnan') mean(results_exp3.offset_flat_corrid,'omitnan') mean(results_exp3.offset_flat_incid,'omitnan') mean(results_exp4.offset_flat_corrid,'omitnan') mean(results_exp4.offset_flat_incid,'omitnan') mean(results_exp5_obj.offset_flat_corrid,'omitnan') mean(results_exp5_obj.offset_flat_incid)  mean(results_exp5_bgr.offset_flat_corrid,'omitnan') mean(results_exp5_bgr.offset_flat_incid,'omitnan')]));
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
    ylim_min = min(min([mean(results_exp1.offset_flat_corrid,'omitnan') mean(results_exp1.offset_flat_incid,'omitnan') mean(results_exp3.offset_flat_corrid,'omitnan') mean(results_exp3.offset_flat_incid,'omitnan')]));
    ylim_max = max(max([mean(results_exp1.offset_flat_corrid,'omitnan') mean(results_exp1.offset_flat_incid,'omitnan') mean(results_exp3.offset_flat_corrid,'omitnan') mean(results_exp3.offset_flat_incid,'omitnan')]))
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end




xlabel(' ')
if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'Incorrect'; 'Correct';'Incorrect'; 'Correct'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6, 7, 8, 9, 10])
%label_pas = {'Incorrect';'Correct'; 'Incorrect'; 'Correct'; 'Incorrect'; 'Correct'; ' Obj Incorrect'; ' Obj Correct'; ' Bgr Incorrect'; ' Bgr Correct';}
%xticklabels(label_pas)
xticklabels(labels)
xline(2.5)
xline(4.5)
xline(6.5)
xline(8.5)
xlim([0 11])
end
title('Offset')
hold off;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% plotting subjective task


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


results_exp1 = readtable('D:\Drive\1 - Threshold\pwelch_adjusted_timewindow\pwelch_result\csv_export\results.csv')
results_exp3 = readtable('D:\Drive\3 - Mask\pwelch_adjusted_timewindow\pwelch_result\csv_export\results.csv')

settings.plot_4th = 1;
if settings.plot_4th == 1
    results_exp4 = readtable('D:\Drive\4 - Faces\pwelch_adjusted_timewindow\pwelch_result\csv_export\results.csv')
    results_exp5_obj = readtable('D:\Drive\5 - Scenes\pwelch_adjusted_timewindow\pwelch_result\obj\csv_export\results.csv')
    results_exp5_bgr = readtable('D:\Drive\5 - Scenes\pwelch_adjusted_timewindow\pwelch_result\bgr\csv_export\results.csv')
end


addpath('C:\Users\user\Documents\GitHub\NewPreprocessing\helpers')



for i = 1:size(results_exp1, 1)
    for n = 1:size(results_exp1, 2)
       if results_exp1{i, n} == 0
            results_exp1{i, n} = NaN;
       end
    end
end
for i = 1:size(results_exp3, 1)
    for n = 1:size(results_exp3, 2)
       if results_exp3{i, n} == 0
            results_exp3{i, n} = NaN;
       end
    end
end
for i = 1:size(results_exp4, 1)
    for n = 1:size(results_exp4, 2)
       if results_exp4{i, n} == 0
            results_exp4{i, n} = NaN;
       end
    end
end
for i = 1:size(results_exp5_obj, 1)
    for n = 1:size(results_exp5_obj, 2)
       if results_exp5_obj{i, n} == 0
            results_exp5_obj{i, n} = NaN;
       end
    end
end
for i = 1:size(results_exp5_bgr, 1)
    for n = 1:size(results_exp5_bgr, 2)
       if results_exp5_bgr{i, n} == 0
            results_exp5_bgr{i, n} = NaN;
       end
    end
end


fit_thresh = 0.1;
results_exp1(results_exp1.model_fit_highpas > fit_thresh, "aperiodic_highpas") = {NaN};
results_exp1(results_exp1.model_fit_highpas > fit_thresh, "fooof_highpas") = {NaN};
results_exp1(results_exp1.model_fit_highpas > fit_thresh, "spectra_highpas") = {NaN};
results_exp1(results_exp1.model_fit_highpas > fit_thresh, "difference_highpas") = {NaN};
results_exp1(results_exp1.model_fit_highpas > fit_thresh, "spectrum_flat_highpas") = {NaN};
results_exp1(results_exp1.model_fit_highpas > fit_thresh, "spectrum_peak_rm_highpas") = {NaN};
results_exp1(results_exp1.model_fit_highpas > fit_thresh, "exponent_highpas") = {NaN};
results_exp1(results_exp1.model_fit_highpas > fit_thresh, "offset_flat_highpas") = {NaN};
results_exp1(results_exp1.model_fit_highpas > fit_thresh, "central_freq_highpas") = {NaN};
results_exp1(results_exp1.model_fit_highpas > fit_thresh, "r2_highpas") = {NaN};
results_exp1(results_exp1.model_fit_highpas > fit_thresh, "power_freq_highpas") = {NaN};
results_exp1(results_exp1.model_fit_highpas > fit_thresh, "modelfit_highpas") = {NaN};
results_exp1(results_exp1.model_fit_highpas > fit_thresh, "bandwith_freq_highpas") = {NaN};

results_exp1(results_exp1.model_fit_lowpas > fit_thresh, "aperiodic_lowpas") = {NaN};
results_exp1(results_exp1.model_fit_lowpas > fit_thresh, "fooof_lowpas") = {NaN};
results_exp1(results_exp1.model_fit_lowpas > fit_thresh, "spectra_lowpas") = {NaN};
results_exp1(results_exp1.model_fit_lowpas > fit_thresh, "difference_lowpas") = {NaN};
results_exp1(results_exp1.model_fit_lowpas > fit_thresh, "spectrum_flat_lowpas") = {NaN};
results_exp1(results_exp1.model_fit_lowpas > fit_thresh, "spectrum_peak_rm_lowpas") = {NaN};
results_exp1(results_exp1.model_fit_lowpas > fit_thresh, "exponent_lowpas") = {NaN};
results_exp1(results_exp1.model_fit_lowpas > fit_thresh, "offset_flat_lowpas") = {NaN};
results_exp1(results_exp1.model_fit_lowpas > fit_thresh, "central_freq_lowpas") = {NaN};
results_exp1(results_exp1.model_fit_lowpas > fit_thresh, "r2_lowpas") = {NaN};
results_exp1(results_exp1.model_fit_lowpas > fit_thresh, "power_freq_lowpas") = {NaN};
results_exp1(results_exp1.model_fit_lowpas > fit_thresh, "modelfit_lowpas") = {NaN};
results_exp1(results_exp1.model_fit_lowpas > fit_thresh, "bandwith_freq_lowpas") = {NaN};



results_exp3(results_exp3.model_fit_highpas > fit_thresh, "aperiodic_highpas") = {NaN};
results_exp3(results_exp3.model_fit_highpas > fit_thresh, "fooof_highpas") = {NaN};
results_exp3(results_exp3.model_fit_highpas > fit_thresh, "spectra_highpas") = {NaN};
results_exp3(results_exp3.model_fit_highpas > fit_thresh, "difference_highpas") = {NaN};
results_exp3(results_exp3.model_fit_highpas > fit_thresh, "spectrum_flat_highpas") = {NaN};
results_exp3(results_exp3.model_fit_highpas > fit_thresh, "spectrum_peak_rm_highpas") = {NaN};
results_exp3(results_exp3.model_fit_highpas > fit_thresh, "exponent_highpas") = {NaN};
results_exp3(results_exp3.model_fit_highpas > fit_thresh, "offset_flat_highpas") = {NaN};
results_exp3(results_exp3.model_fit_highpas > fit_thresh, "central_freq_highpas") = {NaN};
results_exp3(results_exp3.model_fit_highpas > fit_thresh, "r2_highpas") = {NaN};
results_exp3(results_exp3.model_fit_highpas > fit_thresh, "power_freq_highpas") = {NaN};
results_exp3(results_exp3.model_fit_highpas > fit_thresh, "modelfit_highpas") = {NaN};
results_exp3(results_exp3.model_fit_highpas > fit_thresh, "bandwith_freq_highpas") = {NaN};

results_exp3(results_exp3.model_fit_lowpas > fit_thresh, "aperiodic_lowpas") = {NaN};
results_exp3(results_exp3.model_fit_lowpas > fit_thresh, "fooof_lowpas") = {NaN};
results_exp3(results_exp3.model_fit_lowpas > fit_thresh, "spectra_lowpas") = {NaN};
results_exp3(results_exp3.model_fit_lowpas > fit_thresh, "difference_lowpas") = {NaN};
results_exp3(results_exp3.model_fit_lowpas > fit_thresh, "spectrum_flat_lowpas") = {NaN};
results_exp3(results_exp3.model_fit_lowpas > fit_thresh, "spectrum_peak_rm_lowpas") = {NaN};
results_exp3(results_exp3.model_fit_lowpas > fit_thresh, "exponent_lowpas") = {NaN};
results_exp3(results_exp3.model_fit_lowpas > fit_thresh, "offset_flat_lowpas") = {NaN};
results_exp3(results_exp3.model_fit_lowpas > fit_thresh, "central_freq_lowpas") = {NaN};
results_exp3(results_exp3.model_fit_lowpas > fit_thresh, "r2_lowpas") = {NaN};
results_exp3(results_exp3.model_fit_lowpas > fit_thresh, "power_freq_lowpas") = {NaN};
results_exp3(results_exp3.model_fit_lowpas > fit_thresh, "modelfit_lowpas") = {NaN};
results_exp3(results_exp3.model_fit_lowpas > fit_thresh, "bandwith_freq_lowpas") = {NaN};



results_exp4(results_exp4.model_fit_highpas > fit_thresh, "aperiodic_highpas") = {NaN};
results_exp4(results_exp4.model_fit_highpas > fit_thresh, "fooof_highpas") = {NaN};
results_exp4(results_exp4.model_fit_highpas > fit_thresh, "spectra_highpas") = {NaN};
results_exp4(results_exp4.model_fit_highpas > fit_thresh, "difference_highpas") = {NaN};
results_exp4(results_exp4.model_fit_highpas > fit_thresh, "spectrum_flat_highpas") = {NaN};
results_exp4(results_exp4.model_fit_highpas > fit_thresh, "spectrum_peak_rm_highpas") = {NaN};
results_exp4(results_exp4.model_fit_highpas > fit_thresh, "exponent_highpas") = {NaN};
results_exp4(results_exp4.model_fit_highpas > fit_thresh, "offset_flat_highpas") = {NaN};
results_exp4(results_exp4.model_fit_highpas > fit_thresh, "central_freq_highpas") = {NaN};
results_exp4(results_exp4.model_fit_highpas > fit_thresh, "r2_highpas") = {NaN};
results_exp4(results_exp4.model_fit_highpas > fit_thresh, "power_freq_highpas") = {NaN};
results_exp4(results_exp4.model_fit_highpas > fit_thresh, "modelfit_highpas") = {NaN};
results_exp4(results_exp4.model_fit_highpas > fit_thresh, "bandwith_freq_highpas") = {NaN};

results_exp4(results_exp4.model_fit_lowpas > fit_thresh, "aperiodic_lowpas") = {NaN};
results_exp4(results_exp4.model_fit_lowpas > fit_thresh, "fooof_lowpas") = {NaN};
results_exp4(results_exp4.model_fit_lowpas > fit_thresh, "spectra_lowpas") = {NaN};
results_exp4(results_exp4.model_fit_lowpas > fit_thresh, "difference_lowpas") = {NaN};
results_exp4(results_exp4.model_fit_lowpas > fit_thresh, "spectrum_flat_lowpas") = {NaN};
results_exp4(results_exp4.model_fit_lowpas > fit_thresh, "spectrum_peak_rm_lowpas") = {NaN};
results_exp4(results_exp4.model_fit_lowpas > fit_thresh, "exponent_lowpas") = {NaN};
results_exp4(results_exp4.model_fit_lowpas > fit_thresh, "offset_flat_lowpas") = {NaN};
results_exp4(results_exp4.model_fit_lowpas > fit_thresh, "central_freq_lowpas") = {NaN};
results_exp4(results_exp4.model_fit_lowpas > fit_thresh, "r2_lowpas") = {NaN};
results_exp4(results_exp4.model_fit_lowpas > fit_thresh, "power_freq_lowpas") = {NaN};
results_exp4(results_exp4.model_fit_lowpas > fit_thresh, "modelfit_lowpas") = {NaN};
results_exp4(results_exp4.model_fit_lowpas > fit_thresh, "bandwith_freq_lowpas") = {NaN};


results_exp5_bgr(results_exp5_bgr.model_fit_highpas > fit_thresh, "aperiodic_highpas") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_highpas > fit_thresh, "fooof_highpas") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_highpas > fit_thresh, "spectra_highpas") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_highpas > fit_thresh, "difference_highpas") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_highpas > fit_thresh, "spectrum_flat_highpas") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_highpas > fit_thresh, "spectrum_peak_rm_highpas") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_highpas > fit_thresh, "exponent_highpas") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_highpas > fit_thresh, "offset_flat_highpas") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_highpas > fit_thresh, "central_freq_highpas") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_highpas > fit_thresh, "r2_highpas") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_highpas > fit_thresh, "power_freq_highpas") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_highpas > fit_thresh, "modelfit_highpas") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_highpas > fit_thresh, "bandwith_freq_highpas") = {NaN};

results_exp5_bgr(results_exp5_bgr.model_fit_lowpas > fit_thresh, "aperiodic_lowpas") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_lowpas > fit_thresh, "fooof_lowpas") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_lowpas > fit_thresh, "spectra_lowpas") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_lowpas > fit_thresh, "difference_lowpas") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_lowpas > fit_thresh, "spectrum_flat_lowpas") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_lowpas > fit_thresh, "spectrum_peak_rm_lowpas") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_lowpas > fit_thresh, "exponent_lowpas") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_lowpas > fit_thresh, "offset_flat_lowpas") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_lowpas > fit_thresh, "central_freq_lowpas") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_lowpas > fit_thresh, "r2_lowpas") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_lowpas > fit_thresh, "power_freq_lowpas") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_lowpas > fit_thresh, "modelfit_lowpas") = {NaN};
results_exp5_bgr(results_exp5_bgr.model_fit_lowpas > fit_thresh, "bandwith_freq_lowpas") = {NaN};




results_exp5_obj(results_exp5_obj.model_fit_highpas > fit_thresh, "aperiodic_highpas") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_highpas > fit_thresh, "fooof_highpas") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_highpas > fit_thresh, "spectra_highpas") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_highpas > fit_thresh, "difference_highpas") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_highpas > fit_thresh, "spectrum_flat_highpas") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_highpas > fit_thresh, "spectrum_peak_rm_highpas") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_highpas > fit_thresh, "exponent_highpas") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_highpas > fit_thresh, "offset_flat_highpas") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_highpas > fit_thresh, "central_freq_highpas") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_highpas > fit_thresh, "r2_highpas") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_highpas > fit_thresh, "power_freq_highpas") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_highpas > fit_thresh, "modelfit_highpas") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_highpas > fit_thresh, "bandwith_freq_highpas") = {NaN};

results_exp5_obj(results_exp5_obj.model_fit_lowpas > fit_thresh, "aperiodic_lowpas") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_lowpas > fit_thresh, "fooof_lowpas") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_lowpas > fit_thresh, "spectra_lowpas") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_lowpas > fit_thresh, "difference_lowpas") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_lowpas > fit_thresh, "spectrum_flat_lowpas") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_lowpas > fit_thresh, "spectrum_peak_rm_lowpas") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_lowpas > fit_thresh, "exponent_lowpas") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_lowpas > fit_thresh, "offset_flat_lowpas") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_lowpas > fit_thresh, "central_freq_lowpas") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_lowpas > fit_thresh, "r2_lowpas") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_lowpas > fit_thresh, "power_freq_lowpas") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_lowpas > fit_thresh, "modelfit_lowpas") = {NaN};
results_exp5_obj(results_exp5_obj.model_fit_lowpas > fit_thresh, "bandwith_freq_lowpas") = {NaN};


%temp1 = results_exp1;
results_exp1(isnan(results_exp1.aperiodic_highpas), :) = [];
results_exp1(isnan(results_exp1.aperiodic_lowpas), :) = [];
results_exp1(isnan(results_exp1.spectra_highpas), :) = [];
results_exp1(isnan(results_exp1.spectra_lowpas), :) = [];
results_exp1(isnan(results_exp1.difference_highpas), :) = [];
results_exp1(isnan(results_exp1.difference_lowpas), :) = [];
results_exp1(isnan(results_exp1.spectrum_flat_highpas), :) = [];
results_exp1(isnan(results_exp1.spectrum_flat_lowpas), :) = [];
results_exp1(isnan(results_exp1.spectrum_peak_rm_highpas), :) = [];
results_exp1(isnan(results_exp1.spectrum_peak_rm_lowpas), :) = [];
results_exp1(isnan(results_exp1.exponent_highpas), :) = [];
results_exp1(isnan(results_exp1.exponent_lowpas), :) = [];
results_exp1(isnan(results_exp1.offset_flat_highpas), :) = [];
results_exp1(isnan(results_exp1.offset_flat_lowpas), :) = [];
results_exp1(isnan(results_exp1.central_freq_highpas), :) = [];
results_exp1(isnan(results_exp1.central_freq_lowpas), :) = [];
results_exp1(isnan(results_exp1.power_freq_highpas), :) = [];
results_exp1(isnan(results_exp1.power_freq_lowpas), :) = [];
results_exp1(isnan(results_exp1.bandwith_freq_highpas), :) = [];
results_exp1(isnan(results_exp1.modelfit_lowpas), :) = [];


results_exp3(isnan(results_exp3.aperiodic_highpas), :) = [];
results_exp3(isnan(results_exp3.aperiodic_lowpas), :) = [];
results_exp3(isnan(results_exp3.spectra_highpas), :) = [];
results_exp3(isnan(results_exp3.spectra_lowpas), :) = [];
results_exp3(isnan(results_exp3.difference_highpas), :) = [];
results_exp3(isnan(results_exp3.difference_lowpas), :) = [];
results_exp3(isnan(results_exp3.spectrum_flat_highpas), :) = [];
results_exp3(isnan(results_exp3.spectrum_flat_lowpas), :) = [];
results_exp3(isnan(results_exp3.spectrum_peak_rm_highpas), :) = [];
results_exp3(isnan(results_exp3.spectrum_peak_rm_lowpas), :) = [];
results_exp3(isnan(results_exp3.exponent_highpas), :) = [];
results_exp3(isnan(results_exp3.exponent_lowpas), :) = [];
results_exp3(isnan(results_exp3.offset_flat_highpas), :) = [];
results_exp3(isnan(results_exp3.offset_flat_lowpas), :) = [];
results_exp3(isnan(results_exp3.central_freq_highpas), :) = [];
results_exp3(isnan(results_exp3.central_freq_lowpas), :) = [];
results_exp3(isnan(results_exp3.power_freq_highpas), :) = [];
results_exp3(isnan(results_exp3.power_freq_lowpas), :) = [];
results_exp3(isnan(results_exp3.bandwith_freq_highpas), :) = [];
results_exp3(isnan(results_exp3.modelfit_lowpas), :) = [];



results_exp4(isnan(results_exp4.aperiodic_highpas), :) = [];
results_exp4(isnan(results_exp4.aperiodic_lowpas), :) = [];
results_exp4(isnan(results_exp4.spectra_highpas), :) = [];
results_exp4(isnan(results_exp4.spectra_lowpas), :) = [];
results_exp4(isnan(results_exp4.difference_highpas), :) = [];
results_exp4(isnan(results_exp4.difference_lowpas), :) = [];
results_exp4(isnan(results_exp4.spectrum_flat_highpas), :) = [];
results_exp4(isnan(results_exp4.spectrum_flat_lowpas), :) = [];
results_exp4(isnan(results_exp4.spectrum_peak_rm_highpas), :) = [];
results_exp4(isnan(results_exp4.spectrum_peak_rm_lowpas), :) = [];
results_exp4(isnan(results_exp4.exponent_highpas), :) = [];
results_exp4(isnan(results_exp4.exponent_lowpas), :) = [];
results_exp4(isnan(results_exp4.offset_flat_highpas), :) = [];
results_exp4(isnan(results_exp4.offset_flat_lowpas), :) = [];
results_exp4(isnan(results_exp4.central_freq_highpas), :) = [];
results_exp4(isnan(results_exp4.central_freq_lowpas), :) = [];
results_exp4(isnan(results_exp4.power_freq_highpas), :) = [];
results_exp4(isnan(results_exp4.power_freq_lowpas), :) = [];
results_exp4(isnan(results_exp4.bandwith_freq_highpas), :) = [];
results_exp4(isnan(results_exp4.modelfit_lowpas), :) = [];

results_exp5_bgr(isnan(results_exp5_bgr.aperiodic_highpas), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.aperiodic_lowpas), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.spectra_highpas), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.spectra_lowpas), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.difference_highpas), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.difference_lowpas), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.spectrum_flat_highpas), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.spectrum_flat_lowpas), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.spectrum_peak_rm_highpas), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.spectrum_peak_rm_lowpas), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.exponent_highpas), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.exponent_lowpas), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.offset_flat_highpas), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.offset_flat_lowpas), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.central_freq_highpas), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.central_freq_lowpas), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.power_freq_highpas), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.power_freq_lowpas), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.bandwith_freq_highpas), :) = [];
results_exp5_bgr(isnan(results_exp5_bgr.modelfit_lowpas), :) = [];

results_exp5_obj(isnan(results_exp5_obj.aperiodic_highpas), :) = [];
results_exp5_obj(isnan(results_exp5_obj.aperiodic_lowpas), :) = [];
results_exp5_obj(isnan(results_exp5_obj.spectra_highpas), :) = [];
results_exp5_obj(isnan(results_exp5_obj.spectra_lowpas), :) = [];
results_exp5_obj(isnan(results_exp5_obj.difference_highpas), :) = [];
results_exp5_obj(isnan(results_exp5_obj.difference_lowpas), :) = [];
results_exp5_obj(isnan(results_exp5_obj.spectrum_flat_highpas), :) = [];
results_exp5_obj(isnan(results_exp5_obj.spectrum_flat_lowpas), :) = [];
results_exp5_obj(isnan(results_exp5_obj.spectrum_peak_rm_highpas), :) = [];
results_exp5_obj(isnan(results_exp5_obj.spectrum_peak_rm_lowpas), :) = [];
results_exp5_obj(isnan(results_exp5_obj.exponent_highpas), :) = [];
results_exp5_obj(isnan(results_exp5_obj.exponent_lowpas), :) = [];
results_exp5_obj(isnan(results_exp5_obj.offset_flat_highpas), :) = [];
results_exp5_obj(isnan(results_exp5_obj.offset_flat_lowpas), :) = [];
results_exp5_obj(isnan(results_exp5_obj.central_freq_highpas), :) = [];
results_exp5_obj(isnan(results_exp5_obj.central_freq_lowpas), :) = [];
results_exp5_obj(isnan(results_exp5_obj.power_freq_highpas), :) = [];
results_exp5_obj(isnan(results_exp5_obj.power_freq_lowpas), :) = [];
results_exp5_obj(isnan(results_exp5_obj.bandwith_freq_highpas), :) = [];
results_exp5_obj(isnan(results_exp5_obj.modelfit_lowpas), :) = [];

writetable((results_exp1), 'D:\FOOOF results\exp1_corrected_subjective.csv')
writetable((results_exp3), 'D:\FOOOF results\exp3_corrected_subjective.csv')
writetable((results_exp4), 'D:\FOOOF results\exp4_corrected_subjective.csv')
writetable((results_exp5_bgr), 'D:\FOOOF results\exp5_bgr_corrected_subjective.csv')
writetable((results_exp5_obj), 'D:\FOOOF results\exp5_obj_corrected_subjective.csv')

figure;


labels = {'EXP 1 - Threshold'; ''; 'EXP 2 - Mask'; ''; 'EXP 3 - Faces';''; 'EXP 4.1 - Background'; ''; 'EXP 4.2 - Object'; '';}

subplot(2,3,1)
hold on



scatter(1, squeeze(mean(results_exp1.difference_lowpas, 'omitnan')), "red")
errorbar(1, squeeze(mean(results_exp1.difference_lowpas, 'omitnan')),semNAN(results_exp1.difference_lowpas) , "red")
scatter(2, squeeze(mean(results_exp1.difference_highpas, 'omitnan')), "blue")
errorbar(2, squeeze(mean(results_exp1.difference_highpas, 'omitnan')),semNAN(results_exp1.difference_highpas), "blue")

scatter(3, squeeze(mean(results_exp3.difference_lowpas, 'omitnan')), "red")
errorbar(3, squeeze(mean(results_exp3.difference_lowpas, 'omitnan')),semNAN(results_exp3.difference_lowpas), "red")
scatter(4, squeeze(mean(results_exp3.difference_highpas, 'omitnan')), "blue")
errorbar(4, squeeze(mean(results_exp3.difference_highpas, 'omitnan')),semNAN(results_exp3.difference_highpas), "blue")
if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.difference_lowpas, 'omitnan')), "red")
    errorbar(5, squeeze(mean(results_exp4.difference_lowpas, 'omitnan')),semNAN(results_exp4.difference_lowpas), "red")
    scatter(6, squeeze(mean(results_exp4.difference_highpas, 'omitnan')), "blue")
    errorbar(6, squeeze(mean(results_exp4.difference_highpas, 'omitnan')),semNAN(results_exp4.difference_highpas), "blue")


    scatter(7, squeeze(mean(results_exp5_obj.difference_lowpas, 'omitnan')), "red")
    errorbar(7, squeeze(mean(results_exp5_obj.difference_lowpas, 'omitnan')),semNAN(results_exp5_obj.difference_lowpas), "red")
    scatter(8, squeeze(mean(results_exp5_obj.difference_highpas, 'omitnan')), "blue")
    errorbar(8, squeeze(mean(results_exp5_obj.difference_highpas, 'omitnan')),semNAN(results_exp5_obj.difference_highpas), "blue")


    scatter(9, squeeze(mean(results_exp5_bgr.difference_lowpas, 'omitnan')), "red")
    errorbar(9, squeeze(mean(results_exp5_bgr.difference_lowpas, 'omitnan')),semNAN(results_exp5_bgr.difference_lowpas), "red")
    scatter(10, squeeze(mean(results_exp5_bgr.difference_highpas, 'omitnan')), "blue")
    errorbar(10, squeeze(mean(results_exp5_bgr.difference_highpas, 'omitnan')),semNAN(results_exp5_bgr.difference_highpas), "blue")
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.difference_highpas, 'omitnan') mean(results_exp1.difference_lowpas, 'omitnan') mean(results_exp3.difference_highpas, 'omitnan') mean(results_exp3.difference_lowpas, 'omitnan') mean(results_exp4.difference_highpas, 'omitnan') mean(results_exp4.difference_lowpas, 'omitnan')  mean(results_exp5_obj.difference_highpas, 'omitnan') mean(results_exp5_obj.difference_lowpas, 'omitnan')  mean(results_exp5_bgr.difference_highpas, 'omitnan') mean(results_exp5_bgr.difference_lowpas, 'omitnan')]));
    ylim_max = max(max([mean(results_exp1.difference_highpas, 'omitnan') mean(results_exp1.difference_lowpas, 'omitnan') mean(results_exp3.difference_highpas, 'omitnan') mean(results_exp3.difference_lowpas, 'omitnan') mean(results_exp4.difference_highpas, 'omitnan') mean(results_exp4.difference_lowpas, 'omitnan') mean(results_exp5_obj.difference_highpas, 'omitnan') mean(results_exp5_obj.difference_lowpas, 'omitnan')  mean(results_exp5_bgr.difference_highpas, 'omitnan') mean(results_exp5_bgr.difference_lowpas, 'omitnan')]));
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
ylim_min = min(min([mean(results_exp1.difference_highpas, 'omitnan') mean(results_exp1.difference_lowpas, 'omitnan') mean(results_exp3.difference_highpas, 'omitnan') mean(results_exp3.difference_lowpas, 'omitnan')]));
ylim_max = max(max([mean(results_exp1.difference_highpas, 'omitnan') mean(results_exp1.difference_lowpas, 'omitnan') mean(results_exp3.difference_highpas, 'omitnan') mean(results_exp3.difference_lowpas, 'omitnan')]));
ylim([ylim_min-(abs(ylim_min)*1) ylim_max+(abs(ylim_max)*0.3)])
end

xlabel(' ')
if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'Low PAS'; 'High PAS';'Low PAS'; 'High PAS'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6, 7, 8, 9, 10])
%label_pas = {'Low PAS';'High PAS'; 'Low PAS'; 'High PAS'; 'Low PAS'; 'High PAS'; ' Obj Incorrect'; ' Obj Correct'; ' Bgr Incorrect'; ' Bgr Correct';}
%xticklabels(label_pas)
xticklabels(labels)
xline(2.5)
xline(4.5)
xline(6.5)
xline(8.5)
xlim([0 11])
end
title('Adjusted power')
hold off;




subplot(2,3,2)
hold on
scatter(2, squeeze(mean(results_exp1.central_freq_highpas,'omitnan')), "blue")
errorbar(2, squeeze(mean(results_exp1.central_freq_highpas, 'omitnan')), semNAN(results_exp1.central_freq_highpas), "blue")
scatter(1, squeeze(mean(results_exp1.central_freq_lowpas, 'omitnan')), "red")
errorbar(1, squeeze(mean(results_exp1.central_freq_lowpas, 'omitnan')),semNAN(results_exp1.central_freq_lowpas), "red")

scatter(4, squeeze(mean(results_exp3.central_freq_highpas,'omitnan')), "blue")
errorbar(4, squeeze(mean(results_exp3.central_freq_highpas, 'omitnan')), semNAN(results_exp3.central_freq_highpas), "blue")
scatter(3, squeeze(mean(results_exp3.central_freq_lowpas, 'omitnan')), "red")
errorbar(3, squeeze(mean(results_exp3.central_freq_lowpas, 'omitnan')), semNAN(results_exp3.central_freq_lowpas), "red")

if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.central_freq_lowpas,'omitnan')), "red")
    errorbar(5, squeeze(mean(results_exp4.central_freq_lowpas, 'omitnan')), semNAN(results_exp4.central_freq_lowpas), "red")
    scatter(6, squeeze(mean(results_exp4.central_freq_highpas,'omitnan')), "blue")
    errorbar(6, squeeze(mean(results_exp4.central_freq_highpas, 'omitnan')), semNAN(results_exp4.central_freq_highpas), "blue")


    scatter(7, squeeze(mean(results_exp5_obj.central_freq_lowpas,'omitnan')), "red")
    errorbar(7, squeeze(mean(results_exp5_obj.central_freq_lowpas, 'omitnan')), semNAN(results_exp5_obj.central_freq_lowpas), "red")
    scatter(8, squeeze(mean(results_exp5_obj.central_freq_highpas,'omitnan')), "blue")
    errorbar(8, squeeze(mean(results_exp5_obj.central_freq_highpas, 'omitnan')), semNAN(results_exp5_obj.central_freq_highpas), "blue")


    scatter(9, squeeze(mean(results_exp5_bgr.central_freq_lowpas,'omitnan')), "red")
    errorbar(9, squeeze(mean(results_exp5_bgr.central_freq_lowpas, 'omitnan')), semNAN(results_exp5_bgr.central_freq_lowpas), "red")
    scatter(10, squeeze(mean(results_exp5_bgr.central_freq_highpas,'omitnan')), "blue")
    errorbar(10, squeeze(mean(results_exp5_bgr.central_freq_highpas, 'omitnan')), semNAN(results_exp5_bgr.central_freq_highpas), "blue")
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.central_freq_highpas,'omitnan') mean(results_exp1.central_freq_lowpas,'omitnan') mean(results_exp3.central_freq_highpas,'omitnan') mean(results_exp3.central_freq_lowpas,'omitnan') mean(results_exp4.central_freq_highpas,'omitnan') mean(results_exp4.central_freq_lowpas)  mean(results_exp5_obj.central_freq_highpas,'omitnan') mean(results_exp5_obj.central_freq_lowpas)  mean(results_exp5_bgr.central_freq_highpas,'omitnan') mean(results_exp5_bgr.central_freq_lowpas,'omitnan')]));
    ylim_max = max(max([mean(results_exp1.central_freq_highpas,'omitnan') mean(results_exp1.central_freq_lowpas,'omitnan') mean(results_exp3.central_freq_highpas,'omitnan') mean(results_exp3.central_freq_lowpas,'omitnan') mean(results_exp4.central_freq_highpas,'omitnan') mean(results_exp4.central_freq_lowpas)  mean(results_exp5_obj.central_freq_highpas,'omitnan') mean(results_exp5_obj.central_freq_lowpas)  mean(results_exp5_bgr.central_freq_highpas,'omitnan') mean(results_exp5_bgr.central_freq_lowpas,'omitnan')]));
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
    ylim_min = min(min([mean(results_exp1.central_freq_highpas,'omitnan') mean(results_exp1.central_freq_lowpas,'omitnan') mean(results_exp3.central_freq_highpas,'omitnan') mean(results_exp3.central_freq_lowpas,'omitnan')]));
    ylim_max = max(max([mean(results_exp1.central_freq_highpas,'omitnan') mean(results_exp1.central_freq_lowpas,'omitnan') mean(results_exp3.central_freq_highpas,'omitnan') mean(results_exp3.central_freq_lowpas,'omitnan')]))
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
xlabel(' ')
if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'Low PAS'; 'High PAS';'Low PAS'; 'High PAS'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6, 7, 8, 9, 10])
%label_pas = {'Low PAS';'High PAS'; 'Low PAS'; 'High PAS'; 'Low PAS'; 'High PAS'; ' Obj Incorrect'; ' Obj Correct'; ' Bgr Incorrect'; ' Bgr Correct';}
%xticklabels(label_pas)
xticklabels(labels)
xline(2.5)
xline(4.5)
xline(6.5)
xline(8.5)
xlim([0 11])
end
title('Central Frequency')
hold off;



subplot(2,3,3)
hold on
scatter(2, squeeze(mean(results_exp1.bandwith_freq_highpas,'omitnan')), "blue")
errorbar(2, squeeze(mean(results_exp1.bandwith_freq_highpas, 'omitnan')), semNAN(results_exp1.bandwith_freq_highpas), "blue")
scatter(1, squeeze(mean(results_exp1.bandwith_freq_lowpas,'omitnan')), "red")
errorbar(1, squeeze(mean(results_exp1.bandwith_freq_lowpas, 'omitnan')), semNAN(results_exp1.bandwith_freq_lowpas), "red")

scatter(4, squeeze(mean(results_exp3.bandwith_freq_highpas,'omitnan')), "blue")
errorbar(4, squeeze(mean(results_exp3.bandwith_freq_highpas, 'omitnan')), semNAN(results_exp3.bandwith_freq_highpas), "blue")
scatter(3, squeeze(mean(results_exp3.bandwith_freq_lowpas,'omitnan')), "red")
errorbar(3, squeeze(mean(results_exp3.bandwith_freq_lowpas, 'omitnan')), semNAN(results_exp3.bandwith_freq_lowpas), "red")


if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.bandwith_freq_lowpas,'omitnan')), "red")
    errorbar(5, squeeze(mean(results_exp4.bandwith_freq_lowpas, 'omitnan')), semNAN(results_exp4.bandwith_freq_lowpas), "red")
    scatter(6, squeeze(mean(results_exp4.bandwith_freq_highpas,'omitnan')), "blue")
    errorbar(6, squeeze(mean(results_exp4.bandwith_freq_highpas, 'omitnan')), semNAN(results_exp4.bandwith_freq_highpas), "blue")


    scatter(7, squeeze(mean(results_exp5_obj.bandwith_freq_lowpas,'omitnan')), "red")
    errorbar(7, squeeze(mean(results_exp5_obj.bandwith_freq_lowpas, 'omitnan')), semNAN(results_exp5_obj.bandwith_freq_lowpas), "red")
    scatter(8, squeeze(mean(results_exp5_obj.bandwith_freq_highpas,'omitnan')), "blue")
    errorbar(8, squeeze(mean(results_exp5_obj.bandwith_freq_highpas, 'omitnan')), semNAN(results_exp5_obj.bandwith_freq_highpas), "blue")


    scatter(9, squeeze(mean(results_exp5_bgr.bandwith_freq_lowpas,'omitnan')), "red")
    errorbar(9, squeeze(mean(results_exp5_bgr.bandwith_freq_lowpas, 'omitnan')), semNAN(results_exp5_bgr.bandwith_freq_lowpas), "red")
    scatter(10, squeeze(mean(results_exp5_bgr.bandwith_freq_highpas,'omitnan')), "blue")
    errorbar(10, squeeze(mean(results_exp5_bgr.bandwith_freq_highpas, 'omitnan')), semNAN(results_exp5_bgr.bandwith_freq_highpas), "blue")
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.bandwith_freq_highpas,'omitnan') mean(results_exp1.bandwith_freq_lowpas,'omitnan') mean(results_exp3.bandwith_freq_highpas,'omitnan') mean(results_exp3.bandwith_freq_lowpas,'omitnan') mean(results_exp4.bandwith_freq_highpas,'omitnan') mean(results_exp4.bandwith_freq_lowpas)  mean(results_exp5_obj.bandwith_freq_highpas,'omitnan') mean(results_exp5_obj.bandwith_freq_lowpas)  mean(results_exp5_bgr.bandwith_freq_highpas,'omitnan') mean(results_exp5_bgr.bandwith_freq_lowpas,'omitnan')]));
    ylim_max = max(max([mean(results_exp1.bandwith_freq_highpas,'omitnan') mean(results_exp1.bandwith_freq_lowpas,'omitnan') mean(results_exp3.bandwith_freq_highpas,'omitnan') mean(results_exp3.bandwith_freq_lowpas,'omitnan') mean(results_exp4.bandwith_freq_highpas,'omitnan') mean(results_exp4.bandwith_freq_lowpas)  mean(results_exp5_obj.bandwith_freq_highpas,'omitnan') mean(results_exp5_obj.bandwith_freq_lowpas)  mean(results_exp5_bgr.bandwith_freq_highpas,'omitnan') mean(results_exp5_bgr.bandwith_freq_lowpas,'omitnan')]));
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
    ylim_min = min(min([mean(results_exp1.bandwith_freq_highpas,'omitnan') mean(results_exp1.bandwith_freq_lowpas,'omitnan') mean(results_exp3.bandwith_freq_highpas,'omitnan') mean(results_exp3.bandwith_freq_lowpas,'omitnan')]));
    ylim_max = max(max([mean(results_exp1.bandwith_freq_highpas,'omitnan') mean(results_exp1.bandwith_freq_lowpas,'omitnan') mean(results_exp3.bandwith_freq_highpas,'omitnan') mean(results_exp3.bandwith_freq_lowpas,'omitnan')]))
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end

xlabel(' ')

if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'Low PAS'; 'High PAS';'Low PAS'; 'High PAS'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6, 7, 8, 9, 10])
%label_pas = {'Low PAS';'High PAS'; 'Low PAS'; 'High PAS'; 'Low PAS'; 'High PAS'; ' Obj Incorrect'; ' Obj Correct'; ' Bgr Incorrect'; ' Bgr Correct';}
%xticklabels(label_pas)
xticklabels(labels)
xline(2.5)
xline(4.5)
xline(6.5)
xline(8.5)
xlim([0 11])
end
title('Bandwith')
hold off;







hold on; 
subplot(2,3,4)
hold on;
scatter(1, squeeze(mean(results_exp1.aperiodic_lowpas,'omitnan')), "red")
errorbar(1, squeeze(mean(results_exp1.aperiodic_lowpas, 'omitnan')), semNAN(results_exp1.aperiodic_lowpas), "red")
scatter(2, squeeze(mean(results_exp1.aperiodic_highpas,'omitnan')), "blue")
errorbar(2, squeeze(mean(results_exp1.aperiodic_highpas, 'omitnan')), semNAN(results_exp1.aperiodic_highpas), "blue")

scatter(3, squeeze(mean(results_exp3.aperiodic_lowpas,'omitnan')), "red")
errorbar(3, squeeze(mean(results_exp3.aperiodic_lowpas, 'omitnan')), semNAN(results_exp3.aperiodic_lowpas), "red")
scatter(4, squeeze(mean(results_exp3.aperiodic_highpas,'omitnan')), "blue")
errorbar(4, squeeze(mean(results_exp3.aperiodic_highpas, 'omitnan')), semNAN(results_exp3.aperiodic_highpas), "blue")

if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.aperiodic_lowpas,'omitnan')), "red")
    errorbar(5, squeeze(mean(results_exp4.aperiodic_lowpas, 'omitnan')), semNAN(results_exp4.aperiodic_lowpas), "red")
    scatter(6, squeeze(mean(results_exp4.aperiodic_highpas,'omitnan')), "blue")
    errorbar(6, squeeze(mean(results_exp4.aperiodic_highpas, 'omitnan')), semNAN(results_exp4.aperiodic_highpas), "blue")


    scatter(7, squeeze(mean(results_exp5_obj.aperiodic_lowpas,'omitnan')), "red")
    errorbar(7, squeeze(mean(results_exp5_obj.aperiodic_lowpas, 'omitnan')), semNAN(results_exp5_obj.aperiodic_lowpas), "red")
    scatter(8, squeeze(mean(results_exp5_obj.aperiodic_highpas,'omitnan')), "blue")
    errorbar(8, squeeze(mean(results_exp5_obj.aperiodic_highpas, 'omitnan')), semNAN(results_exp5_obj.aperiodic_highpas), "blue")


    scatter(9, squeeze(mean(results_exp5_bgr.aperiodic_lowpas,'omitnan')), "red")
    errorbar(9, squeeze(mean(results_exp5_bgr.aperiodic_lowpas, 'omitnan')), semNAN(results_exp5_bgr.aperiodic_lowpas), "red")
    scatter(10, squeeze(mean(results_exp5_bgr.aperiodic_highpas,'omitnan')), "blue")
    errorbar(10, squeeze(mean(results_exp5_bgr.aperiodic_highpas, 'omitnan')), semNAN(results_exp5_bgr.aperiodic_highpas), "blue")
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.aperiodic_highpas,'omitnan') mean(results_exp1.aperiodic_lowpas,'omitnan') mean(results_exp3.aperiodic_highpas,'omitnan') mean(results_exp3.aperiodic_lowpas,'omitnan') mean(results_exp4.aperiodic_highpas,'omitnan') mean(results_exp4.aperiodic_lowpas,'omitnan') mean(results_exp5_obj.aperiodic_highpas,'omitnan') mean(results_exp5_obj.aperiodic_lowpas)  mean(results_exp5_bgr.aperiodic_highpas,'omitnan') mean(results_exp5_bgr.aperiodic_lowpas,'omitnan')]));
    ylim_max = max(max([mean(results_exp1.aperiodic_highpas,'omitnan') mean(results_exp1.aperiodic_lowpas,'omitnan') mean(results_exp3.aperiodic_highpas,'omitnan') mean(results_exp3.aperiodic_lowpas,'omitnan') mean(results_exp4.aperiodic_highpas,'omitnan') mean(results_exp4.aperiodic_lowpas,'omitnan') mean(results_exp5_obj.aperiodic_highpas,'omitnan') mean(results_exp5_obj.aperiodic_lowpas)  mean(results_exp5_bgr.aperiodic_highpas,'omitnan') mean(results_exp5_bgr.aperiodic_lowpas,'omitnan')]));
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
    ylim_min = min(min([mean(results_exp1.aperiodic_highpas,'omitnan') mean(results_exp1.aperiodic_lowpas,'omitnan') mean(results_exp3.aperiodic_highpas,'omitnan') mean(results_exp3.aperiodic_lowpas,'omitnan')]));
    ylim_max = max(max([mean(results_exp1.aperiodic_highpas,'omitnan') mean(results_exp1.aperiodic_lowpas,'omitnan') mean(results_exp3.aperiodic_highpas,'omitnan') mean(results_exp3.aperiodic_lowpas,'omitnan')]))
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end

    xlabel(' ')

if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'Low PAS';'High PAS'; 'Low PAS'; 'High PAS';}
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6, 7, 8, 9, 10])
%label_pas = {'Low PAS';'High PAS'; 'Low PAS'; 'High PAS'; 'Low PAS'; 'High PAS'; ' Obj Incorrect'; ' Obj Correct'; ' Bgr Incorrect'; ' Bgr Correct';}
%xticklabels(label_pas)
xticklabels(labels)
xline(2.5)
xline(4.5)
xline(6.5)
xline(8.5)
xlim([0 11])
end

title('Aperiodic Activity')
hold off;


subplot(2,3,5)
hold on
scatter(2, squeeze(mean(results_exp1.exponent_highpas,'omitnan')), "blue")
errorbar(2, squeeze(mean(results_exp1.exponent_highpas, 'omitnan')), semNAN(results_exp1.exponent_highpas), "blue")
scatter(1, squeeze(mean(results_exp1.exponent_lowpas,'omitnan')), "red")
errorbar(1, squeeze(mean(results_exp1.exponent_lowpas, 'omitnan')), semNAN(results_exp1.exponent_lowpas), "red")

scatter(4, squeeze(mean(results_exp3.exponent_highpas,'omitnan')), "blue")
errorbar(4, squeeze(mean(results_exp3.exponent_highpas, 'omitnan')), semNAN(results_exp3.exponent_highpas), "blue")
scatter(3, squeeze(mean(results_exp3.exponent_lowpas,'omitnan')), "red")
errorbar(3, squeeze(mean(results_exp3.exponent_lowpas, 'omitnan')), semNAN(results_exp3.exponent_lowpas), "red")

if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.exponent_lowpas,'omitnan')), "red")
    errorbar(5, squeeze(mean(results_exp4.exponent_lowpas, 'omitnan')), semNAN(results_exp4.exponent_lowpas), "red")
    scatter(6, squeeze(mean(results_exp4.exponent_highpas,'omitnan')), "blue")
    errorbar(6, squeeze(mean(results_exp4.exponent_highpas, 'omitnan')), semNAN(results_exp4.exponent_highpas), "blue")


    scatter(7, squeeze(mean(results_exp5_obj.exponent_lowpas,'omitnan')), "red")
    errorbar(7, squeeze(mean(results_exp5_obj.exponent_lowpas, 'omitnan')), semNAN(results_exp5_obj.exponent_lowpas), "red")
    scatter(8, squeeze(mean(results_exp5_obj.exponent_highpas,'omitnan')), "blue")
    errorbar(8, squeeze(mean(results_exp5_obj.exponent_highpas, 'omitnan')), semNAN(results_exp5_obj.exponent_highpas), "blue")


    scatter(9, squeeze(mean(results_exp5_bgr.exponent_lowpas,'omitnan')), "red")
    errorbar(9, squeeze(mean(results_exp5_bgr.exponent_lowpas, 'omitnan')), semNAN(results_exp5_bgr.exponent_lowpas), "red")
    scatter(10, squeeze(mean(results_exp5_bgr.exponent_highpas,'omitnan')), "blue")
    errorbar(10, squeeze(mean(results_exp5_bgr.exponent_highpas, 'omitnan')), semNAN(results_exp5_bgr.exponent_highpas), "blue")
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.exponent_highpas,'omitnan') mean(results_exp1.exponent_lowpas,'omitnan') mean(results_exp3.exponent_highpas,'omitnan') mean(results_exp3.exponent_lowpas,'omitnan') mean(results_exp4.exponent_highpas,'omitnan') mean(results_exp4.exponent_lowpas,'omitnan') mean(results_exp5_obj.exponent_highpas,'omitnan') mean(results_exp5_obj.exponent_lowpas)  mean(results_exp5_bgr.exponent_highpas,'omitnan') mean(results_exp5_bgr.exponent_lowpas,'omitnan')]));
    ylim_max = max(max([mean(results_exp1.exponent_highpas,'omitnan') mean(results_exp1.exponent_lowpas,'omitnan') mean(results_exp3.exponent_highpas,'omitnan') mean(results_exp3.exponent_lowpas,'omitnan') mean(results_exp4.exponent_highpas,'omitnan') mean(results_exp4.exponent_lowpas,'omitnan') mean(results_exp5_obj.exponent_highpas,'omitnan') mean(results_exp5_obj.exponent_lowpas)  mean(results_exp5_bgr.exponent_highpas,'omitnan') mean(results_exp5_bgr.exponent_lowpas,'omitnan')]));
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
ylim_min = min(min([mean(results_exp1.exponent_highpas,'omitnan') mean(results_exp1.exponent_lowpas,'omitnan') mean(results_exp3.exponent_highpas,'omitnan') mean(results_exp3.exponent_lowpas,'omitnan')]));
ylim_max = max(max([mean(results_exp1.exponent_highpas,'omitnan') mean(results_exp1.exponent_lowpas,'omitnan') mean(results_exp3.exponent_highpas,'omitnan') mean(results_exp3.exponent_lowpas,'omitnan')]));
ylim([ylim_min-(abs(ylim_min)*1) ylim_max+(abs(ylim_max)*0.3)])
end
xlabel(' ')
if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'Low PAS'; 'High PAS';'Low PAS'; 'High PAS'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6, 7, 8, 9, 10])
%label_pas = {'Low PAS';'High PAS'; 'Low PAS'; 'High PAS'; 'Low PAS'; 'High PAS'; ' Obj Incorrect'; ' Obj Correct'; ' Bgr Incorrect'; ' Bgr Correct';}
%xticklabels(label_pas)
xticklabels(labels)
xline(2.5)
xline(4.5)
xline(6.5)
xline(8.5)
xlim([0 11])
end
title('Exponent')
hold off;

subplot(2,3,6)
hold on
scatter(2, squeeze(mean(results_exp1.offset_flat_highpas,'omitnan')), "blue")
errorbar(2, squeeze(mean(results_exp1.offset_flat_highpas, 'omitnan')), semNAN(results_exp1.offset_flat_highpas), "blue")
scatter(1, squeeze(mean(results_exp1.offset_flat_lowpas,'omitnan')), "red")
errorbar(1, squeeze(mean(results_exp1.offset_flat_lowpas, 'omitnan')), semNAN(results_exp1.offset_flat_lowpas), "red")

scatter(4, squeeze(mean(results_exp3.offset_flat_highpas,'omitnan')), "blue")
errorbar(4, squeeze(mean(results_exp3.offset_flat_highpas, 'omitnan')), semNAN(results_exp3.offset_flat_highpas), "blue")
scatter(3, squeeze(mean(results_exp3.offset_flat_lowpas,'omitnan')), "red")
errorbar(3, squeeze(mean(results_exp3.offset_flat_lowpas, 'omitnan')), semNAN(results_exp3.offset_flat_lowpas), "red")

if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.offset_flat_lowpas,'omitnan')), "red")
    errorbar(5, squeeze(mean(results_exp4.offset_flat_lowpas, 'omitnan')), semNAN(results_exp4.offset_flat_lowpas), "red")
    scatter(6, squeeze(mean(results_exp4.offset_flat_highpas,'omitnan')), "blue")
    errorbar(6, squeeze(mean(results_exp4.offset_flat_highpas, 'omitnan')), semNAN(results_exp4.offset_flat_highpas), "blue")


    scatter(7, squeeze(mean(results_exp5_obj.offset_flat_lowpas,'omitnan')), "red")
    errorbar(7, squeeze(mean(results_exp5_obj.offset_flat_lowpas, 'omitnan')), semNAN(results_exp5_obj.offset_flat_lowpas), "red")
    scatter(8, squeeze(mean(results_exp5_obj.offset_flat_highpas,'omitnan')), "blue")
    errorbar(8, squeeze(mean(results_exp5_obj.offset_flat_highpas, 'omitnan')), semNAN(results_exp5_obj.offset_flat_highpas), "blue")


    scatter(9, squeeze(mean(results_exp5_bgr.offset_flat_lowpas,'omitnan')), "red")
    errorbar(9, squeeze(mean(results_exp5_bgr.offset_flat_lowpas, 'omitnan')), semNAN(results_exp5_bgr.offset_flat_lowpas), "red")
    scatter(10, squeeze(mean(results_exp5_bgr.offset_flat_highpas,'omitnan')), "blue")
    errorbar(10, squeeze(mean(results_exp5_bgr.offset_flat_highpas, 'omitnan')), semNAN(results_exp5_bgr.offset_flat_highpas), "blue")
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.offset_flat_highpas,'omitnan') mean(results_exp1.offset_flat_lowpas,'omitnan') mean(results_exp3.offset_flat_highpas,'omitnan') mean(results_exp3.offset_flat_lowpas,'omitnan') mean(results_exp4.offset_flat_highpas,'omitnan') mean(results_exp4.offset_flat_lowpas,'omitnan') mean(results_exp5_obj.offset_flat_highpas,'omitnan') mean(results_exp5_obj.offset_flat_lowpas)  mean(results_exp5_bgr.offset_flat_highpas,'omitnan') mean(results_exp5_bgr.offset_flat_lowpas,'omitnan')]));
    ylim_max = max(max([mean(results_exp1.offset_flat_highpas,'omitnan') mean(results_exp1.offset_flat_lowpas,'omitnan') mean(results_exp3.offset_flat_highpas,'omitnan') mean(results_exp3.offset_flat_lowpas,'omitnan') mean(results_exp4.offset_flat_highpas,'omitnan') mean(results_exp4.offset_flat_lowpas,'omitnan') mean(results_exp5_obj.offset_flat_highpas,'omitnan') mean(results_exp5_obj.offset_flat_lowpas)  mean(results_exp5_bgr.offset_flat_highpas,'omitnan') mean(results_exp5_bgr.offset_flat_lowpas,'omitnan')]));
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
    ylim_min = min(min([mean(results_exp1.offset_flat_highpas,'omitnan') mean(results_exp1.offset_flat_lowpas,'omitnan') mean(results_exp3.offset_flat_highpas,'omitnan') mean(results_exp3.offset_flat_lowpas,'omitnan')]));
    ylim_max = max(max([mean(results_exp1.offset_flat_highpas,'omitnan') mean(results_exp1.offset_flat_lowpas,'omitnan') mean(results_exp3.offset_flat_highpas,'omitnan') mean(results_exp3.offset_flat_lowpas,'omitnan')]))
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end




xlabel(' ')
if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'Low PAS'; 'High PAS';'Low PAS'; 'High PAS'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6, 7, 8, 9, 10])
%label_pas = {'Low PAS';'High PAS'; 'Low PAS'; 'High PAS'; 'Low PAS'; 'High PAS'; ' Obj Incorrect'; ' Obj Correct'; ' Bgr Incorrect'; ' Bgr Correct';}
%xticklabels(label_pas)
xticklabels(labels)
xline(2.5)
xline(4.5)
xline(6.5)
xline(8.5)
xlim([0 11])
end
title('Offset')
hold off;
