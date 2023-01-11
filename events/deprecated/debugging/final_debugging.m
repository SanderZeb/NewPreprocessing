load('D:\Drive\5 - Scenes\behawior_alpha.mat')
mix_all.Var75(1,1) = 1;
mix_all.Properties.VariableNames(75) = "accuracy";
for i = 1:size(mix_all, 1)
    clear stim_name stimulus
    
    stim_name = mix_all.image(i);
    stimulus.obj_artificial = 0;
    stimulus.obj_animal = 0;
    stimulus.bgr_artificial = 0;
    stimulus.bgr_animal = 0;

    if contains(stim_name, 'obj') % object
        stimulus.obj_artificial = 1;
        stimulus.obj_animal = 0;
    elseif contains(stim_name, 'anim') % object
        stimulus.obj_artificial = 0;
        stimulus.obj_animal = 1;
    elseif contains(stim_name, 'artif') % background
        stimulus.bgr_artificial = 1;
        stimulus.bgr_animal = 0;
    elseif contains(stim_name, 'nat') % background
        stimulus.bgr_artificial = 0;
        stimulus.bgr_animal = 1;
    end


    if mix_all.version(i) == 1
        % resp ButtonBox 1 = 0 = artificial
        % resp ButtonBox 6 = 1 = natural
        if mix_all.task_type(i) == 1 % object
            if mix_all.locationResponse_pressKey(i) == 1 %artificial
                if stimulus.obj_artificial == 1
                    mix_all.accuracy(i) = 1;
                else
                    mix_all.accuracy(i) = 0;
                end
            elseif mix_all.locationResponse_pressKey(i) == 6 %natural
                if stimulus.obj_animal == 1
                    mix_all.accuracy(i) = 1;
                else
                    mix_all.accuracy(i) = 0;
                end
            end
        elseif mix_all.task_type(i) == 0 % background
            if mix_all.locationResponse_pressKey(i) == 1 %artificial
                if stimulus.bgr_artificial == 1
                    mix_all.accuracy(i) = 1;
                else
                    mix_all.accuracy(i) = 0;
                end
            elseif mix_all.locationResponse_pressKey(i) == 6 %natural
                if stimulus.bgr_animal == 1
                    mix_all.accuracy(i) = 1;
                else
                    mix_all.accuracy(i) = 0;
                end
            end
        end
    elseif mix_all.version(i) == 2
        % resp ButtonBox 6 = 0 = artificial
        % resp ButtonBox 1 = 1 = natural
        if mix_all.task_type(i) == 1 % object
            if mix_all.locationResponse_pressKey(i) == 1 %artificial
                if stimulus.obj_artificial == 1
                    mix_all.accuracy(i) = 1;
                else
                    mix_all.accuracy(i) = 0;
                end
            elseif mix_all.locationResponse_pressKey(i) == 6 %natural
                if stimulus.obj_animal == 1
                    mix_all.accuracy(i) = 1;
                else
                    mix_all.accuracy(i) = 0;
                end
            end
        elseif mix_all.task_type(i) == 0 % background
            if mix_all.locationResponse_pressKey(i) == 1 %artificial
                if stimulus.bgr_artificial == 1
                    mix_all.accuracy(i) = 1;
                else
                    mix_all.accuracy(i) = 0;
                end
            elseif mix_all.locationResponse_pressKey(i) == 6 %natural
                if stimulus.bgr_animal == 1
                    mix_all.accuracy(i) = 1;
                else
                    mix_all.accuracy(i) = 0;
                end
            end
        end
    end

end