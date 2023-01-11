function [current_behawior, current_alpha] = search_for_extradropouts(current_behawior, current_alpha)
size_beh = size(current_behawior, 1);
size_alf = size(current_alpha,1);
diff = size_beh-size_alf;


if diff<10 & diff>0

    for i=1:diff
        for n = 1:size_beh-diff
            if current_behawior.trigger(n) ~= current_alpha.type(n)
                idx(i) = n;
                
            end
            
            
        end
        current_behawior(idx(i), :) = [];
    end


elseif diff>-10 & diff<0
    disp('behawior ma mniej wpisow niz alfa!');

elseif diff==0
    disp('cool!');
else
    disp('take care of this manually!');
    return
end
end