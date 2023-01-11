load('D:\Drive\1 - Threshold\tfdata\export\significant vals - bootstraping.mat')
bootstrapping(1, :) = significant_vals
load('D:\Drive\3 - Mask\tfdata\export\significant vals - bootstraping.mat')
bootstrapping(2, :) = significant_vals
load('D:\Drive\4 - Faces\tfdata\export\significant vals - bootstraping.mat')
bootstrapping(3, :) = significant_vals
load('D:\Drive\5 - Scenes\tfdata wrong epochs\export\significant vals - bootstraping_background.mat')
bootstrapping(4, :) = significant_vals
load('D:\Drive\5 - Scenes\tfdata wrong epochs\export\significant vals - bootstraping_object.mat')
bootstrapping(5, :) = significant_vals

clear significant_vals


participants_in_batch = [10 20 30 40 50 60 70 80 90 100]

for i = 1:size(bootstrapping, 1)
t = figure; hold on;
plot(participants_in_batch, bootstrapping(i).identification_lme_sum / 1000)
plot(participants_in_batch, bootstrapping(i).pas_lme_sum / 1000)
ylim([0 1])
legend('Objective', 'Subjective')
switch i
    case 1
    title('Exp 1 - Threshold')
    case 2
        title('Exp 3 - Mask')
    case 3
        title('Exp 4 - Faces')
    case 4
        title('Exp 5.1 - Scenes Background')
    case 5
        title('Exp 5.2 - Scenes Object')
end
ylabel('Probability of significant effect (p<0.01)')
xlabel('Number of participants')

    saveas(t,['C:\Users\user\Desktop\ploty\bootstrapping\EXP' num2str(i) '.png']);
    saveas(t,['C:\Users\user\Desktop\ploty\bootstrapping\EXP' num2str(i) '.fig']);
    hold off
    close all

end