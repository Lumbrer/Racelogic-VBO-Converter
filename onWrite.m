function onWrite(List,p1op,p2text,p3op,p4text)
%Save data once converted using the format or formats specified by the user

Res_Tables=struct;
Res_Structs=struct;
S1=struct;
S2=struct;
formats=get(p1op,'value');
formats=[formats{:}]';

    if ~any(formats)
    errordlg('Please select valid output format','Output Format Not Specified')
    else
    allfiles=get(List,'string');
    ind=get(List,'value');
    filestoread=allfiles(ind);
    nf=length(filestoread);
    
    newnames=get(p2text,'string');
        if ~isempty(newnames)&&(length(newnames)==nf)
        newnames=genvarname(newnames);
        else
        newnames=filestoread;
        end
    
     dest=get(p4text,'string');
     origin=getappdata(List,'Originaldir');
     if ~isdir(dest)
         dest=uigetdir(origin,'Destination Folder Corrupted, Please Choose New Destination');
     end
     
     h=waitbar(0,'Generating New Data...');
     
     for i=1:nf
       waitbar(i/nf,h,['Processing file ',num2str(i),' of ',num2str(nf)]);
       [T,Stru]=readVbo(fullfile(origin,strcat(filestoread{i},'.vbo')));
       Res_Tables.(newnames{i})=T;
       Res_Structs.(newnames{i})=Stru;
       
       if formats(1)
           
           if(exist(fullfile(dest,'Matlab_Var.mat'),'file')==2)
               S1=load(fullfile(dest,'Matlab_Var.mat'));
               S2.Res_Tables=Res_Tables;
               S2.Res_Structs=Res_Structs;
               
               S1=mergeStructs(S1,S2);
               if isfield(S1,'Res_Structs')
               Res_Structs=S1.Res_Structs;
               end
               if isfield(S1,'Res_Tables')
               Res_Tables=S1.Res_Tables;
               end
               
           end
           
           subformats=get(p3op,'value');
           subformats=[subformats{:}]';
           if subformats(1)
               if subformats(2)
                   save(fullfile(dest,'Matlab_Var.mat'),'Res_Tables','Res_Structs');
               else
                   save(fullfile(dest,'Matlab_Var.mat'),'Res_Structs');
               end
           else
               save(fullfile(dest,'Matlab_Var.mat'),'Res_Tables');
           end
       end
       
       if formats(2)
         writetable(T,fullfile(dest,strcat(newnames{i},'.txt')));
       end
        if formats(3)
         writetable(T,fullfile(dest,strcat(newnames{i},'.dat')));
        end
        if formats(4)
         writetable(T,fullfile(dest,strcat(newnames{i},'.csv')));
        end
        if formats(5)
         writetable(T,fullfile(dest,strcat(newnames{i},'.xls')));
        end
       if formats(6)
         writetable(T,fullfile(dest,strcat(newnames{i},'.xlsx')));
       end
       
       
         
     end
     close(h)

     
    
    
    end   



end

