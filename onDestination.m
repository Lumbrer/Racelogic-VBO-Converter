function  onDestination(Tx)
%function to demand new destination directory
direc=uigetdir(pwd,'Choose a new destination folder');
if ~isempty(direc)&&isdir(direc)
set(Tx,'String',direc)
end

end

