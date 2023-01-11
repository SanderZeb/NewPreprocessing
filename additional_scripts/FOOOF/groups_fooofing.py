# -*- coding: utf-8 -*-
"""
Created on Wed Oct 26 12:02:53 2022

@author: user
"""

import numpy as np
from scipy.io import loadmat, savemat
from fooof import FOOOF
from fooof import FOOOFGroup
from fooof.objs.utils import average_fg, combine_fooofs, compare_info
from fooof.bands import Bands
from fooof.analysis import get_band_peak_fm, get_band_peak_fg
from fooof.analysis.error import compute_pointwise_error_fm, compute_pointwise_error_fg
from fooof.plts.periodic import plot_peak_fits, plot_peak_params
from fooof.plts.aperiodic import plot_aperiodic_params, plot_aperiodic_fits
import mat73
import os
from os import listdir
from os.path import isfile, join
import re
import warnings
from fooof.bands import Bands
from fooof.plts.spectra import plot_spectra_shading

# root = r'D:\Drive\1 - Threshold'
#root = r'D:\Drive\3 - Mask'
# root = r'D:\Drive\4 - Faces'
root = r'D:\Drive\5 - Scenes'


bands = Bands({'delta' : [1, 4],
               'theta' : [4, 8],
               'alpha' : [8, 13],
               'beta' : [13, 30],
               'gamma' : [30, 50]})

# Define plot settings
t_settings = {'fontsize' : 24, 'fontweight' : 'bold'}
shade_cols = ['#e8dc35', '#46b870', '#1882d9', '#a218d9', '#e60026']
labels = ['highpas', 'lowpas']
# Define some template strings for reporting
exp_template = "The difference of aperiodic exponent is: \t {:1.2f}"
pw_template = ("The difference of {:5} power is  {: 1.2f}\t"
               "with peaks or  {: 1.2f}\t with bands.")

def compare_exp(fm1, fm2):
    """Compare exponent values."""

    exp1 = fm1.get_params('aperiodic_params', 'exponent')
    exp2 = fm2.get_params('aperiodic_params', 'exponent')

    return exp1 - exp2

def compare_peak_pw(fm1, fm2, band_def):
    """Compare the power of detected peaks."""

    pw1 = get_band_peak_fm(fm1, band_def)[1]
    pw2 = get_band_peak_fm(fm2, band_def)[1]

    return pw1 - pw2

def compare_band_pw(fm1, fm2, band_def):
    """Compare the power of frequency band ranges."""

    pw1 = np.mean(trim_spectrum(fm1.freqs, fm1.power_spectrum, band_def)[1])
    pw2 = np.mean(trim_spectrum(fm1.freqs, fm2.power_spectrum, band_def)[1])

    return pw1 - pw2


warnings.filterwarnings("ignore", category=np.VisibleDeprecationWarning) 
%matplotlib inline

#data_dict = mat73.loadmat(r'D:\Drive\1 - Threshold\pwelch\pwelch_participant_1.mat')
#freqs_dict = loadmat(r'D:\freqs.mat') #whole epoch
freqs_dict = loadmat(r'D:\freqs_mean.mat') #prestimulus part


# pathdata_corrid = rf'{root}\pwelch\pwelch_result\corrid'
# pathdata_incid = rf'{root}\pwelch\pwelch_result\incid'
# pathdata_highpas = rf'{root}\pwelch\pwelch_result\highpas'
# pathdata_lowpas = rf'{root}\pwelch\pwelch_result\lowpas'
# pathdata_pas1 = rf'{root}\pwelch\pwelch_result\pas1'
# pathdata_pas2 = rf'{root}\pwelch\pwelch_result\pas2'
# pathdata_pas3 = rf'{root}\pwelch\pwelch_result\pas3'
# pathdata_pas4 = rf'{root}\pwelch\pwelch_result\pas4'



