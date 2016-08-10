function VBO_GUI_APP(f)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
uiextras.set( 0, 'DefaultHBoxBackgroundColor', [20/255 90/255 220/255] );
uiextras.set( 0, 'DefaultBoxPanelTitleColor', [170/255 190/255 225/255] );
uiextras.set( 0, 'DefaultBoxPanelFontSize', 12 );
uiextras.set( 0, 'DefaultBoxPanelFont', 'cambria' );


vbar=uiextras.VBox('Parent',f);

hbarup=uiextras.HBox( 'Parent', vbar,'Padding',5 );
List=uicontrol('style','listbox','Parent',hbarup,'value',1,'string',{'No files loaded'},'FontName','cambria','FontSize',12);
vbarpanels=uiextras.VBox('Parent',hbarup);
set(hbarup,'Sizes',[-1 400]);

hbardown=uiextras.HButtonBox('Parent',vbar,'Padding',5 );
set( vbar, 'Sizes', [-1 70], 'Spacing', 5 );


ReadBut=uicontrol('style','PushButton','Parent',hbardown,'String','Load Data');
WriteBut=uicontrol('style','PushButton','Parent',hbardown,'String','Write Data','Enable','off');
CloseBut=uicontrol('style','PushButton','Parent',hbardown,'String','Close App','Callback',@(s,e) close(f));

set( hbardown, 'ButtonSize', [150 40], 'Spacing', 150 );

p1 = uiextras.BoxPanel( 'Parent', vbarpanels, 'Title', 'Output File Format','FontWeight','Bold','HelpFcn',@(s,e) helpdlg('Use this panel to specify if the data should be saved on any other format','File Format Help'));
p2 = uiextras.BoxPanel( 'Parent', vbarpanels, 'Title', 'File Name(s)','FontWeight','Bold','HelpFcn',@(s,e) helpdlg('Use this panel to specify new file name(s) if desired. Invalid names will be automatically corrected by the App','File Name Help')); 
p3= uiextras.BoxPanel( 'Parent', vbarpanels, 'Title', 'Data Type for .MAT File(s)','FontWeight','Bold','HelpFcn',@(s,e) helpdlg('Use this panel to specify the data format in .MAT files if applicable','Data Type in .MAT Help'));
p4= uiextras.BoxPanel( 'Parent', vbarpanels, 'Title', 'Destination Folder','FontWeight','Bold','HelpFcn',@(s,e) helpdlg('Use this panel to specify a new destination folder for the files, by default it will be defined as the folder from which data is imported','Destination Folder Help'));
set(vbarpanels,'Sizes',[100 -1 75 75]);

p1base=uiextras.VBox('Parent',p1,'Padding',15);
p1u=uiextras.HBox('Parent',p1base);
p1d=uiextras.HBox('Parent',p1base);
p3c=uiextras.HBox('Parent',p3);
p2base=uiextras.VBox('Parent',p2,'Padding',15);
p2u=uiextras.HBox('Parent',p2base);
p2d=uiextras.HBox('Parent',p2base);
p4base=uiextras.HBox('Parent',p4);
p4l=uiextras.HButtonBox('Parent',p4base,'Padding',2);
p4r=uiextras.HBox('Parent',p4base);
set(p2base,'Sizes',[30 -1]);
set(p4base,'Sizes',[110 -1]);



p1op=[];
p2op=[];
p3op=[];


p3op(1)=uicontrol('Parent',p3c,'style','Checkbox','String','STRUCTURE','FontName','cambria','value',1,'FontSize',11);
p3op(2)=uicontrol('Parent',p3c,'style','Checkbox','String','TABLE','FontName','cambria','value',1,'FontSize',11);

p1op(1)=uicontrol('Parent',p1u,'style','Checkbox','String','MAT','FontName','cambria','value',0,'FontSize',11);
p1op(2)=uicontrol('Parent',p1u,'style','Checkbox','String','TXT','FontName','cambria','value',0,'FontSize',11);
p1op(3)=uicontrol('Parent',p1u,'style','Checkbox','String','DAT','FontName','cambria','value',0,'FontSize',11);
p1op(4)=uicontrol('Parent',p1d,'style','Checkbox','String','CSV','FontName','cambria','value',0,'FontSize',11);
p1op(5)=uicontrol('Parent',p1d,'style','Checkbox','String','XLS','FontName','cambria','value',0,'FontSize',11);
p1op(6)=uicontrol('Parent',p1d,'style','Checkbox','String','XLSX','FontName','cambria','value',0,'FontSize',11);

p2op(1)=uicontrol('Parent',p2u,'style','Checkbox','String','Use Default','FontName','cambria','value',1,'FontSize',11);
p2op(2)=uicontrol('Parent',p2u,'style','Checkbox','String','Define New','FontName','cambria','value',0,'FontSize',11);
p2text=uicontrol('Parent',p2d,'style','Edit','Enable','off');
set(p2op(1),'Callback',@(s,e) onName(p2op(1),p2text,p2op(2),List));



set(p3,'Padding',15,'Enable','off');
set(p1op(1),'Callback',@(s,e) onMat(p1op(1),p3));
set(p2op(2),'Callback',@(s,e) onNameEdit(p2op(2),p2text,p2op(1),List));


p4button=uicontrol('Parent',p4l,'style','pushbutton','string','New Dest. Folder');
p4text=uicontrol('Parent',p4r,'style','text');

set(p4button,'Callback',@(s,e) onDestination(p4text));



set(List,'Callback',@(s,e) onSelection(List,p2op(2),p2text));
set(ReadBut,'Callback',@(s,e) OnRead(ReadBut,List,WriteBut,p2op,p2text,p4text));
set(WriteBut,'Callback',@(s,e) onWrite(List,p1op,p2text,p3op,p4text));
set(p3op(1),'Callback',@(s,e) checkMAT(p1op(1),p3op(1),p3op(2),p3))
set(p3op(2),'Callback',@(s,e) checkMAT(p1op(1),p3op(1),p3op(2),p3))


end

