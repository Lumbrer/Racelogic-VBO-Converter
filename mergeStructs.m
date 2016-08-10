function [S_merged] = mergeStructs(S1,S2)
%Function used to merge structs when new results need to be added. The data
%in S1 takes preference in case of collision of file names. 

S_merged=struct.empty;

Sections={'Res_Tables';'Res_Structs'};
Files={};

for i=1:length(Sections)
    
    if isfield(S2,Sections{i})
        
        Files=fieldnames(S2.(Sections{i}));
        if ~isempty(Files)
            
            for j=1:length(Files)
                
                if (~isfield(S1,Sections{i})||~isfield(S1.(Sections{i}),Files{j}))
                    
                   S1.(Sections{i}).(Files{j})=S2.(Sections{i}).(Files{j});
                    
                    
                end
                
                
                
            end
            
        end
    
    
    end


end

S_merged=S1;

end

