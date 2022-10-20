settings.paradigm = 5 % 1 - threshold; 2 - cue; 3 - mask; 4 - faces; 5 - scenes; 6 - Kinga
settings.fileType = 1; % 1 - raw (bdf); 0 - .set file
settings.epochLim = [-2 2]; % epoch start; epoch end (in s)
settings.sampling = 256;

if settings.paradigm == 1
    root = 'D:\1 - Gabor\';
elseif settings.paradigm == 2
    root = 'D:\Drive\2 - Cue\';
elseif settings.paradigm == 3
    root = 'D:\3 - Mask\';
elseif settings.paradigm == 4
    root = 'D:\Drive\4 - Faces\';
elseif settings.paradigm == 5
    root = 'D:\Drive\5 - Scenes\';
elseif settings.paradigm == 6
    root='D:\Drive\6 - Kinga\';
end

runFiltering(settings.paradigm, settings.fileType, root, settings.sampling) 
addpath('C:\Users\user\Documents\GitHub\NewPreprocessing\events')
runEpoching(settings.paradigm, root, settings.epochLim) 
runICA(settings.paradigm, root)
runMARA(settings.paradigm, root)
run_ERPs(settings.paradigm, root)