# task_type = "bgr";
task_type = "obj";
pathdata_corrid = rf'{root}\pwelch\pwelch_result\{task_type}\corrid'
pathdata_incid = rf'{root}\pwelch\pwelch_result\{task_type}\incid'
pathdata_highpas = rf'{root}\pwelch\pwelch_result\{task_type}\highpas'
pathdata_lowpas = rf'{root}\pwelch\pwelch_result\{task_type}\lowpas'
pathdata_pas1 = rf'{root}\pwelch\pwelch_result\{task_type}\pas1'
pathdata_pas2 = rf'{root}\pwelch\pwelch_result\{task_type}\pas2'
pathdata_pas3 = rf'{root}\pwelch\pwelch_result\{task_type}\pas3'
pathdata_pas4 = rf'{root}\pwelch\pwelch_result\{task_type}\pas4'


onlyfiles_corrid = [f for f in listdir(pathdata_corrid) if isfile(join(pathdata_corrid, f))]
onlyfiles_incid = [f for f in listdir(pathdata_incid) if isfile(join(pathdata_incid, f))]
onlyfiles_highpas = [f for f in listdir(pathdata_highpas) if isfile(join(pathdata_highpas, f))]
onlyfiles_lowpas = [f for f in listdir(pathdata_lowpas) if isfile(join(pathdata_lowpas, f))]
onlyfiles_pas1 = [f for f in listdir(pathdata_pas1) if isfile(join(pathdata_pas1, f))]
onlyfiles_pas2 = [f for f in listdir(pathdata_pas2) if isfile(join(pathdata_pas2, f))]
onlyfiles_pas3 = [f for f in listdir(pathdata_pas3) if isfile(join(pathdata_pas3, f))]
onlyfiles_pas4 = [f for f in listdir(pathdata_pas4) if isfile(join(pathdata_pas4, f))]
    



list_corrid = []
list_incid = []
list_highpas = []
list_lowpas = []
list_pas1 = []
list_pas2 = []
list_pas3 = []
list_pas4 = []





psds_corrid = []
psds_incid = []
psds_highpas = []
psds_lowpas = []
psds_pas1 = []
psds_pas2 = []
psds_pas3 = []
psds_pas4 = []

## first jump
#peaks = 1
#lower_freqs = 7
#upper_freqs = 20
#threshold_to_drop = 0.05

# ## based on tutorial 
# peaks = 6
# lower_freqs = 3
# upper_freqs = 40
# min_peak_height = 0.2
# peak_threshold= 2.0
# aperiodic_mode = 'fixed'
# threshold_to_drop = 0.05

# ## based on  https://www.sciencedirect.com/science/article/pii/S1053811921010181
# peaks = 6
# lower_freqs = 0.5
# upper_freqs = 40
# min_peak_height = 0.1
# peak_threshold= 2.0
# aperiodic_mode = 'fixed'
# threshold_to_drop = 0.05
# peak_width_limits = (1.0, 8.0)


## based on Henry Railo code
peaks = 5
lower_freqs = 1
upper_freqs = 40
min_peak_height = 0.0
peak_threshold= 2.0
aperiodic_mode = 'fixed'
threshold_to_drop = 0.1
peak_width_limits = (1.0, 12.0)

import pandas as pd
df_corrid = pd.DataFrame()

for file in onlyfiles_corrid:
    filepath = os.path.join(pathdata_corrid, file)
    data_dict = loadmat(f'{filepath}')    
    participant = re.findall(r'\d+', file)
    psds = np.squeeze(data_dict['corr_id']).astype('float')
    freqs = np.squeeze(freqs_dict['freqs']).astype('float')
    psds_corrid.append(psds)
    fm = FOOOF(peak_width_limits = peak_width_limits, max_n_peaks=peaks,  min_peak_height=min_peak_height, peak_threshold=peak_threshold, aperiodic_mode = aperiodic_mode);
    fm.fit(freqs, psds, [lower_freqs, upper_freqs]);
    list_corrid.append(fm);
    if fm.peak_params_.size == 0:
        df_corrid = {'aperiodic_fit':  fm._ap_fit, 'FOOOF_model': fm.fooofed_spectrum_, 'Power_spectrum': fm.power_spectrum, 
                     'aperiodic_params': fm.aperiodic_params_, 'r2': fm.r_squared_, 'error': fm.error_, 
                     'Central_freq': 0, 'Power_freq': 0, 'Bandwith_freq': 0, 
                     'Gaussian_params': fm.gaussian_params_, 'Gaussian_overlap': fm._gauss_overlap_thresh, 'Spectrum_flat': fm._spectrum_flat, 
                     'Spectrum_peak_rm': fm._spectrum_peak_rm}
    else:
        df_corrid = {'aperiodic_fit':  fm._ap_fit, 'FOOOF_model': fm.fooofed_spectrum_, 'Power_spectrum': fm.power_spectrum, 
                     'aperiodic_params': fm.aperiodic_params_, 'r2': fm.r_squared_, 'error': fm.error_, 
                     'Central_freq': fm.peak_params_[0,0], 'Power_freq': fm.peak_params_[0,1], 'Bandwith_freq': fm.peak_params_[0,2], 
                     'Gaussian_params': fm.gaussian_params_, 'Gaussian_overlap': fm._gauss_overlap_thresh, 'Spectrum_flat': fm._spectrum_flat, 
                     'Spectrum_peak_rm': fm._spectrum_peak_rm}
    savemat(rf'{pathdata_corrid}\fooof\{file}', df_corrid)
