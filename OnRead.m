function OnRead(hobj,List,WriteBut,Namecheck,Text,Text2)
%find the .vbo files present on the folder selected by the user

direc=uigetdir(pwd,'Choose a folder to read files');

files=dir(fullfile(direc,'*.vbo'));
setappdata(List,'Originaldir',direc);
if isempty(files)
    
    set(List,'string',{});
    errordlg('No .vbo files where found in specified directory','Directory Selection Error')
    set(hobj,'string','Load Data')
else
    filenames={files.name};
    filenames=cellfun(@(x) (x(1:end-4)),filenames,'UniformOutput', false);
   
    set(List,'string',filenames);
    set(List,'Max',length(filenames)+1)
    set(List,'Min',1)
    set(List,'value',1)
    set(WriteBut,'Enable','on')
    set(hobj,'string','Update Folder')
    onNameEdit(Namecheck(2),Text,Namecheck(1),List)
    dest=get(Text2,'string');
    if isempty(dest)
        set(Text2,'string',direc);
    end
end
end