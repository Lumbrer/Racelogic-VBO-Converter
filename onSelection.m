function onSelection(List,Box,Pan)

u=get(Box,'Value');
if u==1
    names=get(List,'string');
 
    if isempty(names)||(strcmp('No files loaded',names{1})&&length(names)==1)
    else
        ind=get(List,'value');
        set(Pan,'Max',length(names(ind)),'string',names(ind))
    end
    
   
end

end

