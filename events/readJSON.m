

pathLoadCSV = 'D:\Drive\behawior\Faces\';
listCSV = dir([pathLoadCSV '*.json']);



for i = 1:length(listCSV)
    fname = [listCSV(1).folder '\' listCSV(i).name]
    fid = fopen(fname);
    raw = fread(fid,inf);
    str = char(raw');
    fclose(fid);
    data(i).json_file = jsondecode(str)
    data(i).filename = listCSV(i).name;
    data(i).id = data(i).json_file.expInfo.ID;
    data(i).version = data(i).json_file.version  ;
    data(i).fearfulX_45 =  data(i).json_file.orientationResponse.responseCode.x_45  ;
    data(i).neutralX45 =  data(i).json_file.orientationResponse.responseCode.x45  ;
    data(i).femaleX1 =  data(i).json_file.locationResponse.responseCode.x1  ;
    data(i).maleX2 =  data(i).json_file.locationResponse.responseCode.x2  ;
end