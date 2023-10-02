# -*- coding: utf-8 -*-
"""
Created on Mon Feb 13 13:46:07 2023

@author: user
"""
import numpy as np
import scipy
from scipy.io import loadmat, savemat
import mat73
from fooof import FOOOF
import pandas as pd

# load .mat file with events for all participants
events = scipy.io.loadmat(r'D:\Drive\1 - Threshold\events_new2.mat')
freqs_dict = loadmat(r'D:\freqs_morlet.mat') #prestimulus part
events = events['events_new2']
freqs = np.squeeze(freqs_dict['freqs']).astype('float')

# list of selected channels
#selected_channels = [19, 32, 56, 20, 57, 31, 27, 29, 64, 25, 62, 26, 63]
# adjusted, matlab starts from 1, python from 0...
selected_channels = [18, 31, 55, 19, 56, 30, 26, 28, 63, 24, 61, 25, 62]
participants_to_drop = [4, 6, 26, 41, 42, 84, 105, 113, 121, 122];
# FOOOF settings
peaks = 5
lower_freqs = 6
upper_freqs = 20
min_peak_height = 0.0
peak_threshold= 2.0
aperiodic_mode = 'fixed'
threshold_to_drop = 0.1
peak_width_limits = (2.0, 7.0)

all_correct_peak_params = []
all_correct_aperiodic_fit = []
all_correct_FOOOF = []
all_correct_Power_spectrum = []
all_correct_aperiodic_params = []
all_correct_r2 = []
all_correct_error = []
all_correct_Gaussian_params = []
all_correct_Gaussian_overlap = []
all_correct_Spectrum_flat = []
all_correct_Spectrum_peak_rm = []
       
all_incorrect_peak_params = []
all_incorrect_aperiodic_fit = []
all_incorrect_FOOOF = []
all_incorrect_Power_spectrum = []
all_incorrect_aperiodic_params = []
all_incorrect_r2 = []
all_incorrect_error = []
all_incorrect_Gaussian_params = []
all_incorrect_Gaussian_overlap = []
all_incorrect_Spectrum_flat = []
all_incorrect_Spectrum_peak_rm = []

