function checkMAT(oper,op1,op2,pan)
%function to ensure .mat option is deselected if not applicable format is
%chosen
c=get(op1,'value')+get(op2,'value');
if ~any(c)
    set(oper,'value',0)
    set(op1,'value',0)
    set(op2,'value',0)
    set(pan,'Enable','off')
end



end