fGroup_corrid = combine_fooofs(list_corrid)    
fGroup_corrid.fit()
fGroup_corrid.drop(fGroup_corrid.get_params('error') > threshold_to_drop)
print('number of dropped models: ', fGroup_corrid.n_null_)
fGroup_corrid.plot()



    
for file in onlyfiles_incid:
    filepath = os.path.join(pathdata_incid, file)
    data_dict = loadmat(f'{filepath}')    
    participant = re.findall(r'\d+', file)
    psds = np.squeeze(data_dict['inc_id']).astype('float')
    psds_incid.append(psds)
    freqs = np.squeeze(freqs_dict['freqs']).astype('float')
    
    fm = FOOOF(peak_width_limits = peak_width_limits, max_n_peaks=peaks,  min_peak_height=min_peak_height, peak_threshold=peak_threshold, aperiodic_mode = aperiodic_mode);
    fm.fit(freqs, psds, [lower_freqs, upper_freqs]);
    list_incid.append(fm);
    if fm.peak_params_.size == 0:
        df_incid = {'aperiodic_fit':  fm._ap_fit, 'FOOOF_model': fm.fooofed_spectrum_, 'Power_spectrum': fm.power_spectrum, 
                     'aperiodic_params': fm.aperiodic_params_, 'r2': fm.r_squared_, 'error': fm.error_, 
                     'Central_freq': 0, 'Power_freq': 0, 'Bandwith_freq': 0, 
                     'Gaussian_params': fm.gaussian_params_, 'Gaussian_overlap': fm._gauss_overlap_thresh, 'Spectrum_flat': fm._spectrum_flat, 
                     'Spectrum_peak_rm': fm._spectrum_peak_rm}
    else:
        df_incid = {'aperiodic_fit':  fm._ap_fit, 'FOOOF_model': fm.fooofed_spectrum_, 'Power_spectrum': fm.power_spectrum, 
                     'aperiodic_params': fm.aperiodic_params_, 'r2': fm.r_squared_, 'error': fm.error_, 
                     'Central_freq': fm.peak_params_[0,0], 'Power_freq': fm.peak_params_[0,1], 'Bandwith_freq': fm.peak_params_[0,2], 
                     'Gaussian_params': fm.gaussian_params_, 'Gaussian_overlap': fm._gauss_overlap_thresh, 'Spectrum_flat': fm._spectrum_flat, 
                     'Spectrum_peak_rm': fm._spectrum_peak_rm}
    savemat(rf'{pathdata_incid}\fooof\{file}', df_incid)
    
    
    
fGroup_incid = combine_fooofs(list_incid)      
fGroup_incid.fit()
fGroup_incid.drop(fGroup_incid.get_params('error') > threshold_to_drop)
print('number of dropped models: ', fGroup_incid.n_null_)
fGroup_incid.plot()