all_counter_corr = []
all_counter_incorr = []
all_percentages_correct = []
all_percentages_incorrect = []
counter_error_corr = []
counter_noterror_corr = [];
counter_error_inc = [];
counter_noterror_inc = [];
total_corr = 0
total_incorr = 0
# loop through each participant
for participant in range(events.shape[1]):
    if participant not in participants_to_drop:
        # load PSD data for each participant
        #mat_file = mat73.loadmat(rf"D:\Drive\1 - Threshold\pwelch\pwelch_participant_{participant+1}.mat")
        mat_file = scipy.io.loadmat(rf"D:\Drive\1 - Threshold\pwelch_fromMorlet\psd_{participant+1}.mat")
        psd_data = mat_file["psd_all"]
        
        # select data only for selected channels
        psd_data = psd_data[selected_channels, :, :]
        print(f'current participant: {participant}')
        # get correct and incorrect trial indices
        correct_trials = np.where(events[0, participant]['pas_resp'] ==  [2 or 3 or 4])
        incorrect_trials = np.where(events[0, participant]['pas_resp'] == 1) 
        total_corr = total_corr+len(correct_trials[1])
        total_incorr = total_incorr+len(incorrect_trials[1])
        
        
        correct_peak_params = []
        correct_aperiodic_fit = []
        correct_FOOOF = []
        correct_Power_spectrum = []
        correct_aperiodic_params = []
        correct_r2 = []
        correct_error = []
        correct_Gaussian_params = []
        correct_Gaussian_overlap = []
        correct_Spectrum_flat = []
        correct_Spectrum_peak_rm = []
           
        incorrect_peak_params = []
        incorrect_aperiodic_fit = []
        incorrect_FOOOF = []
        incorrect_Power_spectrum = []
        incorrect_aperiodic_params = []
        incorrect_r2 = []
        incorrect_error = []
        incorrect_Gaussian_params = []
        incorrect_Gaussian_overlap = []
        incorrect_Spectrum_flat = []
        incorrect_Spectrum_peak_rm = []
        
        # calculate average PSD for correct and incorrect trials for each channel
        #psd_correct = np.mean(np.mean(psd_data[:, :, correct_trials], axis=0), axis=0)
        #psd_incorrect = np.mean(np.mean(psd_data[:, :, incorrect_trials], axis=0), axis=0)
        psd_correct3 = np.mean(psd_data[:, :, correct_trials], axis=0)
        #psd_correct2 = np.mean(psd_correct3, axis=2)
        psd_correct = np.mean(psd_correct3, axis=1)
        psd_incorrect3 = np.mean(psd_data[:, :, incorrect_trials], axis=0)
        #psd_incorrect2 = np.mean(psd_incorrect3, axis=2)
        psd_incorrect = np.mean(psd_incorrect3, axis=1)
        
        counter_corr = 0;
        counter_incorr = 0;
        
        for trial in range(psd_correct.shape[1]):
            fm = FOOOF(peak_width_limits = peak_width_limits, max_n_peaks=peaks,  min_peak_height=min_peak_height, peak_threshold=peak_threshold, aperiodic_mode = aperiodic_mode);
            fm.fit(freqs, psd_correct[:, trial], [lower_freqs, upper_freqs])
            if fm.peak_params_.shape == (1, 3):
                correct_peak_params.append(fm.peak_params_)
                correct_aperiodic_fit.append(fm._ap_fit)
                correct_FOOOF.append(fm.fooofed_spectrum_) 
                correct_Power_spectrum.append(fm.power_spectrum) 
                correct_aperiodic_params.append(fm.aperiodic_params_)
                correct_r2.append(fm.r_squared_) 
                correct_error.append(fm.error_) 
                correct_Gaussian_params.append(fm.gaussian_params_)
                correct_Gaussian_overlap.append(fm._gauss_overlap_thresh)
                correct_Spectrum_flat.append(fm._spectrum_flat)
                correct_Spectrum_peak_rm.append(fm._spectrum_peak_rm)
                filtered_elements = [x for x in correct_error if x > 0.1]
                errors_corr = len(filtered_elements)
            else:
                counter_corr = counter_corr+1;
            
        for trial in range(psd_incorrect.shape[1]):
            fm = FOOOF(peak_width_limits = peak_width_limits, max_n_peaks=peaks,  min_peak_height=min_peak_height, peak_threshold=peak_threshold, aperiodic_mode = aperiodic_mode);
            fm.fit(freqs, psd_incorrect[:, trial], [lower_freqs, upper_freqs])
            if fm.peak_params_.shape == (1, 3):
                incorrect_peak_params.append(fm.peak_params_)
                incorrect_aperiodic_fit.append(fm._ap_fit)
                incorrect_FOOOF.append(fm.fooofed_spectrum_) 
                incorrect_Power_spectrum.append(fm.power_spectrum) 
                incorrect_aperiodic_params.append(fm.aperiodic_params_)
                incorrect_r2.append(fm.r_squared_) 
                incorrect_error.append(fm.error_) 
                incorrect_Gaussian_params.append(fm.gaussian_params_)
                incorrect_Gaussian_overlap.append(fm._gauss_overlap_thresh)
                incorrect_Spectrum_flat.append(fm._spectrum_flat)
                incorrect_Spectrum_peak_rm.append(fm._spectrum_peak_rm)
                filtered_elements = [x for x in incorrect_error if x > 0.1]
                errors_incorr = len(filtered_elements)
            else:
                counter_incorr = counter_incorr+1;
    
    
        counter_error_corr.append(errors_corr)
        counter_error_inc.append(errors_incorr)
        all_correct_peak_params.append(correct_peak_params)
        all_correct_aperiodic_fit.append(correct_aperiodic_fit)
        all_correct_FOOOF.append(correct_FOOOF)
        all_correct_Power_spectrum.append(correct_Power_spectrum)
        all_correct_aperiodic_params.append(correct_aperiodic_params)
        all_correct_r2.append(correct_r2)
        all_correct_error.append(correct_error)
        all_correct_Gaussian_params.append(correct_Gaussian_params)
        all_correct_Gaussian_overlap.append(correct_Gaussian_overlap)
        all_correct_Spectrum_flat.append(correct_Spectrum_flat)
        all_correct_Spectrum_peak_rm.append(correct_Spectrum_peak_rm)
               
        all_incorrect_peak_params.append(incorrect_peak_params)
        all_incorrect_aperiodic_fit.append(incorrect_aperiodic_fit)
        all_incorrect_FOOOF.append(incorrect_FOOOF)
        all_incorrect_Power_spectrum.append(incorrect_Power_spectrum)
        all_incorrect_aperiodic_params.append(incorrect_aperiodic_params)
        all_incorrect_r2.append(incorrect_r2)
        all_incorrect_error.append(incorrect_error)
        all_incorrect_Gaussian_params.append(incorrect_Gaussian_params)
        all_incorrect_Gaussian_overlap.append(incorrect_Gaussian_overlap)
        all_incorrect_Spectrum_flat.append(incorrect_Spectrum_flat)
        all_incorrect_Spectrum_peak_rm.append(incorrect_Spectrum_peak_rm)
     
        all_counter_corr.append(counter_corr)
        all_counter_incorr.append(counter_incorr)
        percent_correct = (counter_corr / psd_correct.shape[1]) * 100
        percent_incorrect =  (counter_incorr / psd_incorrect.shape[1]) * 100
        all_percentages_correct.append(percent_correct)
        all_percentages_incorrect.append(percent_incorrect)
     
