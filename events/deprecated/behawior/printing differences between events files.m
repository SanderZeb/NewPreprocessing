
temp2(:,:) = [temp.id2, temp.ID, temp.corrected_id, temp.version_alpha, temp.task_order_alpha, temp.locationResponse_pressKey, temp.displayed_object, temp.displayed_background, temp.task_type, temp.type, temp.trigger];

display(['participant: ' num2str(temp2(n, 2))]);
display(['version: ' num2str(temp2(n, 4))]);
display(['task_order: ' num2str(temp2(n, 5))]);

display('====================================');

display(['current_task: ' num2str(temp2(n, 9))]);
display(['displayed background: ' num2str(temp2(n, 8))]);
display(['displayed object: ' num2str(temp2(n, 7))]);
display('====================================');

if temp2(n, 8) == 1 
    display('background was natural')
else
    display('background was manmade')
end
if temp2(n, 7) == 1 
    display('object was animal')
else
    display('object was manmade')
end


display('====================================');

display(['response: ' num2str(temp2(n, 6))]);
if temp2(n, 9) == 1 
    if temp2(n, 6) == 6
        display('TT: object - response mean: animal')
    elseif temp2(n, 6) == 1
        display('TT: object - response mean: manmade')
    end
elseif temp2(n, 9) == 0 
    if temp2(n, 6) == 6
        display('TT: background - response mean: natural')
    elseif temp2(n, 6) == 1
        display('TT: background - response mean: artificial')
    end
end


display('====================================');

display(['id from alpha: ' num2str(temp2(n, 1))])
display(['id from beh: ' num2str(temp2(n, 3))])