for file in onlyfiles_highpas:
    filepath = os.path.join(pathdata_highpas, file)
    data_dict = loadmat(f'{filepath}')    
    participant = re.findall(r'\d+', file)
    psds = np.squeeze(data_dict['highpas']).astype('float')
    freqs = np.squeeze(freqs_dict['freqs']).astype('float')
    psds_highpas.append(psds)
    #print(f'{file}')
    #print(psds[0])
    fm = FOOOF(peak_width_limits = peak_width_limits, max_n_peaks=peaks,  min_peak_height=min_peak_height, peak_threshold=peak_threshold, aperiodic_mode = aperiodic_mode);
    fm.fit(freqs, psds, [lower_freqs, upper_freqs]);
    list_highpas.append(fm);
    if fm.peak_params_.size == 0:
        df_highpas = {'aperiodic_fit':  fm._ap_fit, 'FOOOF_model': fm.fooofed_spectrum_, 'Power_spectrum': fm.power_spectrum, 
                     'aperiodic_params': fm.aperiodic_params_, 'r2': fm.r_squared_, 'error': fm.error_, 
                     'Central_freq': 0, 'Power_freq': 0, 'Bandwith_freq': 0, 
                     'Gaussian_params': fm.gaussian_params_, 'Gaussian_overlap': fm._gauss_overlap_thresh, 'Spectrum_flat': fm._spectrum_flat, 
                     'Spectrum_peak_rm': fm._spectrum_peak_rm}
    else:
        df_highpas = {'aperiodic_fit':  fm._ap_fit, 'FOOOF_model': fm.fooofed_spectrum_, 'Power_spectrum': fm.power_spectrum, 
                     'aperiodic_params': fm.aperiodic_params_, 'r2': fm.r_squared_, 'error': fm.error_, 
                     'Central_freq': fm.peak_params_[0,0], 'Power_freq': fm.peak_params_[0,1], 'Bandwith_freq': fm.peak_params_[0,2], 
                     'Gaussian_params': fm.gaussian_params_, 'Gaussian_overlap': fm._gauss_overlap_thresh, 'Spectrum_flat': fm._spectrum_flat, 
                     'Spectrum_peak_rm': fm._spectrum_peak_rm}
    savemat(rf'{pathdata_highpas}\fooof\{file}', df_highpas)
fGroup_highpas = combine_fooofs(list_highpas)      
fGroup_highpas.fit()
fGroup_highpas.drop(fGroup_highpas.get_params('error') > threshold_to_drop)
print('number of dropped models: ', fGroup_highpas.n_null_)
fGroup_highpas.plot()    
    
for file in onlyfiles_lowpas:
    filepath = os.path.join(pathdata_lowpas, file)
    data_dict = loadmat(f'{filepath}')    
    participant = re.findall(r'\d+', file)
    psds = np.squeeze(data_dict['lowpas']).astype('float')
    psds_lowpas.append(psds)
    freqs = np.squeeze(freqs_dict['freqs']).astype('float')
    
    fm = FOOOF(peak_width_limits = peak_width_limits, max_n_peaks=peaks,  min_peak_height=min_peak_height, peak_threshold=peak_threshold, aperiodic_mode = aperiodic_mode);
    fm.fit(freqs, psds, [lower_freqs, upper_freqs]);
    list_lowpas.append(fm);
    if fm.peak_params_.size == 0:
        df_lowpas = {'aperiodic_fit':  fm._ap_fit, 'FOOOF_model': fm.fooofed_spectrum_, 'Power_spectrum': fm.power_spectrum, 
                     'aperiodic_params': fm.aperiodic_params_, 'r2': fm.r_squared_, 'error': fm.error_, 
                     'Central_freq': 0, 'Power_freq': 0, 'Bandwith_freq': 0, 
                     'Gaussian_params': fm.gaussian_params_, 'Gaussian_overlap': fm._gauss_overlap_thresh, 'Spectrum_flat': fm._spectrum_flat, 
                     'Spectrum_peak_rm': fm._spectrum_peak_rm}
    else:
        df_lowpas = {'aperiodic_fit':  fm._ap_fit, 'FOOOF_model': fm.fooofed_spectrum_, 'Power_spectrum': fm.power_spectrum, 
                     'aperiodic_params': fm.aperiodic_params_, 'r2': fm.r_squared_, 'error': fm.error_, 
                     'Central_freq': fm.peak_params_[0,0], 'Power_freq': fm.peak_params_[0,1], 'Bandwith_freq': fm.peak_params_[0,2], 
                     'Gaussian_params': fm.gaussian_params_, 'Gaussian_overlap': fm._gauss_overlap_thresh, 'Spectrum_flat': fm._spectrum_flat, 
                     'Spectrum_peak_rm': fm._spectrum_peak_rm}
    savemat(rf'{pathdata_lowpas}\fooof\{file}', df_lowpas)
