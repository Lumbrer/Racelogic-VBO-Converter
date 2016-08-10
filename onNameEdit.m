function onNameEdit(Box,Pan,Box2,List)
%Prepare the template to add new file names if desired by the user
u=get(Box,'Value');
if u==1
    set(Pan,'Enable','on');
    set(Box2,'value',0);
    names=get(List,'string');
 
    if isempty(names)||(strcmp('No files loaded',names{1})&&length(names)==1)
    else
        ind=get(List,'value');
        set(Pan,'Max',length(names(ind)),'string',names(ind))
    end
    
    
else
    set(Pan,'string','');
    set(Pan,'Enable','off');
    set(Box2,'value',1);
end

end

