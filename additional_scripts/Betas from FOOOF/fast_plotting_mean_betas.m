
listBetas=dir([ 'D:\Drive\1 - Threshold\tfdata\fooof\betas_fooof\1\aperiodic\*.mat'  ]);

for i = 1:length(listBetas)
load([listBetas(i).folder '\' listBetas(i).name])
temp = flip(squeeze(betas(:,:,1)));
fig = heatmap(temp);
grid off;
colormap jet;
clim([-2 2]);
saveas(fig, ['D:\Drive\1 - Threshold\tfdata\fooof\betas_fooof\1\singlepart\' num2str(i) '.png']);
clear temp clear fig
close all
end


listBetas=dir([ 'D:\Drive\1 - Threshold\tfdata\fooof\*_periodic.mat'  ]);

for i = 1:length(listBetas)
load([listBetas(i).folder '\' listBetas(i).name])
temp = flip(squeeze(mean(data(:,:,:), 3)));
fig = heatmap(temp);
grid off;
colormap jet;
clim([-2 2]);
saveas(fig, ['D:\Drive\1 - Threshold\tfdata\fooof\betas_fooof\1\singlepart\' num2str(i) '.png']);

end
%%
listBetas=dir([ 'D:\Drive\1 - Threshold\tfdata\fooof\betas_fooof\1\aperiodic\*.mat'  ]);

for i = 1:length(listBetas)
load([listBetas(i).folder '\' listBetas(i).name])

all_betas.acc(:,:,i) = betas(:,:,1);
all_betas.pas(:,:,i) = betas(:,:,2);
all_betas.interaction(:,:,i) = betas(:,:,3);
clear betas


end

heatmap(flip(squeeze(mean(all_betas.acc, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.pas, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.interaction, 3)))); colormap jet; grid off



%%
listBetas=dir([ 'D:\Drive\1 - Threshold\tfdata\fooof\betas_fooof\1\periodic\*.mat'  ]);

for i = 1:length(listBetas)
load([listBetas(i).folder '\' listBetas(i).name])

all_betas.acc(:,:,i) = betas(:,:,1);
all_betas.pas(:,:,i) = betas(:,:,2);
all_betas.interaction(:,:,i) = betas(:,:,3);
clear betas
end

heatmap(flip(squeeze(mean(all_betas.acc, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.pas, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.interaction, 3)))); colormap jet; grid off

%%
%%
%%
%%


listBetas=dir([ 'D:\Drive\1 - Threshold\tfdata\fooof\betas_fooof\2\aperiodic\*.mat'  ]);

for i = 1:length(listBetas)
load([listBetas(i).folder '\' listBetas(i).name])

all_betas.acc(:,:,i) = betas(:,:,1);
all_betas.pas(:,:,i) = betas(:,:,2);
all_betas.interaction(:,:,i) = betas(:,:,3);
clear betas
end

heatmap(flip(squeeze(mean(all_betas.acc, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.pas, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.interaction, 3)))); colormap jet; grid off



%%
listBetas=dir([ 'D:\Drive\1 - Threshold\tfdata\fooof\betas_fooof\2\periodic\*.mat'  ]);

for i = 1:length(listBetas)
load([listBetas(i).folder '\' listBetas(i).name])

all_betas.acc(:,:,i) = betas(:,:,1);
all_betas.pas(:,:,i) = betas(:,:,2);
all_betas.interaction(:,:,i) = betas(:,:,3);
clear betas
end

heatmap(flip(squeeze(mean(all_betas.acc, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.pas, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.interaction, 3)))); colormap jet; grid off

%%
%%
%%
%%


listBetas=dir([ 'D:\Drive\1 - Threshold\tfdata\fooof\betas_fooof\3\aperiodic\*.mat'  ]);

for i = 1:length(listBetas)
load([listBetas(i).folder '\' listBetas(i).name])

all_betas.intercept(:,:,i) = betas(:,:,1);
all_betas.acc(:,:,i) = betas(:,:,2);
all_betas.pas(:,:,i) = betas(:,:,3);
all_betas.interaction(:,:,i) = betas(:,:,4);
clear betas
end

heatmap(flip(squeeze(mean(all_betas.acc, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.pas, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.interaction, 3)))); colormap jet; grid off



%%
listBetas=dir([ 'D:\Drive\1 - Threshold\tfdata\fooof\betas_fooof\3\periodic\*.mat'  ]);

for i = 1:length(listBetas)
load([listBetas(i).folder '\' listBetas(i).name])

all_betas.intercept(:,:,i) = betas(:,:,1);
all_betas.acc(:,:,i) = betas(:,:,2);
all_betas.pas(:,:,i) = betas(:,:,3);
all_betas.interaction(:,:,i) = betas(:,:,4);
clear betas
end

heatmap(flip(squeeze(mean(all_betas.acc, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.pas, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.interaction, 3)))); colormap jet; grid off
%%
%%
%%
%%


listBetas=dir([ 'D:\Drive\1 - Threshold\tfdata\fooof\betas_fooof\4\aperiodic\*.mat'  ]);

for i = 1:length(listBetas)
load([listBetas(i).folder '\' listBetas(i).name])

all_betas.intercept(:,:,i) = betas(:,:,1);
all_betas.acc(:,:,i) = betas(:,:,2);
all_betas.pas(:,:,i) = betas(:,:,3);
all_betas.interaction(:,:,i) = betas(:,:,4);
clear betas
end

heatmap(flip(squeeze(mean(all_betas.acc, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.pas, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.interaction, 3)))); colormap jet; grid off



%%
listBetas=dir([ 'D:\Drive\1 - Threshold\tfdata\fooof\betas_fooof\4\periodic\*.mat'  ]);

for i = 1:length(listBetas)
load([listBetas(i).folder '\' listBetas(i).name])

all_betas.intercept(:,:,i) = betas(:,:,1);
all_betas.acc(:,:,i) = betas(:,:,2);
all_betas.pas(:,:,i) = betas(:,:,3);
all_betas.interaction(:,:,i) = betas(:,:,4);
clear betas
end

heatmap(flip(squeeze(mean(all_betas.acc, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.pas, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.interaction, 3)))); colormap jet; grid off
%%
%%
%%
%%


listBetas=dir([ 'D:\Drive\1 - Threshold\tfdata\fooof\betas_fooof\5\aperiodic\*.mat'  ]);

for i = 1:length(listBetas)
load([listBetas(i).folder '\' listBetas(i).name])

all_betas.intercept(:,:,i) = betas(:,:,1);
all_betas.acc(:,:,i) = betas(:,:,2);
all_betas.pas(:,:,i) = betas(:,:,3);
all_betas.interaction(:,:,i) = betas(:,:,4);
clear betas
end

heatmap(flip(squeeze(mean(all_betas.acc, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.pas, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.interaction, 3)))); colormap jet; grid off



%%
listBetas=dir([ 'D:\Drive\1 - Threshold\tfdata\fooof\betas_fooof\5\periodic\*.mat'  ]);

for i = 1:length(listBetas)
load([listBetas(i).folder '\' listBetas(i).name])

all_betas.intercept(:,:,i) = betas(:,:,1);
all_betas.acc(:,:,i) = betas(:,:,2);
all_betas.pas(:,:,i) = betas(:,:,3);
all_betas.interaction(:,:,i) = betas(:,:,4);
clear betas
end

heatmap(flip(squeeze(mean(all_betas.acc, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.pas, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.interaction, 3)))); colormap jet; grid off
%%
%%
%%
%%


listBetas=dir([ 'D:\Drive\1 - Threshold\tfdata\fooof\betas_fooof\6\aperiodic\*.mat'  ]);

for i = 1:length(listBetas)
load([listBetas(i).folder '\' listBetas(i).name])
all_betas.acc(:,:,i) = betas(:,:,1);
all_betas.pas(:,:,i) = betas(:,:,2);
all_betas.interaction(:,:,i) = betas(:,:,3);
clear betas
end

heatmap(flip(squeeze(mean(all_betas.acc, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.pas, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.interaction, 3)))); colormap jet; grid off



%%
listBetas=dir([ 'D:\Drive\1 - Threshold\tfdata\fooof\betas_fooof\6\periodic\*.mat'  ]);

for i = 1:length(listBetas)
load([listBetas(i).folder '\' listBetas(i).name])
all_betas.acc(:,:,i) = betas(:,:,1);
all_betas.pas(:,:,i) = betas(:,:,2);
all_betas.interaction(:,:,i) = betas(:,:,3);
clear betas
end

heatmap(flip(squeeze(mean(all_betas.acc, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.pas, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.interaction, 3)))); colormap jet; grid off
%%
%%
%%
%%


listBetas=dir([ 'D:\Drive\1 - Threshold\tfdata\fooof\betas_fooof\7\aperiodic\*.mat'  ]);

for i = 1:length(listBetas)
load([listBetas(i).folder '\' listBetas(i).name])
all_betas.acc(:,:,i) = betas(:,:,2);
all_betas.pas(:,:,i) = betas(:,:,3);
all_betas.interaction(:,:,i) = betas(:,:,4);
clear betas
end

heatmap(flip(squeeze(mean(all_betas.acc, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.pas, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.interaction, 3)))); colormap jet; grid off



%%
listBetas=dir([ 'D:\Drive\1 - Threshold\tfdata\fooof\betas_fooof\7\periodic\*.mat'  ]);

for i = 1:length(listBetas)
load([listBetas(i).folder '\' listBetas(i).name])
all_betas.acc(:,:,i) = betas(:,:,2);
all_betas.pas(:,:,i) = betas(:,:,3);
all_betas.interaction(:,:,i) = betas(:,:,4);
clear betas
end

heatmap(flip(squeeze(mean(all_betas.acc, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.pas, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.interaction, 3)))); colormap jet; grid off
%%
%%
%%
%%


listBetas=dir([ 'D:\Drive\1 - Threshold\tfdata\fooof\betas_fooof\8\aperiodic\*.mat'  ]);

for i = 1:length(listBetas)
load([listBetas(i).folder '\' listBetas(i).name])
all_betas.acc(:,:,i) = betas(:,:,1);
all_betas.pas(:,:,i) = betas(:,:,2);
all_betas.interaction(:,:,i) = betas(:,:,3);
clear betas
end

heatmap(flip(squeeze(mean(all_betas.acc, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.pas, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.interaction, 3)))); colormap jet; grid off



%%
listBetas=dir([ 'D:\Drive\1 - Threshold\tfdata\fooof\betas_fooof\8\periodic\*.mat'  ]);

for i = 1:length(listBetas)
load([listBetas(i).folder '\' listBetas(i).name])
all_betas.acc(:,:,i) = betas(:,:,1);
all_betas.pas(:,:,i) = betas(:,:,2);
all_betas.interaction(:,:,i) = betas(:,:,3);
clear betas
end

heatmap(flip(squeeze(mean(all_betas.acc, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.pas, 3)))); colormap jet; grid off
heatmap(flip(squeeze(mean(all_betas.interaction, 3)))); colormap jet; grid off