fGroup_lowpas = combine_fooofs(list_lowpas)      
fGroup_lowpas.fit()
fGroup_lowpas.drop(fGroup_lowpas.get_params('error') > threshold_to_drop)
print('number of dropped models: ', fGroup_lowpas.n_null_)
fGroup_lowpas.plot()    

    
for file in onlyfiles_pas1:
    filepath = os.path.join(pathdata_pas1, file)
    data_dict = loadmat(f'{filepath}')    
    participant = re.findall(r'\d+', file)
    psds = np.squeeze(data_dict['pas1']).astype('float')
    psds_pas1.append(psds)
    freqs = np.squeeze(freqs_dict['freqs']).astype('float')
    
    fm = FOOOF(peak_width_limits = peak_width_limits, max_n_peaks=peaks,  min_peak_height=min_peak_height, peak_threshold=peak_threshold, aperiodic_mode = aperiodic_mode);
    fm.fit(freqs, psds, [lower_freqs, upper_freqs]);
    list_pas1.append(fm);
    if fm.peak_params_.size == 0:
        df_pas1 = {'aperiodic_fit':  fm._ap_fit, 'FOOOF_model': fm.fooofed_spectrum_, 'Power_spectrum': fm.power_spectrum, 
                     'aperiodic_params': fm.aperiodic_params_, 'r2': fm.r_squared_, 'error': fm.error_, 
                     'Central_freq': 0, 'Power_freq': 0, 'Bandwith_freq': 0, 
                     'Gaussian_params': fm.gaussian_params_, 'Gaussian_overlap': fm._gauss_overlap_thresh, 'Spectrum_flat': fm._spectrum_flat, 
                     'Spectrum_peak_rm': fm._spectrum_peak_rm}
    else:
        df_pas1 = {'aperiodic_fit':  fm._ap_fit, 'FOOOF_model': fm.fooofed_spectrum_, 'Power_spectrum': fm.power_spectrum, 
                     'aperiodic_params': fm.aperiodic_params_, 'r2': fm.r_squared_, 'error': fm.error_, 
                     'Central_freq': fm.peak_params_[0,0], 'Power_freq': fm.peak_params_[0,1], 'Bandwith_freq': fm.peak_params_[0,2], 
                     'Gaussian_params': fm.gaussian_params_, 'Gaussian_overlap': fm._gauss_overlap_thresh, 'Spectrum_flat': fm._spectrum_flat, 
                     'Spectrum_peak_rm': fm._spectrum_peak_rm}
    savemat(rf'{pathdata_pas1}\fooof\{file}', df_pas1)
fGroup_pas1 = combine_fooofs(list_pas1)      
fGroup_pas1.fit()
fGroup_pas1.drop(fGroup_pas1.get_params('error') > threshold_to_drop)
print('number of dropped models: ', fGroup_pas1.n_null_)
fGroup_pas1.plot()   

for file in onlyfiles_pas2:
    filepath = os.path.join(pathdata_pas2, file)
    data_dict = loadmat(f'{filepath}')    
    participant = re.findall(r'\d+', file)
    psds = np.squeeze(data_dict['pas2']).astype('float')
    psds_pas2.append(psds)
    freqs = np.squeeze(freqs_dict['freqs']).astype('float')
    
    fm = FOOOF(peak_width_limits = peak_width_limits, max_n_peaks=peaks,  min_peak_height=min_peak_height, peak_threshold=peak_threshold, aperiodic_mode = aperiodic_mode);
    fm.fit(freqs, psds, [lower_freqs, upper_freqs]);
    list_pas2.append(fm);
    if fm.peak_params_.size == 0:
        df_pas2 = {'aperiodic_fit':  fm._ap_fit, 'FOOOF_model': fm.fooofed_spectrum_, 'Power_spectrum': fm.power_spectrum, 
                     'aperiodic_params': fm.aperiodic_params_, 'r2': fm.r_squared_, 'error': fm.error_, 
                     'Central_freq': 0, 'Power_freq': 0, 'Bandwith_freq': 0, 
                     'Gaussian_params': fm.gaussian_params_, 'Gaussian_overlap': fm._gauss_overlap_thresh, 'Spectrum_flat': fm._spectrum_flat, 
                     'Spectrum_peak_rm': fm._spectrum_peak_rm}
    else:
        df_pas2 = {'aperiodic_fit':  fm._ap_fit, 'FOOOF_model': fm.fooofed_spectrum_, 'Power_spectrum': fm.power_spectrum, 
                     'aperiodic_params': fm.aperiodic_params_, 'r2': fm.r_squared_, 'error': fm.error_, 
                     'Central_freq': fm.peak_params_[0,0], 'Power_freq': fm.peak_params_[0,1], 'Bandwith_freq': fm.peak_params_[0,2], 
                     'Gaussian_params': fm.gaussian_params_, 'Gaussian_overlap': fm._gauss_overlap_thresh, 'Spectrum_flat': fm._spectrum_flat, 
                     'Spectrum_peak_rm': fm._spectrum_peak_rm}
    savemat(rf'{pathdata_pas2}\fooof\{file}', df_pas2)
