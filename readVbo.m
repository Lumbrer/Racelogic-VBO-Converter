function [T,data] = readVbo(filename)
     
%   this file reads the .vbo file and stores the raw data in both a Table
%   and Struct variable within the matlab workspace.

fid=fopen(filename,'r');
if fid == -1
    disp('File opened unsuccessfully')
else
    %disp('File opened successfully')
    tag = 0;
    freq=0;
    string_nums='%f%s';
    while feof(fid) == 0
        aline = fgetl(fid);
        if tag == 1
            headers = textscan(aline,'%s', 'delimiter', ' ');
            headers = headers{1,1}';
            [~,v]=size(headers);
            if v>=3
                for jj=3:v
                    string_nums=strcat(string_nums,'%f');
                end
            end
            tag = 0;
        elseif tag == 2
            
            value = textscan(fid,string_nums, 'delimiter', ' ');
            
        elseif strcmp(strtok(aline,':'),'Rate')
            [~,residual]=strtok(aline,' ');
            freq=str2double(strtok(residual,' '));
            
        elseif strcmp(aline,'[column names]')
            tag = 1;
        elseif strcmp(aline,'[data]')
            tag = 2;
        end
    end
end
fid = fclose(fid);
if fid == 0
    
else
    disp('Unable to close file correctly')
end
%% convert data file to data table
T=table.empty;
data=struct;
for i = 1:v
    if isvarname(headers{1,i})
        data.(headers{1,i}) = value{i};
    else
        headers{1,i} = genvarname(headers{1,i});
        data.(headers{1,i}) = value{i};
    end
end
%% Standardise units

if any(freq)
    data.time=(0:1/freq:(length(data.time)-1)/freq)';
else
    for i =1:length(data.time)
        stri = data.time{i,1};
        hours = str2num(stri(1:2));
        minutes = str2num(stri(3:4));
        seconds = str2num(stri(5:length(stri)));
        time(i,:) = 60*60*hours + 60*minutes + seconds;
    end
    
    data.time = time - time(1);
end

data.distance(1) = 0;
%convert lat and lon to degrees
if isfield(data,'lat')
    data.lat=data.lat/60;
end
if isfield(data,'long')
    data.long=data.long/60;
end
for i = 2:length(data.velocity)
    stepdist = data.velocity(i-1)/3.6*(data.time(i)-data.time(i-1))/1000; %distance step in km
    data.distance(i,1) = data.distance(i-1) + stepdist;
end
T=struct2table(data);

end

