function onMat(Box,Pan)
%tick on .mat option
u=get(Box,'Value');
if u==1
    set(Pan,'Enable','on');
else
    set(Pan,'Enable','off');
end

end