fGroup_pas2 = combine_fooofs(list_pas2)      
fGroup_pas2.fit()
fGroup_pas2.drop(fGroup_pas2.get_params('error') > threshold_to_drop)
print('number of dropped models: ', fGroup_pas2.n_null_)
fGroup_pas2.plot()   


for file in onlyfiles_pas3:
    filepath = os.path.join(pathdata_pas3, file)
    data_dict = loadmat(f'{filepath}')    
    participant = re.findall(r'\d+', file)
    psds = np.squeeze(data_dict['pas3']).astype('float')
    psds_pas3.append(psds)
    freqs = np.squeeze(freqs_dict['freqs']).astype('float')
    
    fm = FOOOF(peak_width_limits = peak_width_limits, max_n_peaks=peaks,  min_peak_height=min_peak_height, peak_threshold=peak_threshold, aperiodic_mode = aperiodic_mode);
    fm.fit(freqs, psds, [lower_freqs, upper_freqs]);
    list_pas3.append(fm);
    if fm.peak_params_.size == 0:
        df_pas3 = {'aperiodic_fit':  fm._ap_fit, 'FOOOF_model': fm.fooofed_spectrum_, 'Power_spectrum': fm.power_spectrum, 
                     'aperiodic_params': fm.aperiodic_params_, 'r2': fm.r_squared_, 'error': fm.error_, 
                     'Central_freq': 0, 'Power_freq': 0, 'Bandwith_freq': 0, 
                     'Gaussian_params': fm.gaussian_params_, 'Gaussian_overlap': fm._gauss_overlap_thresh, 'Spectrum_flat': fm._spectrum_flat, 
                     'Spectrum_peak_rm': fm._spectrum_peak_rm}
    else:
        df_pas3 = {'aperiodic_fit':  fm._ap_fit, 'FOOOF_model': fm.fooofed_spectrum_, 'Power_spectrum': fm.power_spectrum, 
                     'aperiodic_params': fm.aperiodic_params_, 'r2': fm.r_squared_, 'error': fm.error_, 
                     'Central_freq': fm.peak_params_[0,0], 'Power_freq': fm.peak_params_[0,1], 'Bandwith_freq': fm.peak_params_[0,2], 
                     'Gaussian_params': fm.gaussian_params_, 'Gaussian_overlap': fm._gauss_overlap_thresh, 'Spectrum_flat': fm._spectrum_flat, 
                     'Spectrum_peak_rm': fm._spectrum_peak_rm}
    savemat(rf'{pathdata_pas3}\fooof\{file}', df_pas3)
fGroup_pas3 = combine_fooofs(list_pas3)      
fGroup_pas3.fit()
fGroup_pas3.drop(fGroup_pas3.get_params('error') > threshold_to_drop)
print('number of dropped models: ', fGroup_pas3.n_null_)
fGroup_pas3.plot()   


