function onName(Box,Pan,Box2,List)
%use same name as default
u=get(Box,'Value');
if u==1
    set(Pan,'string','');
    set(Pan,'Enable','off');
    set(Box2,'value',0);
else
    set(Pan,'Enable','on');
    set(Box2,'value',1);
    names=get(List,'string');
    if isempty(names)||(strcmp('No files loaded',names{1})&&length(names)==1)
    else
        ind=get(List,'value');
        set(Pan,'Max',length(names(ind)),'string',names(ind))
    end
end

end