correct = [all_correct_peak_params, all_correct_aperiodic_fit, all_correct_FOOOF,  all_correct_Power_spectrum, all_correct_aperiodic_params, 
           all_correct_r2, all_correct_error, all_correct_Gaussian_params, all_correct_Gaussian_overlap, all_correct_Spectrum_flat,
           all_correct_Spectrum_peak_rm]
incorrect = [all_incorrect_peak_params,  all_incorrect_aperiodic_fit, all_incorrect_FOOOF,all_incorrect_Power_spectrum,
             all_incorrect_aperiodic_params, all_incorrect_r2, all_incorrect_error, all_incorrect_Gaussian_params,
             all_incorrect_Gaussian_overlap, all_incorrect_Spectrum_flat, all_incorrect_Spectrum_peak_rm]
correct = np.array(correct, dtype=object)
incorrect = np.array(incorrect, dtype=object)
# save results back to .m file
scipy.io.savemat(r'D:\results_exp1_morlet_pas.mat', 
                 {'results_correct': correct,
                  'results_incorrect': incorrect})
    

percent = (sum(counter_error_corr) / total_corr) * 100;
std_dev = np.std(counter_error_corr)
average = np.average(counter_error_corr)
non_zero_count = np.count_nonzero(counter_error_corr)
non_zero_entries = np.array(counter_error_corr)[np.array(counter_error_corr) != 0]
min_value = np.min(non_zero_entries)
max_value = np.max(non_zero_entries)

output_sentence = (f"There were {percent: .2f}% of trials. The standard deviation is {std_dev:.2f}, the average is {average:.2f}, "
                   f"there are {non_zero_count} non-zero entries, and their range is min = {min_value:.2f}, max = {max_value:.2f}.")
print(output_sentence)

percent = (sum(counter_error_inc) / total_incorr) * 100;
std_dev = np.std(counter_error_inc)
average = np.average(counter_error_inc)
non_zero_count = np.count_nonzero(counter_error_inc)
non_zero_entries = np.array(counter_error_inc)[np.array(counter_error_inc) != 0]
min_value = np.min(non_zero_entries)
max_value = np.max(non_zero_entries)

output_sentence = (f"There were {percent: .2f}% of trials. The standard deviation is {std_dev:.2f}, the average is {average:.2f}, "
                   f"there are {non_zero_count} non-zero entries, and their range is min = {min_value:.2f}, max = {max_value:.2f}.")
print(output_sentence)



std_dev = np.std(all_percentages_correct)
average = np.average(all_percentages_correct)
non_zero_count = np.count_nonzero(all_percentages_correct)
non_zero_entries = np.array(all_percentages_correct)[np.array(all_percentages_correct) != 0]
min_value = np.min(non_zero_entries)
max_value = np.max(non_zero_entries)

output_sentence = (f"The standard deviation is {std_dev:.2f}, the average is {average:.2f}, "
                   f"there are {non_zero_count} non-zero entries, and their range is min = {min_value:.2f} %, max = {max_value:.2f} %.")
print(output_sentence)

std_dev = np.std(all_percentages_incorrect)
average = np.average(all_percentages_incorrect)
non_zero_count = np.count_nonzero(all_percentages_incorrect)
non_zero_entries = np.array(all_percentages_incorrect)[np.array(all_percentages_incorrect) != 0]
min_value = np.min(non_zero_entries)
max_value = np.max(non_zero_entries)

output_sentence = (f"The standard deviation is {std_dev:.2f}, the average is {average:.2f}, "
                   f"there are {non_zero_count} non-zero entries, and their range is min = {min_value:.2f} %, max = {max_value:.2f} %.")
print(output_sentence)



percent = (sum(all_counter_corr) / total_corr) * 100;
std_dev = np.std(all_counter_corr)
average = np.average(all_counter_corr)
non_zero_count = np.count_nonzero(all_counter_corr)
non_zero_entries = np.array(all_counter_corr)[np.array(all_counter_corr) != 0]
min_value = np.min(non_zero_entries)
max_value = np.max(non_zero_entries)

output_sentence = (f"NO PEAK: There were {percent: .2f}% of trials. The standard deviation is {std_dev:.2f}, the average is {average:.2f}, "
                   f"there are {non_zero_count} non-zero entries, and their range is min = {min_value:.2f}, max = {max_value:.2f}.")
print(output_sentence)

percent = (sum(all_counter_incorr) / total_corr) * 100;
std_dev = np.std(all_counter_incorr)
average = np.average(all_counter_incorr)
non_zero_count = np.count_nonzero(all_counter_incorr)
non_zero_entries = np.array(all_counter_incorr)[np.array(all_counter_incorr) != 0]
min_value = np.min(non_zero_entries)
max_value = np.max(non_zero_entries)

output_sentence = (f"NO PEAK: There were {percent: .2f}% of trials. The standard deviation is {std_dev:.2f}, the average is {average:.2f}, "
                   f"there are {non_zero_count} non-zero entries, and their range is min = {min_value:.2f}, max = {max_value:.2f}.")
print(output_sentence)