for file in onlyfiles_pas4:
    filepath = os.path.join(pathdata_pas4, file)
    data_dict = loadmat(f'{filepath}')    
    participant = re.findall(r'\d+', file)
    psds = np.squeeze(data_dict['pas4']).astype('float')

    psds_pas4.append(psds)
    freqs = np.squeeze(freqs_dict['freqs']).astype('float')
    
    fm = FOOOF(peak_width_limits = peak_width_limits, max_n_peaks=peaks,  min_peak_height=min_peak_height, peak_threshold=peak_threshold, aperiodic_mode = aperiodic_mode);
    fm.fit(freqs, psds, [lower_freqs, upper_freqs]);
    list_pas4.append(fm);
    if fm.peak_params_.size == 0:
        df_pas4 = {'aperiodic_fit':  fm._ap_fit, 'FOOOF_model': fm.fooofed_spectrum_, 'Power_spectrum': fm.power_spectrum, 
                     'aperiodic_params': fm.aperiodic_params_, 'r2': fm.r_squared_, 'error': fm.error_, 
                     'Central_freq': 0, 'Power_freq': 0, 'Bandwith_freq': 0, 
                     'Gaussian_params': fm.gaussian_params_, 'Gaussian_overlap': fm._gauss_overlap_thresh, 'Spectrum_flat': fm._spectrum_flat, 
                     'Spectrum_peak_rm': fm._spectrum_peak_rm}
    else:
        df_pas4 = {'aperiodic_fit':  fm._ap_fit, 'FOOOF_model': fm.fooofed_spectrum_, 'Power_spectrum': fm.power_spectrum, 
                     'aperiodic_params': fm.aperiodic_params_, 'r2': fm.r_squared_, 'error': fm.error_, 
                     'Central_freq': fm.peak_params_[0,0], 'Power_freq': fm.peak_params_[0,1], 'Bandwith_freq': fm.peak_params_[0,2], 
                     'Gaussian_params': fm.gaussian_params_, 'Gaussian_overlap': fm._gauss_overlap_thresh, 'Spectrum_flat': fm._spectrum_flat, 
                     'Spectrum_peak_rm': fm._spectrum_peak_rm}
    savemat(rf'{pathdata_pas4}\fooof\{file}', df_pas4)
fGroup_pas4 = combine_fooofs(list_pas4)      
fGroup_pas4.fit()
fGroup_pas4.drop(fGroup_pas4.get_params('error') > threshold_to_drop)
print('number of dropped models: ', fGroup_pas4.n_null_)
fGroup_pas4.plot()   

# # Extract a model parameter with `get_params`
# err = fGroup_corrid.get_params('error')

# # Extract parameters, indicating sub-selections of parameters
# exp = fGroup_corrid.get_params('aperiodic_params', 'exponent')
# cfs = fGroup_corrid.get_params('peak_params', 'CF')

# # Print out a custom parameter report
# template = ("With an error level of {error:1.2f}, FOOOF fit an exponent "
#             "of {exponent:1.2f} and peaks of {cfs:s} Hz.")
# print(template.format(error=err, exponent=exp,
#                       cfs=' & '.join(map(str, [round(cf, 2) for cf in cfs]))))


import matplotlib.pyplot as plt
plt.plot(np.mean(psds_corrid, 0))
plt.plot(np.mean(psds_incid, 0))
plt.plot(np.mean(psds_highpas, 0))
plt.plot(np.mean(psds_lowpas, 0))


bands = Bands({'alpha' : [8, 13],
               'theta' : [4, 8],
               'beta' : [13, 30]})
colors = ['#2400a8', '#00700b']
labels_acc = ['Correct', 'Incorrect']
labels_pas = ['highpas', 'lowpas']


avg_corrid = average_fg(fGroup_corrid, bands, avg_method='median')
avg_incid = average_fg(fGroup_incid, bands, avg_method='median')
avg_highpas = average_fg(fGroup_highpas, bands, avg_method='median')
avg_lowpas = average_fg(fGroup_lowpas, bands, avg_method='median')
avg_pas1 = average_fg(fGroup_pas1, bands, avg_method='median')
avg_pas2 = average_fg(fGroup_pas2, bands, avg_method='median')
avg_pas3 = average_fg(fGroup_pas3, bands, avg_method='median')
avg_pas4 = average_fg(fGroup_pas4, bands, avg_method='median')

corrid_alphas = get_band_peak_fg(fGroup_corrid, bands.alpha)
incid_alphas = get_band_peak_fg(fGroup_incid, bands.alpha)
highpas_alphas = get_band_peak_fg(fGroup_highpas, bands.alpha)
lowpas_alphas = get_band_peak_fg(fGroup_lowpas, bands.alpha)

plot_peak_params([corrid_alphas, incid_alphas], freq_range=bands.alpha,
                 labels=labels_acc, colors=colors)

plot_peak_params([highpas_alphas, lowpas_alphas], freq_range=bands.alpha,
                 labels=labels_pas, colors=colors)


plot_peak_fits([corrid_alphas, incid_alphas],
               labels=labels_acc, colors=colors)

plot_peak_fits([highpas_alphas, lowpas_alphas],
               labels=labels_pas, colors=colors)


aps_corr = fGroup_corrid.get_params('aperiodic_params')
aps_inc = fGroup_incid.get_params('aperiodic_params')
aps_highpas = fGroup_highpas.get_params('aperiodic_params')
aps_lowpas = fGroup_lowpas.get_params('aperiodic_params')

plot_aperiodic_fits(aps_corr, freq_range=[lower_freqs, upper_freqs], control_offset=True)
plot_aperiodic_fits(aps_inc, freq_range=[lower_freqs, upper_freqs], control_offset=True)
plot_aperiodic_fits(aps_highpas, freq_range=[lower_freqs, upper_freqs], control_offset=True)
plot_aperiodic_fits(aps_lowpas, freq_range=[lower_freqs, upper_freqs], control_offset=True)



avg_corrid.plot(plot_peaks='shade-line-dot-outline')
avg_incid.plot(plot_peaks='shade-line-dot-outline')
avg_highpas.plot(plot_peaks='shade-line-dot-outline')
avg_lowpas.plot(plot_peaks='shade-line-dot-outline')


fGroup_highpas.print_settings()

alpha_corrid = get_band_peak_fg(fGroup_corrid, bands.alpha)
# Check descriptive statistics of extracted peak parameters
print('Descriptive stats for Correct peak parameters:')
fGroup_corrid.print_results()
print('Alpha CF : {:1.2f}'.format(np.nanmean(alpha_corrid[:, 0])))
print('Alpha PW : {:1.2f}'.format(np.nanmean(alpha_corrid[:, 1])))
print('Alpha BW : {:1.2f}'.format(np.nanmean(alpha_corrid[:, 2])))
fGroup_corrid.fit()
compute_pointwise_error_fg(fGroup_corrid, plot_errors=True)


alpha_incid = get_band_peak_fg(fGroup_incid, bands.alpha)
# Check descriptive statistics of extracted peak parameters
print('Descriptive stats for Incorrect peak parameters:')
fGroup_incid.print_results()
print('Alpha CF : {:1.2f}'.format(np.nanmean(alpha_incid[:, 0])))
print('Alpha PW : {:1.2f}'.format(np.nanmean(alpha_incid[:, 1])))
print('Alpha BW : {:1.2f}'.format(np.nanmean(alpha_incid[:, 2])))
fGroup_incid.fit()
compute_pointwise_error_fg(fGroup_incid, plot_errors=True)

alpha_highpas = get_band_peak_fg(fGroup_highpas, bands.alpha)
# Check descriptive statistics of extracted peak parameters
print('Descriptive stats for Highpas peak parameters:')
fGroup_highpas.print_results()
print('Alpha CF : {:1.2f}'.format(np.nanmean(alpha_highpas[:, 0])))
print('Alpha PW : {:1.2f}'.format(np.nanmean(alpha_highpas[:, 1])))
print('Alpha BW : {:1.2f}'.format(np.nanmean(alpha_highpas[:, 2])))
fGroup_highpas.fit()
compute_pointwise_error_fg(fGroup_highpas, plot_errors=True)

alpha_lowpas = get_band_peak_fg(fGroup_lowpas, bands.alpha)
# Check descriptive statistics of extracted peak parameters
print('Descriptive stats for lowpas peak parameters:')
fGroup_lowpas.print_results()
print('Alpha CF : {:1.2f}'.format(np.nanmean(alpha_lowpas[:, 0])))
print('Alpha PW : {:1.2f}'.format(np.nanmean(alpha_lowpas[:, 1])))
print('Alpha BW : {:1.2f}'.format(np.nanmean(alpha_lowpas[:, 2])))
fGroup_lowpas.fit()
compute_pointwise_error_fg(fGroup_lowpas, plot_errors=True)

