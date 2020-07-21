unit fpcupdeluxemainform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Types, Buttons, Menus, ComCtrls,
  SynEdit, SynEditPopup, SynEditMiscClasses,
  installerManager
  {$ifdef usealternateui},alternateui{$endif}
  ,LMessages
  ,LCLVersion, ActnList, StdActns
  {$ifdef RemoteLog}
  ,mormotdatamodelclient
  {$endif}
  ;

{$IF DEFINED(lcl_fullversion) AND (lcl_fullversion >= 2010000)}
{$define EnableLanguages}
{$endif}

const
  WM_THREADINFO = LM_USER + 2010;

type
  TSynEditHelper = class helper for TCustomSynEdit
    procedure SetFiltered(line: string); inline;
  end;


  { TForm1 }

  TForm1 = class(TForm)
    ActionList1: TActionList;
    AutoCrossUpdate: TButton;
    BitBtnFPCandLazarus: TBitBtn;
    BitBtnFPCOnly: TBitBtn;
    BitBtnFPCOnlyTag: TBitBtn;
    BitBtnHalt: TBitBtn;
    BitBtnLazarusOnly: TBitBtn;
    BitBtnLazarusOnlyTag: TBitBtn;
    btnSendLog: TButton;
    btnUpdateLazarusMakefiles: TButton;
    btnInstallModule: TButton;
    btnSetupPlus: TButton;
    btnClearLog: TButton;
    btnUninstallModule: TButton;
    btnGetOpenSSL: TButton;
    ChkMakefileFPC: TButton;
    ButtonInstallCrossCompiler: TButton;
    ButtonRemoveCrossCompiler: TButton;
    CheckAutoClear: TCheckBox;
    CreateStartup: TButton;
    ChkMakefileLaz: TButton;
    actFileExit: TFileExit;
    actFileSave: TFileSaveAs;
    FPCVersionLabel: TLabel;
    FPCTagLabel: TLabel;
    LazarusVersionLabel: TLabel;
    LazarusTagLabel: TLabel;
    ListBoxFPCTarget: TListBox;
    ListBoxFPCTargetTag: TListBox;
    ListBoxLazarusTarget: TListBox;
    ListBoxLazarusTargetTag: TListBox;
    listModules: TListBox;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MemoAddTag: TMemo;
    memoSummary: TMemo;
    MenuItem1: TMenuItem;
    EmbeddedBtn: TBitBtn;
    MenuItem2: TMenuItem;
    MEnglishlanguage: TMenuItem;
    MChineseCNlanguage: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuFile: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MFPCBugs: TMenuItem;
    MLazarusBugs: TMenuItem;
    MIssuesGitHub: TMenuItem;
    MIssuesForum: TMenuItem;
    OPMBtn: TBitBtn;
    PageControl1: TPageControl;
    radgrpCPU: TRadioGroup;
    radgrpOS: TRadioGroup;
    StatusMessage: TEdit;
    BasicSheet: TTabSheet;
    CrossSheet: TTabSheet;
    ModuleSheet: TTabSheet;
    ExtraSheet: TTabSheet;
    TagSheet: TTabSheet;
    TrunkBtn: TBitBtn;
    FixesBtn: TBitBtn;
    StableBtn: TBitBtn;
    OldBtn: TBitBtn;
    mORMotBtn: TBitBtn;
    btnInstallDirSelect: TButton;
    InstallDirEdit: TEdit;
    Panel1: TPanel;
    RealFPCURL: TEdit;
    RealLazURL: TEdit;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    CommandOutputScreen: TSynEdit;
    procedure actFileSaveAccept(Sender: TObject);
    procedure btnUpdateLazarusMakefilesClick({%H-}Sender: TObject);
    procedure TagSelectionChange(Sender: TObject;{%H-}User: boolean);
    procedure OnlyTagClick(Sender: TObject);
    procedure InstallClick(Sender: TObject);
    procedure BitBtnHaltClick({%H-}Sender: TObject);
    procedure btnGetOpenSSLClick({%H-}Sender: TObject);
    procedure Button1Click({%H-}Sender: TObject);
    procedure ChkMakefileFPCClick(Sender: TObject);
    procedure Edit1KeyUp({%H-}Sender: TObject; var {%H-}Key: Word; {%H-}Shift: TShiftState);
    procedure FPCVersionLabelClick({%H-}Sender: TObject);
    procedure btnInstallModuleClick(Sender: TObject);
    procedure btnInstallDirSelectClick({%H-}Sender: TObject);
    procedure btnSetupPlusClick({%H-}Sender: TObject);
    procedure btnLogClick({%H-}Sender: TObject);
    function  ButtonProcessCrossCompiler(Sender: TObject):boolean;
    procedure ButtonAutoUpdateCrossCompiler(Sender: TObject);
    procedure FormClose({%H-}Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate({%H-}Sender: TObject);
    procedure FormDestroy({%H-}Sender: TObject);
    procedure FormResize({%H-}Sender: TObject);
    procedure LazarusVersionLabelClick({%H-}Sender: TObject);
    procedure listModulesSelectionChange(Sender: TObject; User: boolean);
    procedure listModulesShowHint(Sender: TObject; HintInfo: PHintInfo);
    procedure MChineseCNlanguageClick({%H-}Sender: TObject);
    procedure MEnglishlanguageClick({%H-}Sender: TObject);
    procedure MFPCBugsClick({%H-}Sender: TObject);
    procedure MIssuesForumClick({%H-}Sender: TObject);
    procedure MIssuesGitHubClick({%H-}Sender: TObject);
    procedure MLazarusBugsClick({%H-}Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure RealURLChange(Sender: TObject);
    procedure RealURLDblClick(Sender: TObject);
    procedure CommandOutputScreenChange({%H-}Sender: TObject);
    procedure CommandOutputScreenSpecialLineMarkup({%H-}Sender: TObject; Line: integer;
      var Special: boolean; Markup: TSynSelectedColor);
    procedure TargetSelectionChange(Sender: TObject; User: boolean);
    procedure MenuItem1Click({%H-}Sender: TObject);
    procedure radgrpCPUClick({%H-}Sender: TObject);
    procedure radgrpOSClick({%H-}Sender: TObject);
    procedure CommandOutputScreenMouseWheel({%H-}Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; {%H-}MousePos: TPoint; var {%H-}Handled: Boolean);
    procedure QuickBtnClick(Sender: TObject);
    {$ifdef usealternateui}
    procedure alternateuibutClick(Sender: TObject);
    procedure alternateuibutEnter(Sender: TObject);
    procedure alternateuibutLeave(Sender: TObject);
    {$endif}
  private
    { private declarations }
    MessageTrigger:boolean;
    FPCupManager:TFPCupManager;
    //oldoutput: TextFile;
    sInstallDir:string;
    sStatus:string;
    {$ifdef EnableLanguages}
    sLanguage:string;
    {$endif}
    FFPCTarget,FLazarusTarget:string;
    MissingCrossBins:boolean;
    MissingCrossLibs:boolean;
    MissingTools:boolean;
    InternalError:string;
    {$ifdef RemoteLog}
    sConsentWarning:boolean;
    aDataClient:TDataClient;
    {$endif}
    procedure HandleInfo(var Msg: TLMessage); message WM_THREADINFO;
    procedure InitFpcupdeluxe({%H-}Data: PtrInt=0);
    {$ifdef RemoteLog}
    procedure InitConsent({%H-}Data: PtrInt=0);
    {$endif}
    procedure InitShortCuts;
    procedure CheckForUpdates({%H-}Data: PtrInt=0);
    function  AutoUpdateCrossCompiler(Sender: TObject):boolean;
    procedure SetFPCTarget(aFPCTarget:string);
    procedure SetLazarusTarget(aLazarusTarget:string);
    procedure DisEnable({%H-}Sender: TObject;value:boolean);
    procedure Edit1Change({%H-}Sender: TObject);
    procedure PrepareRun;
    function  RealRun:boolean;
    function  GetFPCUPSettings(IniDirectory:string):boolean;
    function  SetFPCUPSettings(IniDirectory:string):boolean;
    procedure AddMessage(const aMessage:string; const UpdateStatus:boolean=false);
    procedure SetTarget(aControl:TControl;const aTarget:string='');
    procedure InitFPCupManager;
    {$ifndef usealternateui}
    property  FPCTarget:string read FFPCTarget write SetFPCTarget;
    property  LazarusTarget:string read FLazarusTarget write SetLazarusTarget;
    {$endif}

  public
    { public declarations }
    {$ifdef usealternateui}
    property FPCTarget:string read FFPCTarget write SetFPCTarget;
    property LazarusTarget:string read FLazarusTarget write SetLazarusTarget;
    {$endif}
  end;

resourcestring
  upCheckUpdate = 'Please wait. Checking for updates.';
  upUpdateFound = 'New fpcupdeluxe version available';
  upUpdateNotFound = 'No updates found.';
  upBuildCrossCompiler = 'Going to install a cross-compiler from available sources.';
  upBuildAllCrossCompilers = 'Going to auto-build all installed cross-compilers !';
  upBuildAllCrossCompilersCheck = 'Checking FPC configfile [fpc.cfg] for cross-compilers in ';
  upBuildAllCrossCompilersFound = 'Found crosscompiler for ';
  upBuildAllCrossCompilersUpdate = 'Going to update cross-compiler.';

var
  Form1: TForm1;

implementation

{$R *.lfm}

uses
  InterfaceBase, // for WidgetSet
  LCLType, // for MessageBox
  LCLIntf, // for OpenURL
  IniFiles,
  StrUtils,
  {$ifdef EnableLanguages}
  Translations,
  LCLTranslator,
  LazUTF8,
  {$endif}
  {$ifdef UNIX}
  BaseUnix,
  {$endif UNIX}
  AboutFrm,
  extrasettings,
  modulesettings,
  //checkoptions,
  installerCore,
  installerUniversal,
  m_crossinstaller, // for checking of availability of fpc[laz]up[deluxe] cross-compilers
  fpcuputil,
  URIParser,
  process,
  processutils;

//{$I message.inc}


procedure TSynEditHelper.SetFiltered(line: string);
begin
  // skip stray empty lines
  //if (Length(line)=0) then exit;

  {$ifdef Darwin}
  // suppress all setfocus errors on Darwin, always
  if AnsiContainsText(line,'.setfocus') then exit;
  {$endif}

  // suppress all SynEdit PaintLock errors, always
  if AnsiContainsText(line,'PaintLock') then exit;

  {$IF DEFINED(FPC_FULLVERSION) AND (FPC_FULLVERSION > 30000)}
  Self.Append(line);
  {$ELSE}
  Self.Lines.Append(line);
  {$ENDIF}
  Self.CaretX:=0;
  Self.CaretY:=Self.Lines.Count;
  // the below is needed:
  // onchange is no longer called, when appending a line ... bug or feature ?!!
  Self.OnChange(Self);
  //Application.ProcessMessages;
end;

{ TForm1 }

{$ifdef EnableLanguages}
procedure Translate(const Language: string);
var
  Res: TResourceStream;
  PoFileName:string;
  aLanguage,Lang, FallbackLang, Dir: String;
begin
  aLanguage:=Language;

  Lang:='';
  FallbackLang:='';
  LazGetLanguageIDs(Lang,FallbackLang); // in unit LazUTF8

  if aLanguage='' then aLanguage:=FallbackLang;

  PoFileName:='fpcupdeluxe.' + aLanguage + '.po';
  //SysUtils.DeleteFile(PoFileName);

  if NOT FileExists(PoFileName) then
  begin
    try
      Res := TResourceStream.Create(HInstance, 'fpcupdeluxe.' + aLanguage, RT_RCDATA);
      Res.SaveToFile(PoFileName);
      Res.Free;
    except
    end;
  end;

  if FileExists(PoFileName) then
  begin
    SetDefaultLang(Language,'','fpcupdeluxe');

    //Dir := AppendPathDelim(AppendPathDelim(ExtractFileDir(ParamStr(0))) + 'languages');
    //Translations.TranslateUnitResourceStrings('fpcupdeluxemainform',Dir+'fpcupdeluxemainform.%s.po',Lang,FallbackLang);

    //Translations.TranslateResourceStrings(PoFileName,Lang,FallbackLang);

    {$ifdef Windows}
    //{%H-}GetLocaleFormatSettings($409, DefaultFormatSettings);
    {$endif}
  end;
end;
{$endif}

procedure TForm1.FormCreate(Sender: TObject);
var
  IniFilesOk:boolean;
  aTarget:string;
begin
  MessageTrigger:=false;

  {$ifdef EnableLanguages}
  sLanguage:='en';
  {$endif}

  FPCupManager:=nil;

  {$IF defined(LCLQT) OR defined(LCLQT5)}
  // due to a bugger in QT[5]
  Self.Position:=poDesigned;
  {$endif}

  {$ifdef RemoteLog}
  aDataClient:=TDataClient.Create;
  {$ifdef usealternateui}
  aDataClient.UpInfo.UpVersion:=DELUXEVERSION+'+';
  {$else}
  aDataClient.UpInfo.UpVersion:=DELUXEVERSION;
  {$endif}
  aDataClient.UpInfo.UpOS:=GetTargetCPUOS;
  {$endif}

  {$ifndef MSWINDOWS}
  btnGetOpenSSL.Visible:=false;
  {$endif}

  {$IF defined(CPUAARCH64) OR defined(CPUARM) OR (defined(CPUPOWERPC64) AND defined(FPC_ABI_ELFV2)) OR defined(Haiku) OR defined(AROS) OR defined(Morphos)}
  // disable some features
  OldBtn.Visible:=False;
  {DinoBtn.Visible:=False;}
  CrossSheet.TabVisible:=false;
  {$endif}
  {$IF defined(CPUAARCH64) OR (defined(CPUPOWERPC64) AND defined(FPC_ABI_ELFV2))}
  // disable some features
  FixesBtn.Visible:=False;
  StableBtn.Visible:=False;
  {$endif}

  {$ifdef Darwin}
  radgrpOS.Items.Strings[radgrpOS.Items.IndexOf(GetOS(TOS.wince))]:='i-sim';
  {$endif Darwin}


  (*
  oldoutput := System.Output;
  AssignSynEdit(System.Output, CommandOutputScreen);
  Reset(System.Input);
  Rewrite(System.Output);
  *)

  {$IF DEFINED(FPC_FULLVERSION) AND (FPC_FULLVERSION > 30000)}
  aTarget:=GetLCLWidgetTypeName;
  {$ELSE}
  aTarget:='';
  {$ENDIF}

  {$ifdef RemoteLog}
  aDataClient.UpInfo.UpWidget:=aTarget;
  {$endif}

  Self.Caption:=
  {$ifdef usealternateui}
  'FPCUPdeluxery V'+
  {$else}
  'FPCUPdeluxe V'+
  {$endif}
    DELUXEVERSION+
    ' for ' +
    GetTargetCPUOS+
    '-'+
    aTarget;

  sStatus:='Sitting and waiting';

  InitShortCuts;

  {$IFDEF MSWINDOWS}
  sInstallDir:='C:\fpcupdeluxe';
  {$ELSE}
  sInstallDir:=ExpandFileName('~/fpcupdeluxe');
  btnGetOpenSSL.Visible:=False;
  {$ENDIF}

  {$ifdef Haiku}
  MenuItem3.Visible:=False;
  {$endif}

  //Prevent overwriting an existing install when starting with a new fpcupdeluxe install
  If DirectoryExists(sInstallDir) then
    sInstallDir:=IncludeTrailingPathDelimiter(SafeGetApplicationPath)+'fpcupdeluxe';

  {$ifdef DARWIN}
  // we could have started from with an .app , so goto the basedir ... not sure if realy needed, but to be sure.
  AddMessage('Setting base directory to: '+ExcludeTrailingPathDelimiter(SafeGetApplicationPath));
  if (NOT SetCurrentDir(ExcludeTrailingPathDelimiter(SafeGetApplicationPath))) then
    AddMessage('Setting base directory failure !!')
  else
    AddMessage('Current base directory : '+GetCurrentDir);
  {$endif}

  // get last used install directory, proxy and visual settings
  with TIniFile.Create(SafeGetApplicationPath+installerUniversal.DELUXEFILENAME) do
  try
    sInstallDir:=ReadString('General','InstallDirectory',sInstallDir);
    {$ifdef EnableLanguages}
    sLanguage:=ReadString('General','Language',sLanguage);
    {$endif}
    {$ifdef RemoteLog}
    sConsentWarning:=ReadBool('General','ConsentWarning',true);
    {$endif}
    CheckAutoClear.Checked:=ReadBool('General','AutoClear',True);
    CommandOutputScreen.Font.Size := ReadInteger('General','CommandFontSize',CommandOutputScreen.Font.Size);

    if ValueExists('General','Maximized') then
    begin
      if ReadBool('General','Maximized',False) then
      begin
        Self.WindowState:=wsMaximized;
      end
      else
      begin
        Self.WindowState:=wsNormal;
        Self.Top := ReadInteger('General','Top',Self.Top);
        Self.Left := ReadInteger('General','Left',Self.Left);
        Self.Width := ReadInteger('General','Width',Self.Width);
        Self.Height := ReadInteger('General','Height',Self.Height);
      end;
    end;
  finally
    Free;
  end;

  IniFilesOk:=
    (SaveInisFromResource(SafeGetApplicationPath+installerUniversal.SETTTINGSFILENAME,'settings_ini'))
    AND
    (SetConfigFile(SafeGetApplicationPath+installerUniversal.CONFIGFILENAME));

  aTarget:='';
  if IniFilesOk then
  begin
    if ListBoxFPCTarget.Count=0 then
    begin
      ListBoxFPCTarget.Items.CommaText:=installerUniversal.GetAlias('fpcURL','list');
    end;
    if ListBoxLazarusTarget.Count=0 then
    begin
      ListBoxLazarusTarget.Items.CommaText:=installerUniversal.GetAlias('lazURL','list');
    end;

    sInstallDir:=ExcludeTrailingPathDelimiter(SafeExpandFileName(sInstallDir));

    InstallDirEdit.Text:=sInstallDir;

    // set InstallDirEdit (installdir) onchange here, to prevent early firing
    InstallDirEdit.OnChange:=nil;
    InstallDirEdit.OnKeyUp:=nil;
    {$ifdef Darwin}
    {$ifdef LCLCOCOA}
    // onchange does not work on cocoa, so use onkeyup
    InstallDirEdit.OnKeyUp:=@Edit1KeyUp;
    {$endif}
    {$endif}
    if InstallDirEdit.OnKeyUp=nil then InstallDirEdit.OnChange:=@Edit1Change;

    // create settings form
    // must be done here, to enable local storage/access of some setttings !!
    Form2:=TForm2.Create(Form1);
    Form3:=TForm3.Create(Form1);
    InitFpcupdeluxe;
    {$ifdef RemoteLog}
    Application.QueueAsyncCall(@InitConsent,0);
    {$endif}
  end
  else
  begin
    AddMessage('');
    AddMessage('FPCUPdeluxe could not create its necessary setting-files.');
    AddMessage('All functions are disabled for now.');
    AddMessage('');
    AddMessage('Please check the folder permissions, and re-start.');
    AddMessage('');
    DisEnable(nil,False);
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  i:integer;
begin
  //if Assigned(Form3) then Form3.Destroy;
  //if Assigned(Form2) then Form2.Destroy;

  for i:=(listModules.Count-1) downto 0 do
  begin
    if Assigned(listModules.Items.Objects[i]) then
    begin
      StrDispose(Pchar(listModules.Items.Objects[i]));
    end;
  end;

  {$ifdef RemoteLog}
  if Assigned(aDataClient) then aDataClient.Destroy;
  {$endif}

  (* using CloseFile will ensure that all pending output is flushed *)
  (*
  //if (TTextRec(oldoutput).Handle=UnusedHandle) then
  begin
    CloseFile(System.Output);
    System.Output := oldoutput;
  end;
  *)
end;

procedure TForm1.FormResize(Sender: TObject);
var
  w:integer;
begin
  w:=(CommandOutputScreen.Width DIV 2);
  RealFPCURL.Width:=(w-4);
  RealLazURL.Width:=RealFPCURL.Width;
  RealLazURL.Left:=RealFPCURL.Left+(w+4);
end;

procedure TForm1.InitShortCuts;
begin
{$IFDEF LINUX}
  actFileExit.ShortCut := KeyToShortCut(VK_Q, [ssCtrl]);
  actFileSave.ShortCut := KeyToShortCut(VK_S, [ssCtrl]);
{$ENDIF}
{$IFDEF WINDOWS}
  actFileExit.ShortCut := KeyToShortCut(VK_X, [ssAlt]);
  actFileSave.ShortCut := KeyToShortCut(VK_S, [ssAlt]);
{$ENDIF}
end;

procedure TForm1.LazarusVersionLabelClick(Sender: TObject);
begin
  if MessageTrigger then
  begin
    MessageTrigger:=false;
    //Application.MessageBox(PChar(LOVEANDLIES),PChar(LOVEANDLIESHEADER), MB_ICONEXCLAMATION);
  end;
end;

procedure TForm1.listModulesSelectionChange(Sender: TObject; User: boolean);
var
  Index : integer;
  Item : string;
  aList:TListBox;
  aObject:TObject;
begin
  if (NOT User) then exit;
  aList:=TListBox(Sender);
  Memo1.Text:='';
  Index:=aList.ItemIndex;
  aObject:=aList.Items.Objects[Index];
  if Assigned(aObject) then
  begin
    Item:=PChar(aObject);
    Memo1.Text:=Item;
  end;
end;


procedure TForm1.listModulesShowHint(Sender: TObject; HintInfo: PHintInfo);
var
  Index : integer;
  Item : string;
  aList:TListBox;
  aObject:TObject;
begin
  aList:=TListBox(Sender);
  Index:=aList.ItemAtPos(HintInfo^.CursorPos, True);
  if (HintInfo^.HintControl=aList) and (Index > -1) then
  begin
    aObject:=aList.Items.Objects[Index];
    if Assigned(aObject) then
    begin
      Item:=PChar(aObject);
      HintInfo^.HintStr:=Item;
      HintInfo^.CursorRect:=aList.ItemRect(Index);
    end;
  end;
end;

procedure TForm1.MChineseCNlanguageClick(Sender: TObject);
begin
  {$ifdef EnableLanguages}
  sLanguage:='zh';
  TransLate(sLanguage);
  {$endif}
end;

procedure TForm1.MEnglishlanguageClick(Sender: TObject);
begin
  {$ifdef EnableLanguages}
  sLanguage:='en';
  TransLate(sLanguage);
  {$endif}
end;

procedure TForm1.MFPCBugsClick(Sender: TObject);
begin
  OpenURL('https://bugs.freepascal.org/my_view_page.php');
end;

procedure TForm1.MIssuesForumClick(Sender: TObject);
begin
  OpenURL('https://forum.lazarus.freepascal.org/index.php/topic,34645.0.html');
end;

procedure TForm1.MIssuesGitHubClick(Sender: TObject);
begin
  OpenURL('https://github.com/LongDirtyAnimAlf/fpcupdeluxe/issues');
end;

procedure TForm1.MLazarusBugsClick(Sender: TObject);
begin
  OpenURL('https://bugs.freepascal.org/view_all_bug_page.php?project_id=1');
end;

procedure TForm1.RealURLChange(Sender: TObject);
begin
  SetTarget(TEdit(Sender));
end;

procedure TForm1.RealURLDblClick(Sender: TObject);
begin
  TEdit(Sender).Color:=clRed;
  TEdit(Sender).ReadOnly:=false;
end;

procedure TForm1.ButtonAutoUpdateCrossCompiler(Sender: TObject);
begin
  AutoUpdateCrossCompiler(Sender);
end;

function TForm1.AutoUpdateCrossCompiler(Sender: TObject):boolean;
var
  //CPUType:TCPU;
  //OSType:TOS;
  FPCCfg:string;
  BinPath:string;
  ConfigText: TStringList;
  aCPU, aOS: string;
  aSubArch: string;
  //aArch: string;
  // tricky: to be changed; todo
  aRadiogroup_CPU,aRadiogroup_OS: string;
  CheckAutoClearStore:boolean;
  success:boolean;
  SnipBegin,i:integer;
  s,aResultMessage:string;
begin
  aOS := GetTargetOS;
  aCPU := GetTargetCPU;
  aSubArch :='';

  //BinPath:=ConcatPaths([FPCupManager.FPCInstallDirectory,'bin',aCPU+'-'+aOS]);
  BinPath:=ConcatPaths([sInstallDir,'fpc','bin',aCPU+'-'+aOS]);

  FPCCfg := IncludeTrailingPathDelimiter(BinPath) + FPCCONFIGFILENAME;

  result:=false;

  if NOT FileExists(FPCCfg) then
  begin
    if (Sender<>nil) then AddMessage('FPC configfile ['+FPCCONFIGFILENAME+'] not found in ' + BinPath);
    exit;
  end;

  if (Sender<>nil) then
  begin

    CheckAutoClearStore:=CheckAutoClear.Checked;
    if CheckAutoClearStore then btnClearLog.Click;
    CheckAutoClear.Checked:=false;

    memoSummary.Lines.Append(upBuildAllCrossCompilers);
    memoSummary.Lines.Append(upBuildAllCrossCompilersCheck + BinPath);
    memoSummary.Lines.Append('');

  end
  else
  begin
    memoSummary.Clear;
  end;

  success:=true;

  aResultMessage:='No cross-compilers found. Nothing to do !';

  ConfigText:=TStringList.Create;
  try
    ConfigText.LoadFromFile(FPCCFG);

    SnipBegin:=0;
    while (SnipBegin<ConfigText.Count) do
    begin
      if Pos(SnipMagicBegin,ConfigText.Strings[SnipBegin])>0 then
      begin
        s:=ConfigText.Strings[SnipBegin];
        Delete(s,1,Length(SnipMagicBegin));
        i:=Pos('-',s);
        if i>0 then
        begin
          aCPU:=Copy(s,1,i-1);
          aOS:=Trim(Copy(s,i+1,MaxInt));

          {
          aArch:='';
          // try to distinguish between different ARM CPU versons ... very experimental and [therefor] only for Linux
          if (UpperCase(aCPU)=GetCPU(TCPU.arm)) AND (UpperCase(aOS)=GetOS(TOS.linux)) then
          begin
            for i:=SnipBegin to SnipBegin+5 do
            begin
              if Pos('#IFDEF CPU',ConfigText.Strings[i])>0 then
              begin
                s:=ConfigText.Strings[i];
                Delete(s,1,Length('#IFDEF CPU'));
                aArch:=s;
                //Still todo: add this architecture into the cross-compile options [-Cp...]
                //FPCupManager.CrossOPT:='-Cp'+s+' ';
                break;
              end;
            end;
          end;
          }

          if (Sender=nil) then
            Form2.SetCrossAvailable(GetCPUOSCombo(aCPU,aOS),true);

          // try to distinguish between different Solaris versons
          if (aOS=GetOS(TOS.solaris)) then
          begin
            i:=SnipBegin;
            while true do
            begin
              s:=ConfigText.Strings[i];
              if (Pos('-FD',s)>0) AND (Pos('-solaris-oi',s)>0) then
              begin
                aOS:='solaris-oi';
                break;
              end;
              Inc(i);
              if (i>=ConfigText.Count) OR (s=SnipMagicEnd) then break;
            end;
          end;

          // try to distinguish between different Linux versons
          if (aOS=GetOS(TOS.linux)) then
          begin
            i:=SnipBegin;
            while true do
            begin
              s:=ConfigText.Strings[i];
              if (Pos('-FD',s)>0) AND (Pos('-musllinux',s)>0) then
              begin
                aOS:='linux-musl';
                break;
              end;
              Inc(i);
              if (i>=ConfigText.Count) OR (s=SnipMagicEnd) then break;
            end;
          end;

          // try to get subarch
          aSubArch:='';
          if (aOS=GetOS(TOS.embedded)) then
          begin
            i:=SnipBegin;
            while true do
            begin
              s:=ConfigText.Strings[i];
              if (Pos('-Cp',s)=1) then
              begin
                aSubArch:=Trim(Copy(s,Length('-Cp')+1,MaxInt));
                break;
              end;
              Inc(i);
              if (i>=ConfigText.Count) OR (s=SnipMagicEnd) then break;
            end;
          end;

          aRadiogroup_CPU:=aCPU;
          aRadiogroup_OS:=aOS;
          if aRadiogroup_CPU=GetCPU(TCPU.powerpc) then aRadiogroup_CPU:='ppc';
          if aRadiogroup_CPU=GetCPU(TCPU.powerpc64) then aRadiogroup_CPU:='ppc64';
          if aRadiogroup_OS='iphonesim' then aRadiogroup_OS:='i-sim';
          if ( (aOS=GetOS(TOS.win32)) or (aOS=GetOS(TOS.win64)) ) then aRadiogroup_OS:='windows';

          //this chek is redundant, but ok for a final check ... ;-)
          //if (ConfigText.IndexOf(SnipMagicBegin+aCPU+'-'+aOS)<>-1) then
          begin
            // list all available compilers
            if (Sender=nil) then AddMessage(upBuildAllCrossCompilersFound+aCPU + '-' + aOS);
            // build all available compilers
            if (Sender<>nil) then
            begin
              CommandOutputScreen.ClearAll;
              aResultMessage:='Finished building of cross-compilers.';
              AddMessage(upBuildAllCrossCompilersFound+aCPU + '-' + aOS);
              AddMessage(upBuildAllCrossCompilersUpdate);
              radgrpCPU.ItemIndex:=radgrpCPU.Items.IndexOf(aRadiogroup_CPU);
              radgrpOS.ItemIndex:=radgrpOS.Items.IndexOf(aRadiogroup_OS);
              success:=ButtonProcessCrossCompiler(nil);
              if success
                then memoSummary.Lines.Append('Cross-compiler update ok.')
                else memoSummary.Lines.Append('Failure during update of cross-compiler !!');
              memoSummary.Lines.Append('');
              if (NOT success) then
              begin
                aResultMessage:='Building of cross-compilers ended with some error(s).';
                break;
              end;
            end;
          end;
        end;
      end;
      Inc(SnipBegin);
    end;

    (*
    for OSType := Low(TOS) to High(TOS) do
    begin

      if (NOT success) then break;

      aOS:=GetEnumNameSimple(TypeInfo(TOS),Ord(OSType));

      for CPUType := Low(TCPU) to High(TCPU) do
      begin

        if (NOT success) then break;

        aCPU:=GetEnumNameSimple(TypeInfo(TCPU),Ord(CPUType));

        // tricky; see above; improvement todo
        aRadiogroup_CPU:=aCPU;
        aRadiogroup_OS:=aOS;
        if aRadiogroup_CPU=GetCPU(TCPU.powerpc) then aRadiogroup_CPU:='ppc';
        if aRadiogroup_CPU=GetCPU(TCPU.powerpc64) then aRadiogroup_CPU:='ppc64';
        if aRadiogroup_OS='iphonesim' then aRadiogroup_OS:='i-sim';

        if (aOS='windows') or (aOS=GetOS(TOS.win32)) or (aOS=GetOS(TOS.win64)) then
        begin
          if aCPU=GetCPU(TCPU.i386) then aOS:=GetOS(TOS.win32);
          if aCPU=GetCPU(TCPU.x86_64) then aOS:=GetOS(TOS.win64);
          aRadiogroup_OS:='windows';
        end;

        {$ifdef win32}
        // On win32, we always build a win64 cross-compiler.
        // So, if the win32 install is updated, this cross-compiler is also updated already auto-magically.
        // We can skip it here, in that case.
        if aOS=GetOS(TOS.win64) then continue;
        {$endif}

        // take into account that there are more ARM CPU settings !!
        // important todo

        if (ConfigText.IndexOf(SnipMagicBegin+aCPU+'-'+aOS)<>-1) then
        begin
          // list all available compilers
          if (Sender=nil) then AddMessage('Crosscompiler for '+aCPU + '-' + aOS+' found !');
          // build all available compilers
          if (Sender<>nil) then
          begin
            CommandOutputScreen.Clear;
            AddMessage('Crosscompiler for '+aCPU + '-' + aOS+' found !');
            AddMessage('Going to update cross-compiler.');
            radgrpCPU.ItemIndex:=radgrpCPU.Items.IndexOf(aRadiogroup_CPU);
            radgrpOS.ItemIndex:=radgrpOS.Items.IndexOf(aRadiogroup_OS);
            success:=InstallCrossCompiler(nil);
            if success
              then memoSummary.Lines.Append('Cross-compiler update ok.')
              else memoSummary.Lines.Append('Failure during update of cross-compiler !!');
            memoSummary.Lines.Append('');
          end;
        end;
      end;
    end;
    *)
    if (Sender<>nil) then
    begin
      radgrpCPU.ItemIndex:=-1;
      radgrpOS.ItemIndex:=-1;
      CheckAutoClear.Checked:=CheckAutoClearStore;
    end;

  finally
    ConfigText.Free;
  end;

  result:=success;

  if (Sender<>nil) then
  begin
    AddMessage('');
    AddMessage(aResultMessage,True);
  end;
end;

procedure TForm1.InitFPCupManager;
var
  SortedModules: TStringList;
  i:integer;
  s,v:string;
begin
  FPCupManager:=TFPCupManager.Create;
  FPCupManager.ConfigFile:=SafeGetApplicationPath+installerUniversal.CONFIGFILENAME;

  FPCupManager.LoadFPCUPConfig;

  FPCTarget:='stable';
  LazarusTarget:='stable';

  FPCupManager.FPCURL:='stable';
  FPCupManager.LazarusURL:='stable';

  FPCupManager.Verbose:=false;

  //CheckFPCUPOptions(FPCupManager);

  if listModules.Count=0 then
  begin
    SortedModules:=TStringList.Create;
    try
      SortedModules.Delimiter:=_SEP;
      SortedModules.StrictDelimiter:=true;
      SortedModules.DelimitedText:=GetModuleList;
      // filter modulelist from trivial entries
      for i:=(SortedModules.Count-1) downto 0 do
      begin
        s:=SortedModules[i];
        if Pos(_DECLARE,s)=0 then
        begin
          SortedModules.Delete(i);
          continue;
        end;
        if (AnsiEndsText(_CLEAN,s)) OR (AnsiEndsText(_UNINSTALL,s)) OR (AnsiEndsText(_BUILD+_ONLY,s)) then
        begin
          SortedModules.Delete(i);
          continue;
        end;
      end;
      SortedModules.Sort;
      for i:=0 to (SortedModules.Count-1) do
      begin
        s:=SortedModules[i];
        Delete(s,1,Length(_DECLARE));
        // get module descriptions
        v:=FPCupManager.ModulePublishedList.Values[s];
        // add to list
        listModules.Items.AddObject(s,TObject(pointer(StrNew(Pchar(v)))));
      end;
    finally
      SortedModules.Free;
    end;
  end;

  FPCupManager.HTTPProxyPort:=Form2.HTTPProxyPort;
  FPCupManager.HTTPProxyHost:=Form2.HTTPProxyHost;
  FPCupManager.HTTPProxyUser:=Form2.HTTPProxyUser;
  FPCupManager.HTTPProxyPassword:=Form2.HTTPProxyPass;

  // localize FPCUPSettings if possible
  if (NOT GetFPCUPSettings(IncludeTrailingPathDelimiter(sInstallDir)))
     then GetFPCUPSettings(SafeGetApplicationPath);
end;


procedure TForm1.BitBtnHaltClick(Sender: TObject);
begin
  if (MessageDlg('I am going to try to halt.' + sLineBreak +
             'Do not (yet) expect too much of it.' + sLineBreak +
             'Its a non-finished feature !'
             ,mtConfirmation,[mbYes, mbNo],0)<>mrYes) then
             begin
               exit;
             end;
  if Assigned(FPCupManager.Sequencer) then
  begin
    FPCupManager.Sequencer.Kill;
  end;
end;

procedure TForm1.btnGetOpenSSLClick(Sender: TObject);
{$ifdef MSWindows}
var
  OpenSSLZip,OpenSSLURL:string;
  Success:boolean;
  {$endif MSWindows}
begin
  {$ifdef MSWindows}
  OpenSSLURL:=OpenSSLSourceURL[Low(OpenSSLSourceURL)];
  OpenSSLZip:=IncludeTrailingPathDelimiter(GetWindowsDownloadFolder)+FileNameFromURL(OpenSSLURL);
  SysUtils.Deletefile(OpenSSLZip);
  Success:=OpenURL(OpenSSLURL);
  if (NOT Success) then
  begin
    OpenSSLURL:=OpenSSLSourceURL[High(OpenSSLSourceURL)];
    OpenSSLZip:=IncludeTrailingPathDelimiter(GetWindowsDownloadFolder)+FileNameFromURL(OpenSSLURL);
    SysUtils.Deletefile(OpenSSLZip);
    Success:=OpenURL(OpenSSLURL);
  end;
  if Success then
  begin
    sleep(5000); // give browser some time to finish
    if FileExists(OpenSSLZip) then
    begin
      with TNormalUnzipper.Create do
      begin
        try
          SysUtils.Deletefile(SafeGetApplicationPath+'libeay32.dll');
          if GetLastOSError<>5 then // no access denied
          begin
            SysUtils.Deletefile(SafeGetApplicationPath+'ssleay32.dll');
            if GetLastOSError<>5 then // no access denied
            begin
              if DoUnZip(OpenSSLZip,SafeGetApplicationPath,['libeay32.dll','ssleay32.dll']) then
              begin
                AddMessage('Success: got OpenSSL library dll by browser!');
              end;
            end;
          end;
        finally
          Free;
        end;
      end;
      SysUtils.Deletefile(OpenSSLZip);
    end;
  end;
  {$endif MSWindows}
end;

procedure TForm1.Button1Click(Sender: TObject);
begin

end;

procedure TForm1.ChkMakefileFPCClick(Sender: TObject);
begin
  DisEnable(Sender,False);

  try

    if (Sender=ChkMakefileLaz) OR (Sender=ChkMakefileFPC) then
    begin
      PrepareRun;
      if Sender=ChkMakefileLaz then FPCupManager.OnlyModules:=_MAKEFILECHECKLAZARUS;
      if Sender=ChkMakefileFPC then FPCupManager.OnlyModules:=_MAKEFILECHECKFPC;
      sStatus:='Going to check Makefile.';
      {$ifdef RemoteLog}
      aDataClient.UpInfo.UpFunction:=ufCheckMakefile;
      {$endif}
      RealRun;
    end;

    if Sender=CreateStartup then
    begin
      PrepareRun;
      FPCupManager.OnlyModules:=_CREATESCRIPT;
      sStatus:='Going to create startup scripts.';
      {$ifdef RemoteLog}
      aDataClient.UpInfo.UpFunction:=ufCreateStartup;
      {$endif}
      RealRun;
    end;

  finally
    DisEnable(Sender,True);
  end;
end;

procedure TForm1.TargetSelectionChange(Sender: TObject; User: boolean);
begin
  if (NOT User) then exit;
  SetTarget(TListBox(Sender));
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  ShowAboutForm;
end;

procedure TForm1.radgrpCPUClick(Sender: TObject);
begin
  if (radgrpCPU.ItemIndex<>-1) then
  begin
  if (radgrpCPU.Items[radgrpCPU.ItemIndex]='i8086') then
    begin
      radgrpOS.ItemIndex:=-1;
      radgrpOS.Enabled:=false;
    end
    else radgrpOS.Enabled:=true;
  end
end;

procedure TForm1.radgrpOSClick(Sender: TObject);
begin
  if (radgrpOS.ItemIndex<>-1) then
  begin
    if (radgrpOS.Items[radgrpOS.ItemIndex]=GetOS(TOS.java)) OR (radgrpOS.Items[radgrpOS.ItemIndex]=GetOS(TOS.msdos)) then
    begin
      radgrpCPU.ItemIndex:=-1;
      radgrpCPU.Enabled:=false;
    end else radgrpCPU.Enabled:=true;
  end;
end;

procedure TForm1.CommandOutputScreenMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  {$if defined(Darwin) or defined(macOS) or defined(iphonesim)}
  if ssMeta in Shift then
  {$else}
  if ssCtrl in Shift then
  {$endif}
  //if ssModifier in Shift then // as defined in controls.pp
  begin
    if (WheelDelta>0) AND (CommandOutputScreen.Font.Size<48) then CommandOutputScreen.Font.Size:=CommandOutputScreen.Font.Size+1;
    if (WheelDelta<0)  AND (CommandOutputScreen.Font.Size>2) then CommandOutputScreen.Font.Size:=CommandOutputScreen.Font.Size-1;
  end;
end;

procedure TForm1.CommandOutputScreenChange(Sender: TObject);
var
  s,searchstring:string;
  x,y:integer;
begin
  s:=CommandOutputScreen.LineText;
  //if Length(s)=0 then s:=CommandOutputScreen.Lines[CommandOutputScreen.CaretY-2];
  s:=Trim(s);
  if Length(s)=0 then exit;

  searchstring:='checking out/updating';
  if (ExistWordInString(PChar(s),searchstring,[soDown])) then
  begin
    x:=Pos(searchstring,LowerCase(s));
    if x>0 then
    begin
      x:=x+Length(searchstring);
      InternalError:=Copy(s,x+1,MaxInt);
      memoSummary.Lines.Append('Getting/updating '+InternalError);
    end;
  end;

  if (ExistWordInString(PChar(s),' native builder: ',[soDown])) OR (ExistWordInString(PChar(s),' cross-builder: ',[soDown])) then
  begin
    memoSummary.Lines.Append(s);
  end;

  // warn about time consuming module operations
  if ExistWordInString(PChar(s),'UniversalInstaller (GetModule:',[soWholeWord,soDown]) then
  begin
    searchstring:=': Getting module ';
    x:=Pos(searchstring,s);
    if x>0 then
    begin
      x:=x+Length(searchstring);
      InternalError:=Copy(s,x,MaxInt);
      memoSummary.Lines.Append(BeginSnippet + ' Getting '+InternalError+' sources ... please wait, could take some time.');
    end;
  end
  else
  begin
    // warn about time consuming FPC and Lazarus operations
    if (
      (ExistWordInString(PChar(s),'downloadfromftp',[soWholeWord,soDown]))
      OR
      (ExistWordInString(PChar(s),'checkout',[soWholeWord,soDown])) AND (ExistWordInString(PChar(s),'--quiet',[soWholeWord,soDown]))
      OR
      (ExistWordInString(PChar(s),'clone',[soWholeWord,soDown])) AND (ExistWordInString(PChar(s),'--recurse-submodules',[soWholeWord,soDown]))
    ) then
    begin
      memoSummary.Lines.Append(BeginSnippet + ' Performing a SVN/GIT/HG/FTP checkout ... please wait, could take some time.');
    end;
  end;

  if (ExistWordInString(PChar(s),'switch',[soWholeWord,soDown])) AND (ExistWordInString(PChar(s),'--quiet',[soWholeWord,soDown])) then
  begin
    memoSummary.Lines.Append(BeginSnippet + ' Performing a SVN repo URL switch ... please wait, could take some time.');
  end;

  // github error
  if (ExistWordInString(PChar(s),'429 too many requests',[soDown])) then
  begin
    memoSummary.Lines.Append('GitHub blocked us due to too many download requests.');
    memoSummary.Lines.Append('This will last for an hour, so please wait and be patient.');
    memoSummary.Lines.Append('After this period, please re-run fpcupdeluxe.');
  end;

  (*
  searchstring:='the makefile doesn''t support target';
  if (ExistWordInString(PChar(s),searchstring,[soDown])) then
  begin
    memoSummary.Lines.Append('Sorry, but you have chosen a target that is not supported (yet).');
    x:=Pos(searchstring,LowerCase(s));
    if x>0 then
    begin
      x:=x+Length(searchstring);
      InternalError:=Copy(s,x+1,MaxInt);
      x:=Pos(',',LowerCase(InternalError));
      if x=0 then x:=Pos(' ',LowerCase(InternalError));
      if x>0 then
      begin
        InternalError:=Copy(InternalError,1,x-1);
        memoSummary.Lines.Append('Wrong target: '+InternalError);
      end;
    end;
  end;
  *)

  if (ExistWordInString(PChar(s),'Error 217',[soDown])) then
  begin
    memoSummary.Lines.Append('We have a fatal FPC runtime error 217: Unhandled exception occurred.');
    memoSummary.Lines.Append('See: https://www.freepascal.org/docs-html/user/userap4.html');
    memoSummary.Lines.Append('Most common cause: a stray fpc process still running.');
    memoSummary.Lines.Append('Please check the task manager for FPC or PPC processes that are still active.');
    memoSummary.Lines.Append('Re-running fpcupdeluxe does work in most cases however !. So, just do a restart.');
    s:=
    'We have a fatal FPC runtime error 217: Unhandled exception occurred.' + sLineBreak +
    'Most common cause: a stray fpc process still running.' + sLineBreak +
    'Please check the task manager for FPC or PPC processes that are still active.' + sLineBreak +
    'This sometime happens, due to causes unknown (to me) yet.' + sLineBreak +
    'Just quiting fpcupdeluxe and running it again will result in success.';
    Application.MessageBox(PChar(s), PChar('FPC runtime error 217'), MB_ICONSTOP);
  end;

  searchstring:='make (e=';
  if (ExistWordInString(PChar(s),searchstring,[soDown])) then
  begin
    memoSummary.Lines.Append('Make has generated an error.');
    x:=Pos('): ',LowerCase(s));
    if x>0 then
    begin
      x:=x+3;
      InternalError:=Copy(s,x,MaxInt);
      memoSummary.Lines.Append('Make error: '+InternalError);
    end;

    //Get make error code
    x:=Pos(searchstring,LowerCase(s));
    if x>0 then
    begin
      x:=x+Length(searchstring);
      y:=0;
      while s[x] in ['0'..'9'] do
      begin
        y:=y*10+Ord(s[x])-$30;
        Inc(x);
      end;
      // if error=2 then most probable cause: bad checkout of sources.
      if y=2 then
      begin
        memoSummary.Lines.Append('Most probable cause: bad checkout of sources !');
        memoSummary.Lines.Append('Most successfull approach: delete sources and run again.');
      end;
    end;
  end;

  searchstring:='unable to connect to a repository at url';
  if (ExistWordInString(PChar(s),searchstring,[soDown])) then
  begin
    memoSummary.Lines.Append('SVN could not connect to the desired repository.');
    x:=Pos(searchstring,LowerCase(s));
    if x>0 then
    begin
      x:=x+Length(searchstring);
      InternalError:=Copy(s,x+1,MaxInt);
      memoSummary.Lines.Append('URL: '+InternalError);
      memoSummary.Lines.Append('Please check your connection. Or run the SVN command to try yourself:');
      memoSummary.Lines.Append(CommandOutputScreen.Lines[CommandOutputScreen.CaretY-2]);
    end;
  end;

  if (ExistWordInString(PChar(s),'error:',[soWholeWord,soDown])) OR (ExistWordInString(PChar(s),'fatal:',[soWholeWord,soDown])) then
  begin
    memoSummary.Lines.Append(BeginSnippet+' Start of compile error summary.');

    if (ExistWordInString(PChar(s),'fatal: internal error',[soDown])) then
    begin
      x:=RPos(' ',s);
      if x>0 then
      begin
        InternalError:=Copy(s,x+1,MaxInt);
        memoSummary.Lines.Append('Compiler error: '+InternalError);
        if (InternalError='2015030501') OR (InternalError='2014051001') OR (InternalError='2014050604') then
        begin
          memoSummary.Lines.Append('FPC revision 30351 introduced some changed into the compiler causing this error.');
          memoSummary.Lines.Append('Has something todo about how floating points are handled. And that has changed.');
          memoSummary.Lines.Append('See: https://svn.freepascal.org/cgi-bin/viewvc.cgi?view=revision&revision=30351');
        end;

        if (InternalError='2013051401') then
        begin
          memoSummary.Lines.Append('FPC revision 37182 breaks cross building avr-embedded.');
          memoSummary.Lines.Append('However, this has been solved in the meantime !');
          memoSummary.Lines.Append('Please update FPC trunk !!');
          //memoSummary.Lines.Append('See: https://bugs.freepascal.org/view.php?id=32418');
          //memoSummary.Lines.Append('See: https://bugs.freepascal.org/view.php?id=31925');
        end;

      end;
    end
    else if (ExistWordInString(PChar(s),'error: user defined',[soDown])) then
    begin
      x:=Pos('error: user defined',LowerCase(s));
      if x>0 then
      begin
        x:=x+Length('error: user defined');
        InternalError:=Copy(s,x+2,MaxInt);
        memoSummary.Lines.Append('Configuration error: '+InternalError);
        x:=Pos('80 bit extended floating point',LowerCase(s));
        if x>0 then
        begin
          memoSummary.Lines.Append('Please use trunk that has 80-bit float type using soft float unit !');
          memoSummary.Lines.Append('FPC revisions 37294 - 37306 and 37621 add this soft float feature.');
          memoSummary.Lines.Append('So update your FPC trunk to a revision >= 37621 !!');
          //memoSummary.Lines.Append('See: https://svn.freepascal.org/cgi-bin/viewvc.cgi?view=revision&revision=37621');
          //memoSummary.Lines.Append('See: https://bugs.freepascal.org/view.php?id=32502');
          //memoSummary.Lines.Append('See: https://bugs.freepascal.org/view.php?id=29892');
          //memoSummary.Lines.Append('See: https://bugs.freepascal.org/view.php?id=9262');
        end;
      end;
    end
    else if (ExistWordInString(PChar(s),'failed to get crossbinutils',[soDown])) then
    begin
      MissingCrossBins:=true;
      memoSummary.Lines.Append('Missing correct cross binary utilities');
    end
    else if (ExistWordInString(PChar(s),'failed to get crosslibrary',[soDown])) then
    begin
      MissingCrossLibs:=true;
      memoSummary.Lines.Append('Missing correct cross libraries');
    end
    else if ((ExistWordInString(PChar(s),'CheckAndGetTools',[soDown])) OR (ExistWordInString(PChar(s),'Required package is not installed',[soDown]))) then
    begin
      MissingTools:=true;
      {$ifdef Darwin}
      memoSummary.Lines.Append('Missing some tools: please install Xcode command line tools !');
      memoSummary.Lines.Append('xcode-select --install');
      {$else}
      memoSummary.Lines.Append('Missing some tools: please install missing tools!');
      {$endif}
    end
    else if (Pos('error: 256',lowercase(s))>0) AND (Pos('svn',lowercase(s))>0) then
    begin
      memoSummary.Lines.Append('We have had a SVN connection failure. Just start again !');
      memoSummary.Lines.Append(CommandOutputScreen.Lines[CommandOutputScreen.CaretY-2]);
    end
    else if (ExistWordInString(PChar(s),'fatal:',[soDown])) then
    begin
      memoSummary.Lines.Append(s);
      memoSummary.Lines.Append(CommandOutputScreen.Lines[CommandOutputScreen.CaretY-2]);
    end
    else if (ExistWordInString(PChar(s),'error:',[soDown])) then
    begin
      // check if "error:" at the end of the line.
      // if so:
      // the real error will follow on the next line(s).
      // and we have to wait for these lines (done somewhere else in this procedure) !!
      // if not, just print the error message.
      if (Pos('error:',lowercase(s))<>(Length(s)-Length('error:')+1)) then memoSummary.Lines.Append(s);
    end;
  end;

  //Lazbuild error
  if (ExistWordInString(PChar(s),'Unable to open the package',[soDown])) then
  begin
    memoSummary.Lines.Append(s);
    memoSummary.Lines.Append('Package source is missing. Please check your Lazarus config files.');
  end;

  // linker error
  if (ExistWordInString(PChar(s),'/usr/bin/ld: cannot find',[soDown])) then
  begin
    x:=Pos('-l',s);
    if x>0 then
    begin
      // add help into summary memo
      memoSummary.Lines.Append(BeginSnippet+' Missing library: lib'+Copy(s,x+2,MaxInt));
    end;
  end;

  // diskspace errors
  if (ExistWordInString(PChar(s),'Stream write error',[soDown])) OR (ExistWordInString(PChar(s),'disk full',[soDown])) then
  begin
    memoSummary.Lines.Append(BeginSnippet+' There is not enough diskspace to finish this operation.');
    memoSummary.Lines.Append(BeginSnippet+' Please free some space and re-run fpcupdeluxe.');
  end;

  // RAM errors
  if (ExistWordInString(PChar(s),'Can''t call the assembler',[soDown])) OR (ExistWordInString(PChar(s),'Can''t call the resource compiler',[soDown])) then
  begin
    memoSummary.Lines.Append(BeginSnippet+' Most likely, there is not enough RAM (swap) to finish this operation.');
    memoSummary.Lines.Append(BeginSnippet+' Please add some RAM or swap-space (+1GB) and re-run fpcupdeluxe.');
  end;

  // warn for time consuming help files
  if (ExistWordInString(PChar(s),'writing',[soDown])) AND (ExistWordInString(PChar(s),'pages...',[soDown])) then
  begin
    memoSummary.Lines.Append('Busy with help files. Be patient: can be time consuming !!');
  end;

  // report about correct tools that are found and used
  if (ExistWordInString(PChar(s),'found correct',[soDown])) then
  begin
    memoSummary.Lines.Append(s);
  end;

  if ExistWordInString(PChar(s),BeginSnippet,[soWholeWord,soDown]) then
  begin
    if ExistWordInString(PChar(s),'revision:',[soWholeWord,soDown]) then
    begin
      // repeat fpcupdeluxe warning
      memoSummary.Lines.Append(s);
    end;
    if ExistWordInString(PChar(s),Seriousness[etWarning],[soWholeWord,soDown]) then
    begin
      // repeat fpcupdeluxe warning
      memoSummary.Lines.Append(s);
    end;
  end;

  // go back a few lines to find a special error case
  x:=(CommandOutputScreen.CaretY-4);
  if (x>0) then
  begin
    s:=CommandOutputScreen.Lines[x];
    s:=Trim(s);
    s:=LowerCase(s);
    if Length(s)=0 then exit;
    // check if "error:" at the end of the line.
    // if so:
    // the real error will follow on the next line(s).
    // and we have to wait for these lines !!
    // if not, just print the error message (done somewhere else in this procedure).
    if (Pos('error:',s)>0) AND (Pos('error:',s)=(Length(s)-Length('error:')+1))
    then
    begin
      // print the error itself and the next 2 lines (good or lucky guess)
      memoSummary.Lines.Append(BeginSnippet+' Start of special error summary:');
      memoSummary.Lines.Append(CommandOutputScreen.Lines[x]);
      memoSummary.Lines.Append(CommandOutputScreen.Lines[x+1]);
      //temporary for trunk
      if Pos('BuildUnit_cocoaint.pp',CommandOutputScreen.Lines[x+1])>0 then
      begin
        memoSummary.Lines.Append('');
        memoSummary.Lines.Append('See: https://bugs.freepascal.org/view.php?id=32809');
        memoSummary.Lines.Append('');
      end else
      memoSummary.Lines.Append(CommandOutputScreen.Lines[x+2]);
    end;
  end;
end;

procedure TForm1.CommandOutputScreenSpecialLineMarkup(Sender: TObject; Line: integer;
  var Special: boolean; Markup: TSynSelectedColor);
var
  FG, BG: TColor;
  s:string;
begin
  s:=CommandOutputScreen.Lines[Line-1];
  s:=Trim(s);
  if Length(s)=0 then exit;

  // special override for me: for easy debugging FPC and Lazarus source with plain writelines in source
  if ExistWordInString(PChar(s),'donalf:',[soWholeWord,soDown]) then
  begin
    begin
      FG      := clBlack;
      BG      := clYellow;
      Special := True;
    end;
  end;

  if (NOT Special) AND ExistWordInString(PChar(s),BeginSnippet,[soWholeWord,soDown]) then
  begin
    if ExistWordInString(PChar(s),Seriousness[etInfo],[soWholeWord,soDown]) then
    begin
      FG      := clYellow;
      BG      := clBlack;
      Special := True;
    end;
    if ExistWordInString(PChar(s),Seriousness[etWarning],[soWholeWord,soDown]) then
    begin
      FG      := clFuchsia;
      BG      := clBlack;
      Special := True;
    end;
    if ExistWordInString(PChar(s),Seriousness[etError],[soWholeWord,soDown]) then
    begin
      FG      := clRed;
      BG      := clWhite;
      Special := True;
    end;
  end;

  if (NOT Special) AND ExistWordInString(PChar(s),'Found valid',[soWholeWord,soDown]) then
  begin
    FG      := clOlive;
    BG      := clBlack;
    Special := True;
  end;

  if (NOT Special) AND ExistWordInString(PChar(s),'executing:',[soWholeWord,soDown]) then
  begin
    FG      := clAqua;
    BG      := clBlack;
    Special := True;
  end;

  if (NOT Special) AND ((ExistWordInString(PChar(s),'A',[soWholeWord])) OR (ExistWordInString(PChar(s),'U',[soWholeWord]))) then
  begin
    FG      := clSkyBlue;
    BG      := clBlack;
    Special := True;
  end;

  if (NOT Special) AND ((ExistWordInString(PChar(s),'HEAD is now at ',[soDown])) OR (ExistWordInString(PChar(s),'Last Changed ',[soDown]))) then
  begin
    FG      := clMoneyGreen;
    BG      := clBlack;
    Special := True;
  end;

  if (NOT Special) AND ExistWordInString(PChar(s),'failed:',[soWholeWord,soDown]) then
  begin
    FG      := TColor($FF00AF); //Text Color  BGR
    BG      := clBlack;
    Special := True;
  end;

  if (NOT Special) AND ((ExistWordInString(PChar(s),'hint:',[soWholeWord,soDown])) OR (ExistWordInString(PChar(s),'note:',[soWholeWord,soDown]))) then
  begin
    FG      := clGreen;
    BG      := clBlack;
    Special := True;
  end;

  if (NOT Special) AND ((ExistWordInString(PChar(s),'warning:',[soWholeWord,soDown]))) then
  begin
    FG      := clMaroon;
    BG      := clBlack;
    Special := True;
  end;

  // linker error
  if (NOT Special) AND (ExistWordInString(PChar(s),'/usr/bin/ld: cannot find',[soDown])) then
  begin
    FG      := clRed;
    BG      := clNavy;
    Special := True;
  end;

  // diskspace error
  if (NOT Special) AND ((ExistWordInString(PChar(s),'Stream write error',[soDown])) OR (ExistWordInString(PChar(s),'disk full',[soDown]))) then
  begin
    FG      := clRed;
    BG      := clAqua;
    Special := True;
  end;

  // github error
  if (NOT Special) AND (ExistWordInString(PChar(s),'429 too many requests',[soDown])) then
  begin
    FG      := clRed;   //Text Color
    BG      := clNavy;  //BackGround
    Special := True;    //Must be true
  end;

  // makefile and help warnings
  if (NOT Special)
  AND
  (
    (ExistWordInString(PChar(s),'lines compiled,',[soDown]))
    OR
    (ExistWordInString(PChar(s),'issued',[soWholeWord,soDown]))
    OR
    (ExistWordInString(PChar(s),'Target OS: ',[soDown]))
    OR
    (ExistWordInString(PChar(s),'make.exe: ',[soDown]))
    OR
    (ExistWordInString(PChar(s),'make: ',[soDown]))
    OR
    (ExistWordInString(PChar(s),'make[',[soDown]))
    OR
    (ExistWordInString(PChar(s),'dependency dropped',[soDown]))
    OR
    ( ExistWordInString(PChar(s),'echo ',[soDown]) AND ExistWordInString(PChar(s),'revision.inc',[soDown]) )
    OR
    ( ExistWordInString(PChar(s),'Start ',[soDown]) AND ExistWordInString(PChar(s),'now ',[soDown]) )
    OR
    (ExistWordInString(PChar(s),'this could take some time',[soDown]))
    OR
    (ExistWordInString(PChar(s),'Skipped package',[soWholeWord,soDown]))
    OR
    (
      (ExistWordInString(PChar(s),'writing',[soDown]))
      AND
      (ExistWordInString(PChar(s),'pages...',[soDown]))
    )
  )
  then
  begin
    FG      := TColor($AF10FF); //Text Color  BGR
    BG      := clBlack;
    Special := True;
  end;

  // svn connection error
  if (NOT Special) AND (ExistWordInString(PChar(s),'unable to connect to a repository at url',[soDown])) then
  begin
    FG      := clRed;
    BG      := clNavy;
    Special := True;
  end;

  if (NOT Special) AND ExistWordInString(PChar(s),'svn: e',[soDown]) then
  begin
    FG      := clFuchsia;
    BG      := clBlack;
    Special := True;
  end;

  if (ExistWordInString(PChar(s),'make (e=',[soDown])) then
  begin
    // make fatal messages ...
    begin
      FG      := clRed;
      BG      := clBlue;
      Special := True;
    end;
  end;

  if (NOT Special) AND (ExistWordInString(PChar(s),'make.exe ',[soDown]) OR ExistWordInString(PChar(s),'make ',[soDown]) OR ExistWordInString(PChar(s),'gmake ',[soDown])) then
  begin
    if ExistWordInString(PChar(s),'fpmake ',[soDown]) then
      FG      := TColor($FFA000)
    else
      FG      := TColor($FF8C00);
    BG      := clBlack;
    Special := True;
  end;

  if (NOT Special) AND ExistWordInString(PChar(s),'start compiling package',[soDown]) then
  begin
    FG      := TColor($FFA000);
    BG      := clBlack;
    Special := True;
  end;

  if (NOT Special) AND ExistWordInString(PChar(s),'success:',[soWholeWord,soDown]) then
  begin
    FG      := TColor($00D7FF);
    BG      := clBlack;
    Special := True;
  end;


  if (NOT Special) AND (ExistWordInString(PChar(s),'compiled package',[soDown]) OR ExistWordInString(PChar(s),'succeeded',[soDown]) OR ExistWordInString(PChar(s),'completed',[soDown])) then
  begin
    FG      := TColor($00A5FF);
    BG      := clBlack;
    Special := True;
  end;

  if (NOT Special) AND ExistWordInString(PChar(s),'Extracted #',[soDown]) then
  begin
    BG      := clBlack;
    FG      := clSilver;
    Special := True;
  end;

  if (NOT Special) AND ExistWordInString(PChar(s),'Download progress ',[soDown]) then
  begin
    BG      := clBlack;
    FG      := TColor($0045FF);
    Special := True;
  end;

  // special override for debugging statemachine
  if ExistWordInString(PChar(s),'sequencer',[soWholeWord,soDown]) then
  begin
    begin
      FG      := clRed;
      BG      := clBlack;
      Special := True;
    end;
  end;

  // lazbuild error
  if (NOT Special) AND (ExistWordInString(PChar(s),'Unable to open the package',[soDown]) OR ExistWordInString(PChar(s),'Unable to load package',[soDown])) then
  begin
    FG      := clRed;
    BG      := clPurple;
    Special := True;
  end;

  if (ExistWordInString(PChar(s),'error:',[soWholeWord,soDown])) OR (ExistWordInString(PChar(s),'fatal:',[soWholeWord,soDown])) OR (ExistWordInString(PChar(s),'Memory warning:',[soWholeWord,soDown])) then
  begin
    // skip git fatal messages ... they are not that fatal ... but not sure yet !
    // if (Pos('fatal: not a git repository',lowercase(s))=0) then
    begin
      FG      := clRed;
      BG      := clBlue;
      Special := True;
    end;
  end;

  if Special then
  begin
    Markup.Background:=BG;
    Markup.Foreground:=FG;
  end;

  {$ifdef usealternateui}
  if Special
     then alternateui_AddMessage(s,false,FG)
     else alternateui_AddMessage(s,false,clLime);
  {$endif}
end;

procedure TForm1.PageControl1Change(Sender: TObject);
var
  aFileList:TStringList;
begin
  if TPageControl(Sender).ActivePage=TagSheet then
  begin
    Application.ProcessMessages;
    aFileList:=TStringList.Create;
    ListBoxFPCTargetTag.Items.BeginUpdate;
    ListBoxLazarusTargetTag.Items.BeginUpdate;
    try
      aFileList.Clear;
      GetSVNFileList(FPCBASESVNURL+'/cgi-bin/viewvc.cgi/tags/?root=fpc',aFileList);
      ListBoxFPCTargetTag.Items.Text:=aFileList.Text;
      aFileList.Clear;
      GetSVNFileList(FPCBASESVNURL+'/cgi-bin/viewvc.cgi/tags/?root=lazarus',aFileList);
      ListBoxLazarusTargetTag.Items.Text:=aFileList.Text;
    finally
      aFileList.Free;
      ListBoxLazarusTargetTag.Items.EndUpdate;
      ListBoxFPCTargetTag.Items.EndUpdate;
    end;
    //Do this only once !!
    TPageControl(Sender).OnChange:=nil;
  end;
end;

procedure TForm1.OnlyTagClick(Sender: TObject);
var
  aNewURL:string;
begin
  if Sender=BitBtnFPCOnlyTag then
  begin
    aNewURL:=FPCBASESVNURL+'/svn/fpc/tags/'+ListBoxFPCTargetTag.GetSelectedText;
    if SetAlias('fpcURL',ListBoxFPCTargetTag.GetSelectedText,aNewURL) then
    begin
      ListBoxFPCTarget.Items.CommaText:=installerUniversal.GetAlias('fpcURL','list');
      MemoAddTag.Lines.Clear;
      MemoAddTag.Lines.Add('The tag with name ['+ListBoxFPCTargetTag.GetSelectedText+'] and URL ['+aNewURL+'] was added to the bottom of the FPC list.');
      //ListBoxFPCTarget.ItemIndex:=ListBoxFPCTarget.Count-1;
    end;
  end;
  if Sender=BitBtnLazarusOnlyTag then
  begin
    aNewURL:=FPCBASESVNURL+'/svn/lazarus/tags/'+ListBoxLazarusTargetTag.GetSelectedText;
    if SetAlias('lazURL',ListBoxLazarusTargetTag.GetSelectedText,aNewURL) then
    begin
      ListBoxLazarusTarget.Items.CommaText:=installerUniversal.GetAlias('lazURL','list');
      MemoAddTag.Lines.Clear;
      MemoAddTag.Lines.Add('The tag with name ['+ListBoxLazarusTargetTag.GetSelectedText+'] and URL ['+aNewURL+'] was added to the bottom of the Lazarus list.');
      //ListBoxLazarusTarget.ItemIndex:=ListBoxLazarusTarget.Count-1;
    end;
  end;
end;

procedure TForm1.TagSelectionChange(Sender: TObject;User: boolean);
begin
  MemoAddTag.Lines.Clear;
  MemoAddTag.Lines.Add(TListBox(Sender).GetSelectedText);
end;

procedure TForm1.btnUpdateLazarusMakefilesClick(Sender: TObject);
begin
end;

procedure TForm1.actFileSaveAccept(Sender: TObject);
begin
  CommandOutputScreen.Lines.SaveToFile(actFileSave.Dialog.FileName);
end;

procedure TForm1.QuickBtnClick(Sender: TObject);
var
  s:string;
begin

  DisEnable(Sender,False);
  try
    PrepareRun;

    if Sender=TrunkBtn then
    begin
      s:='Going to install both FPC trunk and Lazarus trunk';
      FPCTarget:='trunk';
      LazarusTarget:='trunk';
    end;

    {
    if Sender=NPBtn then
    begin
      s:='Going to install NewPascal release';
      FPCTarget:='newpascalgit';
      //FPCBranch:='release';
      LazarusTarget:='newpascalgit';
      //LazarusBranch:='release';
      //FPCupManager.IncludeModules:='mORMot';
    end;
    }

    if Sender=FixesBtn then
    begin
      s:='Going to install FPC fixes and Lazarus fixes';
      FPCTarget:='fixes';
      LazarusTarget:='fixes';
    end;

    if Sender=StableBtn then
    begin
      s:='Going to install FPC stable and Lazarus stable';
      FPCTarget:='stable';
      LazarusTarget:='stable';
    end;

    if Sender=OldBtn then
    begin
      s:='Going to install FPC 2.6.4 and Lazarus 1.4 ';
      FPCTarget:='2.6.4';
      LazarusTarget:='1.4';
    end;

    {
    if Sender=DinoBtn then
    begin
      s:='Going to install FPC 2.0.2 and Lazarus 0.9.16 ';
      FPCTarget:='2.0.2';
      //LazarusTarget:='0.9.4';
      LazarusTarget:='0.9.16';
      FPCupManager.OnlyModules:=_FPC+','+_LAZARUSSIMPLE;
    end;
    }

    if Sender=EmbeddedBtn then
    begin
      s:='Going to install FPC and Lazarus for SAM embedded ';
      FPCTarget:='embedded';
      LazarusTarget:='embedded';
      //FPCupManager.IncludeModules:='mbf,pxl';
      FPCupManager.IncludeModules:='mbf';
    end;

    if Sender=mORMotBtn then
    begin
      s:='Going to install the mORMot ';
      FPCupManager.OnlyModules:='mORMot';
      //FPCupManager.OnlyModules:='mORMot,zeos';
    end;

    if Sender=OPMBtn then
    begin
      s:='Going to install the Online Package Manager ';
      FPCupManager.OnlyModules:='opm';
      //FPCupManager.OnlyModules:='mORMot,zeos';
    end;


    FPCupManager.FPCURL:=FPCTarget;
    FPCupManager.LazarusURL:=LazarusTarget;

    if (NOT Form2.IncludeHelp) then
    begin
      if Length(FPCupManager.SkipModules)>0 then FPCupManager.SkipModules:=FPCupManager.SkipModules+',';
      FPCupManager.SkipModules:=FPCupManager.SkipModules+_HELPFPC+','+_HELPLAZARUS;
    end
    else
    begin
      if Length(FPCupManager.IncludeModules)>0 then FPCupManager.IncludeModules:=FPCupManager.IncludeModules+',';
      FPCupManager.IncludeModules:=FPCupManager.IncludeModules+_LHELP;
    end;

    AddMessage(s+'.');

    sStatus:=s;

    {$ifdef RemoteLog}
    aDataClient.UpInfo.UpFunction:=ufInstallFPCLAZ;
    {$endif}

    RealRun;

  finally
    DisEnable(Sender,True);
  end;
end;

procedure TForm1.btnInstallModuleClick(Sender: TObject);
var
  //i:integer;
  modules:string;
begin
  //Form3.ShowModal;

  DisEnable(Sender,False);

  //for i:=1 to 100 do
  try
    if listModules.SelCount=0 then
    begin
      AddMessage('Please select a module / package.');
      exit;
    end;

    PrepareRun;

    FPCupManager.ExportOnly:=(NOT Form2.PackageRepo);

    modules:='';

    //No multi-select for now
    (*
    for i:=0 to listModules.Count-1 do
    begin
      if listModules.Selected[i] then
      begin
        modules:=modules+listModules.Items[i];
        if Sender=btnUninstallModule then modules:=modules+_UNINSTALL;
        modules:=modules+',';
        {$ifdef RemoteLog}
        aDataClient.AddExtraData('module'+InttoStr(i),listModules.Items[i]);
        {$endif}
      end;
    end;
    *)

    //Single select
    if (listModules.ItemIndex<>-1) then
    begin
      modules:=listModules.Items.Strings[listModules.ItemIndex];
      if Sender=btnUninstallModule then modules:=modules+_UNINSTALL else
      begin
        if Form2.UpdateOnly then modules:=modules+_BUILD+_ONLY;
      end;
      {$ifdef RemoteLog}
      aDataClient.AddExtraData('module'+InttoStr(1),modules);
      {$endif}
    end;

    if Length(modules)>0 then
    begin
      //Delete stale trailing comma, if any
      if RightStr(modules,1)=',' then SetLength(modules,Length(modules)-1);
      FPCupManager.OnlyModules:=modules;

      if Sender=btnInstallModule then
      begin
        AddMessage('Limiting installation/update to '+FPCupManager.OnlyModules);
        AddMessage('');
        AddMessage('Going to install selected modules with given options.');
        sStatus:='Going to install/update selected modules.';
        {$ifdef RemoteLog}
        aDataClient.UpInfo.UpFunction:=ufInstallModule;
        {$endif}
      end
      else
      begin
        AddMessage('Going to remove selected modules.');
        sStatus:='Going to remove selected modules.';
        {$ifdef RemoteLog}
        aDataClient.UpInfo.UpFunction:=ufUninstallModule;
        {$endif}
      end;

      RealRun;

      (*
      AddMessage('Run: '+modules+InttoStr(i));
      if (NOT RealRun) then
      begin
        break;
      end;
      *)

    end;

  finally
    FPCupManager.ExportOnly:=(NOT Form2.Repo);
    DisEnable(Sender,True);
  end;
end;

procedure TForm1.btnInstallDirSelectClick(Sender: TObject);
begin
  SelectDirectoryDialog1.InitialDir:=sInstallDir;
  if SelectDirectoryDialog1.Execute then
  begin
    sInstallDir:=SelectDirectoryDialog1.FileName;
    InstallDirEdit.Text:=sInstallDir;
  end;
end;

function TForm1.ButtonProcessCrossCompiler(Sender: TObject):boolean;
var
  BinsFileName,LibsFileName,DownloadURL,TargetFile,TargetPath,BinPath,LibPath,UnZipper,s:string;
  success,verbose:boolean;
  IncludeLCL,ZipFile:boolean;
  i:integer;
  MajorVersion,MinorVersion:integer;
  aList: TStringList;
  BaseBinsURL:string;
  BinsURL,LibsURL:string;
begin
  result:=false;

  if (radgrpCPU.ItemIndex=-1) and (radgrpOS.ItemIndex=-1) then
  begin
    if Sender<>nil then ShowMessage('Please select a CPU and OS target first');
    exit;
  end;

  // the below three checks are just temporary and rough
  // we should use the array OSCPUSupported : array[TOS,TCpu] of boolean

  success:=true;
  if radgrpOS.ItemIndex<>-1 then
  begin
    s:=radgrpOS.Items[radgrpOS.ItemIndex];
    if s=GetOS(TOS.embedded) then
    begin
      if radgrpCPU.ItemIndex<>-1 then
      begin
        s:=radgrpCPU.Items[radgrpCPU.ItemIndex];
        if (s<>GetCPU(TCPU.avr)) and (s<>GetCPU(TCPU.arm)) and (s<>GetCPU(TCPU.aarch64)) and (s<>GetCPU(TCPU.mipsel)) then
        begin
          success:=false;
        end;
      end else success:=false;
    end;
  end;

  if (NOT success) then
  begin
    if Sender<>nil then ShowMessage('No valid CPU target for embedded.');
    exit;
  end;

  success:=true;
  if radgrpOS.ItemIndex<>-1 then
  begin
    s:=radgrpOS.Items[radgrpOS.ItemIndex];
    if s=GetOS(TOS.android) then
    begin
      if radgrpCPU.ItemIndex<>-1 then
      begin
        s:=radgrpCPU.Items[radgrpCPU.ItemIndex];
        if (s<>GetCPU(TCPU.i386)) and (s<>GetCPU(TCPU.arm)) and (s<>GetCPU(TCPU.mipsel)) and (s<>GetCPU(TCPU.jvm)) and (s<>GetCPU(TCPU.aarch64)) and (s<>'x8664') and (s<>GetCPU(TCPU.x86_64)) then
        begin
          success:=false;
        end;
      end else success:=false;
    end;
  end;

  if (NOT success) then
  begin
    if Sender<>nil then ShowMessage('No valid CPU target for android.');
    exit;
  end;

  success:=true;
  if radgrpCPU.ItemIndex<>-1 then
  begin
    s:=radgrpCPU.Items[radgrpCPU.ItemIndex];
    if s='jvm' then
    begin
      if radgrpOS.ItemIndex<>-1 then
      begin
        s:=radgrpOS.Items[radgrpOS.ItemIndex];
        if (s<>GetOS(TOS.android)) and (s<>GetOS(TOS.java)) then
        begin
          success:=false;
        end;
      end else success:=false;
    end;
  end;

  if (NOT success) then
  begin
    if Sender<>nil then ShowMessage('No valid OS target for jvm.');
    exit;
  end;

  success:=true;
  if radgrpOS.ItemIndex<>-1 then
  begin
    s:=radgrpOS.Items[radgrpOS.ItemIndex];
    if s='dragonfly' then
    begin
      if radgrpCPU.ItemIndex<>-1 then
      begin
        s:=radgrpCPU.Items[radgrpCPU.ItemIndex];
        if (s<>GetCPU(TCPU.x86_64)) then
        begin
          success:=false;
        end;
      end else success:=false;
    end;
  end;

  if (NOT success) then
  begin
    if Sender<>nil then ShowMessage('No valid CPU target for dragonfly.');
    exit;
  end;



  // OS=amiga) AND (CPU<>m68k))
  // OS=morphos) AND (CPU<>powerpc))




  PrepareRun;

  if radgrpCPU.ItemIndex<>-1 then
  begin
    s:=radgrpCPU.Items[radgrpCPU.ItemIndex];
    FPCupManager.CrossCPU_Target:=GETTCPU(s);
  end;

  if radgrpOS.ItemIndex<>-1 then
  begin
    s:=radgrpOS.Items[radgrpOS.ItemIndex];
    if s='i-sim' then FPCupManager.CrossOS_Target:=TOS.iphonesim;
    if s='linux-musl' then
    begin
      FPCupManager.MUSL:=true;
      FPCupManager.CrossOS_Target:=TOS.linux;
    end;

    if s='solaris-oi' then
    begin
      FPCupManager.SolarisOI:=true;
      FPCupManager.CrossOS_Target:=TOS.solaris;
    end;

    //rename windows target os to the correct FPC target os
    if s='windows' then
    begin
      if FPCupManager.CrossCPU_Target=TCPU.i386 then FPCupManager.CrossOS_Target:=TOS.win32;
      if FPCupManager.CrossCPU_Target=TCPU.x86_64 then FPCupManager.CrossOS_Target:=TOS.win64;
      if FPCupManager.CrossCPU_Target=TCPU.aarch64 then FPCupManager.CrossOS_Target:=TOS.win64;
    end;

    if FPCupManager.CrossOS_Target=TOS.osNone then FPCupManager.CrossOS_Target:=GetTOS(s);
  end;

  {$ifdef Linux}
  if FPCupManager.MUSL then
  begin

    {$ifdef CPUX86_64}
    if FPCupManager.CrossCPU_Target=TCPU.x86_64 then
    begin
      if Sender<>nil then Application.MessageBox(PChar('On Linux x86_64, you cannot cross towards another Linux x86_64.'), PChar('FPC limitation'), MB_ICONERROR);
      FPCupManager.CrossOS_Target:=TOS.osNone; // cleanup
      FPCupManager.CrossCPU_Target:=TCPU.cpuNone; // cleanup
      exit;
    end;
    {$endif}

    {$ifdef CPUX86}
    if FPCupManager.CrossCPU_Target=TCPU.i386 then
    begin
      if Sender<>nil then Application.MessageBox(PChar('On Linux i386, you cannot cross towards another Linux i386.'), PChar('FPC limitation'), MB_ICONERROR);
      FPCupManager.CrossOS_Target:=TOS.osNone; // cleanup
      FPCupManager.CrossCPU_Target:=TCPU.cpuNone; // cleanup
      exit;
    end;
    {$endif}

  end;
  {$endif}

  if (FPCupManager.CrossOS_Target=TOS.java) then FPCupManager.CrossCPU_Target:=TCPU.jvm;
  if (FPCupManager.CrossOS_Target=TOS.msdos) then FPCupManager.CrossCPU_Target:=TCPU.i8086;
  //For i8086 embedded and win16 are also ok, but not [yet] implemented by fpcupdeluxe
  if (FPCupManager.CrossCPU_Target=TCPU.i8086) then FPCupManager.CrossOS_Target:=TOS.msdos;
  if (FPCupManager.CrossOS_Target=TOS.go32v2) then FPCupManager.CrossCPU_Target:=TCPU.i386;
  if (FPCupManager.CrossOS_Target=TOS.dragonfly) then FPCupManager.CrossCPU_Target:=TCPU.x86_64;

  if (FPCupManager.CrossCPU_Target=TCPU.cpuNone) then
  begin
    if Sender<>nil then Application.MessageBox(PChar('Please select a CPU target first.'), PChar('CPU error'), MB_ICONERROR);
    exit;
  end;

  if (FPCupManager.CrossOS_Target=TOS.osNone) then
  begin
    if Sender<>nil then Application.MessageBox(PChar('Please select an OS target first.'), PChar('OS error'), MB_ICONERROR);
    exit;
  end;

  if (NOT FPCupManager.CheckValidCPUOS) then
  begin
    memoSummary.Lines.Append('');
    memoSummary.Lines.Append('FPC source (fpmkunit.pp): No valid CPU / OS target.');
    memoSummary.Lines.Append('Cross-building will continue, but with great changes of errors !!');
  end;

  if assigned(CrossInstallers) then
  begin
    success:=false;
    for i := 0 to CrossInstallers.Count - 1 do
    begin
      success:=( (TCrossInstaller(CrossInstallers.Objects[i]).TargetCPU=FPCupManager.CrossCPU_Target) AND (TCrossInstaller(CrossInstallers.Objects[i]).TargetOS=FPCupManager.CrossOS_Target) );
      if success then break;
    end;
    if (NOT success) then
    begin
      if Sender<>nil then
      begin
        Application.MessageBox(PChar('No valid CPU / OS crosscompiler found.'), PChar('FPCUPDELUXE Limitation'), MB_ICONERROR);
      end
      else
      begin
        memoSummary.Lines.Append('');
        memoSummary.Lines.Append('FPCUPDELUXE Limitation: No valid CPU / OS crosscompiler found. Skipping');
        memoSummary.Lines.Append('FPCUPDELUXE Limitation: You could do a feature request !');
      end;
      FPCupManager.CrossOS_Target:=TOS.osNone; // cleanup
      FPCupManager.CrossCPU_Target:=TCPU.cpuNone; // cleanup
      exit;
    end;
  end;

  {$ifdef RemoteLog}
  aDataClient.UpInfo.CrossCPUOS:=GetOS(FPCupManager.CrossOS_Target)+'-'+GetCPU(FPCupManager.CrossCPU_Target);
  {$endif}

  if Sender=ButtonRemoveCrossCompiler then
  begin
    DisEnable(Sender,False);
    try
      // todo: setting of subarch when removing embedded compiler
      FPCupManager.OnlyModules:=_LCLALLREMOVEONLY+','+_FPCREMOVEONLY;
      {$ifdef RemoteLog}
      aDataClient.UpInfo.UpFunction:=ufUninstallCross;
      {$endif}
      success:=RealRun;
      if success then
        Form2.SetCrossAvailable(FPCupManager.CrossCombo_Target,false);
    finally
      DisEnable(Sender,true);
    end;
  end
  else
  begin
    if Sender<>nil then
    begin
      {$if (defined(UNIX)) and (not defined(Darwin))}
      if (FPCupManager.CrossOS_Target=TOS.darwin) OR ( (FPCupManager.CrossOS_Target=TOS.win64) AND (FPCupManager.CrossCPU_Target=TCPU.aarch64) ) then
      begin
        success:=false;
        s:=Which('clang');
        if FileExists(s) then success:=CheckExecutable(s, ['-v'], '');
        if (NOT success) then
        begin
          s:=
          'Clang cannot be found !!'+ sLineBreak +
          'Clang need to be installed to be able to cross-compile towards '+GetOS(FPCupManager.CrossOS_Target)+' !'+ sLineBreak +
          'Install clang and retry !!';
          Application.MessageBox(PChar(s), PChar('Missing clang'), MB_ICONERROR);
          memoSummary.Lines.Append('');
          memoSummary.Lines.Append('To get clang: sudo apt-get install clang');
          exit;
        end;
      end;
      if (FPCupManager.CrossOS_Target=TOS.wince) then
      begin
        (*
        success:=CheckExecutable('gcc', '-v', '');
        if (NOT success) then
        begin
          s:=
          'Gcc cannot be found !!'+ sLineBreak +
          'Gcc need to be installed to be able to cross-compile towards wince !'+ sLineBreak +
          'Install gcc and retry !!';
          Application.MessageBox(PChar(s), PChar('Missing gcc'), MB_ICONERROR);
          memoSummary.Lines.Append('');
          memoSummary.Lines.Append('To get gcc: sudo apt-get install gcc');
          //memoSummary.Lines.Append('Cross-building will continue, but with great changes of winres errors !!');
          exit;
        end;
        *)
        (*
        {$ifdef CPU64}
        if (NOT FileExists('/lib/ld-linux-x86-64.so.2')) then
        begin
          s:=
          'The current wince binutils need /lib/ld-linux-x86-64.so.2 !' + sLineBreak +
          'If so, add this symlink and point it towards /lib/x86_64-linux-gnu/ld-2.24.so' + sLineBreak +
          'sudo ln -s /lib/x86_64-linux-gnu/ld-2.24.so /lib/ld-linux-x86-64.so.2';
          Application.MessageBox(PChar(s), PChar('Dynamic linker/loader'), MB_ICONWARNING);
          memoSummary.Lines.Append('');
          memoSummary.Lines.Append(s);
        end;
        {$endif}
        *)
      end;
      {$endif}

      if (FPCupManager.CrossOS_Target=TOS.java) then
      begin
        success:=CheckJava;
        if (NOT success) then
        begin
          s:=
          'Java cannot be found !!'+ sLineBreak +
          'Java need to be installed to be able to cross-compile towards java !'+ sLineBreak +
          'Install java and retry !!';
          Application.MessageBox(PChar(s), PChar('Missing java'), MB_ICONERROR);
          {$ifdef Linux}
          memoSummary.Lines.Append('');
          memoSummary.Lines.Append('To get java: sudo apt-get install default-jre');
          {$endif}
          exit;
        end;
      end;

      {$ifndef BSD}
      if (FPCupManager.CrossOS_Target=TOS.freebsd) OR (FPCupManager.CrossOS_Target=TOS.netbsd) OR (FPCupManager.CrossOS_Target=TOS.openbsd) then
      begin
        if (MessageDlg('Be forwarned: this will only work with FPC>=3.0.2 (trunk, NewPascal, fixes, stable).' + sLineBreak +
                   'See: https://bugs.freepascal.org/view.php?id=30908' + sLineBreak +
                   'Do you want to continue ?'
                   ,mtConfirmation,[mbYes, mbNo],0)<>mrYes) then
                   begin
                     memoSummary.Lines.Append('See: https://bugs.freepascal.org/view.php?id=30908');
                     exit;
                   end;
      end;
      {$endif}

      s:='';
      if (FPCupManager.CrossOS_Target=TOS.aix)
      then
      begin
        s:='Be forwarned: this will only work with FPC 3.0 and later.' + sLineBreak +
           'Do you want to continue ?';
      end;
      if (FPCupManager.CrossCPU_Target=TCPU.aarch64)
      {$ifdef MSWINDOWS}OR (FPCupManager.CrossOS_Target=TOS.darwin){$endif}
      OR (FPCupManager.CrossOS_Target=TOS.msdos)
      OR (FPCupManager.CrossOS_Target=TOS.haiku)
      then
      begin
        s:='Be forwarned: this will only work with FPC 3.2 / embedded / trunk.' + sLineBreak +
           'Do you want to continue ?';
      end;
      if ((FPCupManager.CrossCPU_Target=TCPU.aarch64) {OR (FPCupManager.CrossCPU_Target=TCPU.i386)} OR (FPCupManager.CrossCPU_Target=TCPU.x86_64)) AND (FPCupManager.CrossOS_Target=TOS.android)
      then
      begin
        s:='Be forwarned: this will only work with trunk.' + sLineBreak +
           'Do you want to continue ?';
      end;

      {$ifdef Linux}
      if ((FPCupManager.CrossCPU_Target=TCPU.mips) OR (FPCupManager.CrossCPU_Target=TCPU.mipsel))
      then
      begin
        s:='You could get the native cross-utilities first (advised).' + sLineBreak +
           'E.g.: sudo apt-get install libc6-mips-cross binutils-mips-linux-gnu' + sLineBreak +
           'Do you want to continue ?';
      end;
      {$endif}

      if length(s)>0 then
      begin
        if (MessageDlg(s,mtConfirmation,[mbYes, mbNo],0)<>mrYes) then
        begin
          exit;
        end;
      end;
    end;

    DisEnable(Sender,False);

    try

      //arm predefined settings
      if (FPCupManager.CrossCPU_Target=TCPU.arm) AND (FPCupManager.CrossOS_Target<>TOS.embedded) then
      begin
        // default: armhf
        // don't worry: this -dFPC_ARMHF option will still build a normal ppcrossarm for all targets
        // adding this option will allow ppcrossarm compiler to generate ARMHF for Linux
        // but I stand corrected if this assumption is wrong
        s:=Form2.GetCrossARMFPCStr(FPCupManager.CrossCPU_Target,FPCupManager.CrossOS_Target);
        if Length(s)=0 then
          FPCupManager.FPCOPT:='-dFPC_ARMHF '
        else
          FPCupManager.FPCOPT:=s+' ';

        if (FPCupManager.CrossOS_Target=TOS.wince) then
        begin
          //Disable for now : setting ARMV6 or higher gives problems with FPC 3.0.4 and lower
          //FPCupManager.CrossOPT:='-CpARMV6 ';
        end
        else
        if (FPCupManager.CrossOS_Target=TOS.darwin) then
        begin
          FPCupManager.CrossOPT:='-CpARMV7 -CfVFPV3 ';
        end
        else
        begin
          if (FPCupManager.CrossOS_Target<>TOS.android) then
          begin
            if Pos('-dFPC_ARMHF',FPCupManager.FPCOPT)>0 then
              FPCupManager.CrossOPT:='-Cp'+DEFAULTARMCPU+' -CfVFPV3 -OoFASTMATH -CaEABIHF '
            else
              FPCupManager.CrossOPT:='-Cp'+DEFAULTARMCPU+' -CfVFPV3 -OoFASTMATH ';
          end;
        end;
      end;

      //android predefined settings
      if (FPCupManager.CrossOS_Target=TOS.android) then
      begin
        if (FPCupManager.CrossCPU_Target=TCPU.i386) then
        begin
          FPCupManager.CrossOPT:='-CfSSSE3 ';
        end;
        if (FPCupManager.CrossCPU_Target=TCPU.x86_64) then
        begin
          FPCupManager.CrossOPT:='-CfSSE42 ';
        end;
        if (FPCupManager.CrossCPU_Target=TCPU.arm) then
        begin
          // Use hard floats, using armeabi-v7a Android ABI.
          // Note: do not use -CaEABIHF on Android, to not use
          // armeabi-v7a-hard ABI. Reasons:
          // - armeabi-v7a-hard ABI is not adviced anymore by Google,
          //   see "ARM Hard Float ABI Removal" on
          //   https://android.googlesource.com/platform/ndk/+/353e653824b79c43b948429870d0abeedebde386/docs/HardFloatAbi.md
          // - it prevents calling functions from libraries not using
          //   armeabi-v7a-hard ABI (but only using armeabi-v7a) like
          //   http://repo.or.cz/openal-soft/android.git or
          //   https://github.com/michaliskambi/tremolo-android .
          FPCupManager.CrossOPT:='-Cp'+DEFAULTARMCPU+' -CfVFPV3_D16 ';
        end;
      end;

      //embedded predefined settings
      if (FPCupManager.CrossOS_Target=TOS.embedded) then
      begin
        if (FPCupManager.CrossCPU_Target=TCPU.avr) then
        begin
          FPCupManager.FPCOPT:='-O2 ';
          // for Uno (ATMega328P) use avr5
          // for Mega (ATMega2560) use avr6
          FPCupManager.CrossOPT:='-Cpavr5 ';
          FPCupManager.CrossOS_SubArch:='avr5';
        end;
        if (FPCupManager.CrossCPU_Target=TCPU.arm) then
        begin
          s:=Form2.GetCrossARMFPCStr(FPCupManager.CrossCPU_Target,FPCupManager.CrossOS_Target);
          if Length(s)=0 then
            FPCupManager.FPCOPT:='-dFPC_ARMHF '
          else
            FPCupManager.FPCOPT:=s+' ';
          FPCupManager.CrossOS_SubArch:='armv6m';
        end;
        {
        if (FPCupManager.CrossCPU_Target=TCPU.aarch64) then
        begin
          s:=Form2.GetCrossARMFPCStr(FPCupManager.CrossCPU_Target,FPCupManager.CrossOS_Target);
          if Length(s)=0 then
            FPCupManager.FPCOPT:='-dFPC_ARMHF '
          else
            FPCupManager.FPCOPT:=s+' ';
          FPCupManager.CrossOS_SubArch:='armv6m';
        end;
        }
        if (FPCupManager.CrossCPU_Target=TCPU.mipsel) then
        begin
          FPCupManager.CrossOPT:='-Cpmips32 ';
          FPCupManager.CrossOS_SubArch:='pic32mx';
        end;
      end;

      //freertos predefined settings
      if (FPCupManager.CrossOS_Target=TOS.freertos) then
      begin
        if (FPCupManager.CrossCPU_Target=TCPU.xtensa) then
        begin
          FPCupManager.CrossOPT:='-Cplx6 -Cfhard ';
          FPCupManager.CrossOS_SubArch:='lx6';
        end;
      end;

      //msdos predefined settings
      if (FPCupManager.CrossOS_Target=TOS.msdos) then
      begin
        if (FPCupManager.CrossCPU_Target=TCPU.i8086) then
        begin
          {$IFDEF DARWIN}
          FPCupManager.CrossOPT:='-WmLarge ';
          {$ELSE}
          FPCupManager.CrossOPT:='-WmMedium ';
          {$ENDIF DARWIN}
        end;
      end;

      //ppc64 predefined settings
      if (FPCupManager.CrossCPU_Target=TCPU.powerpc64) then
      begin
        if ((FPCupManager.CrossOS_Target=TOS.linux)) then
        begin
          // for now, little endian only on Linux (IBM CPU's) !!
          FPCupManager.CrossOPT:='-Cb- -Caelfv2 ';
        end;
      end;

      //freebsd predefined settings
      if (FPCupManager.CrossOS_Target=TOS.freebsd) then
      begin
        //This is already done in the FPC installer itself.
        //To be checked if that is the right choice.
        //FPCupManager.CrossOPT:='-dFPC_USE_LIBC ';
      end;

      // recheck / override / set custom FPC options by special user input through setup+
      s:=Form2.FPCOptions;
      s:=Trim(s);
      if Length(s)>0 then
      begin
        FPCupManager.FPCOPT:=s+' ';
      end;

      // override / set custom FPC crossoptions by special user input through setup+
      s:=Form2.GetCrossBuildOptions(FPCupManager.CrossCPU_Target,FPCupManager.CrossOS_Target);
      s:=Trim(s);
      if Length(s)>0 then FPCupManager.CrossOPT:=s+' ';

      // override / set custom FPC cross-subarch by special user input through setup+
      if (FPCupManager.CrossOS_Target=TOS.embedded) then
      begin
        s:=Form2.GetCrossSubArch(FPCupManager.CrossCPU_Target,FPCupManager.CrossOS_Target);
        s:=Trim(s);
        if Length(s)>0 then FPCupManager.CrossOS_SubArch:=s;

        //present list of valid subarch targets, just to infrm the user.
        try
          aList:=FPCupManager.ParseSubArchsFromSource;
          if (aList.Count > 0) then
          begin
            s:='';
            for i:=0 to (aList.Count-1) do
            begin
              if aList.Names[i]=GetCPU(FPCupManager.CrossCPU_Target) then s:=s+aList.ValueFromIndex[i]+', ';
            end;
            if Length(s)>0 then
            begin
              Delete(s,Length(s)-1,2);
              memoSummary.Lines.Append('Valid subarch(s) for '+GetCPU(FPCupManager.CrossCPU_Target)+' embedded are: '+s);
            end;
          end;
        finally
          aList.Free;
        end;
      end;

      // use the available source to build the cross-compiler ... change nothing about source and url !!
      FPCupManager.OnlyModules:=_FPCCLEANBUILDONLY;//'FPCCleanOnly,FPCBuildOnly';

      // handle inclusion of LCL when cross-compiling
      IncludeLCL:=Form2.IncludeLCL;
      if (FPCupManager.CrossOS_Target=TOS.java) then IncludeLCL:=false;
      if (FPCupManager.CrossOS_Target=TOS.android) then IncludeLCL:=false;
      if (FPCupManager.CrossOS_Target=TOS.embedded) then IncludeLCL:=false;
      if (FPCupManager.CrossOS_Target=TOS.freertos) then IncludeLCL:=false;
      // AFAIK, on Darwin, LCL Carbon and Cocoa are only for MACOSX
      if (FPCupManager.CrossOS_Target=TOS.darwin) AND ((FPCupManager.CrossCPU_Target=TCPU.arm) OR (FPCupManager.CrossCPU_Target=TCPU.aarch64)) then IncludeLCL:=false;

      if IncludeLCL then
      begin
        FPCupManager.OnlyModules:=FPCupManager.OnlyModules+',LCL';
        if ((FPCupManager.CrossOS_Target=TOS.win32) OR (FPCupManager.CrossOS_Target=TOS.win64)) then
           FPCupManager.LCL_Platform:='win32'
        else
        if (FPCupManager.CrossOS_Target=TOS.wince) then
           FPCupManager.LCL_Platform:='wince'
        else
        if (FPCupManager.CrossOS_Target=TOS.darwin) then
        begin
          FPCupManager.LCL_Platform:='cocoa';
          {$ifdef LCLQT5}
          FPCupManager.LCL_Platform:='qt5';
          {$endif}
          {$ifdef LCLCARBON}
          FPCupManager.LCL_Platform:='carbon';
          {$endif}
        end
        else
        if ((FPCupManager.CrossOS_Target=TOS.amiga) OR (FPCupManager.CrossOS_Target=TOS.aros) OR (FPCupManager.CrossOS_Target=TOS.morphos)) then
           FPCupManager.LCL_Platform:='mui'
        else
        begin
          if (FPCupManager.CrossOS_Target<>TOS.osNone) AND (FPCupManager.CrossCPU_Target<>TCPU.cpuNone) then
            FPCupManager.LCL_Platform:='gtk2';
        end;
      end
      else
      begin
        if Form2.IncludeLCL then AddMessage('Skipping build of LCL for this target: not supported (yet).');
      end;

      //For testing only !!
      //FPCupManager.OnlyModules:='LCL';

      s:=Form2.GetLibraryDirectory(FPCupManager.CrossCPU_Target,FPCupManager.CrossOS_Target);
      s:=Trim(s);
      if Length(s)>0 then
      begin
        if DirectoryExists(s) then
          FPCupManager.CrossLibraryDirectory:=s
        else
        begin
          AddMessage('Cross libraries not found at supplied location.');
          AddMessage('Libs location: '+s);
          AddMessage('Expect failures.');
        end;
      end;
      s:=Form2.GetToolsDirectory(FPCupManager.CrossCPU_Target,FPCupManager.CrossOS_Target);
      s:=Trim(s);
      if Length(s)>0 then
      begin
        if DirectoryExists(s) then
          FPCupManager.CrossToolsDirectory:=s
        else
        begin
          AddMessage('Cross tools not found at supplied location.');
          AddMessage('Tools location: '+s);
          AddMessage('Expect failures.');
        end;
      end;

      AddMessage(upBuildCrossCompiler);

      s:='Fpcupdeluxe: FPC cross-builder: Building compiler for '+GetOS(FPCupManager.CrossOS_Target);
      if FPCupManager.MUSL then s:=s+'-musl';
      if FPCupManager.SolarisOI then s:=s+'-openindiana';
      s:=s+'-'+GetCPU(FPCupManager.CrossCPU_Target);
      sStatus:=s;

      if FPCupManager.FPCOPT<>'' then
      begin
        sStatus:=sStatus+' (OPT: '+FPCupManager.FPCOPT+')';
        {$ifdef RemoteLog}
        aDataClient.AddExtraData('OPT',FPCupManager.FPCOPT);
        {$endif}
      end;
      if FPCupManager.CrossOPT<>'' then
      begin
        sStatus:=sStatus+' [CROSSOPT: '+FPCupManager.CrossOPT+']';
        {$ifdef RemoteLog}
        aDataClient.AddExtraData('CROSSOPT',FPCupManager.CrossOPT);
        {$endif}
      end;
      if FPCupManager.CrossOS_SubArch<>'' then
      begin
        sStatus:=sStatus+' {SUBARCH: '+FPCupManager.CrossOS_SubArch+'}';
        {$ifdef RemoteLog}
        aDataClient.AddExtraData('SUBARCH',FPCupManager.CrossOS_SubArch);
        {$endif}
      end;
      sStatus:=sStatus+'.';

      AddMessage(sStatus);
      memoSummary.Lines.Append(sStatus);

      {$ifdef RemoteLog}
      aDataClient.UpInfo.UpFunction:=ufInstallCross;
      if length(FPCupManager.LCL_Platform)>0 then aDataClient.AddExtraData('LCL',FPCupManager.LCL_Platform);
      if length(FPCupManager.OnlyModules)>0 then aDataClient.AddExtraData('Only',FPCupManager.OnlyModules);
      if length(FPCupManager.SkipModules)>0 then aDataClient.AddExtraData('Skip',FPCupManager.SkipModules);
      {$endif}

      success:=RealRun;

      if {(Sender<>nil) AND} (NOT success) then
      begin

        // perhaps there were no libraries and/or binutils ... download them (if available) from fpcup on GitHub

        if MissingCrossBins OR MissingCrossLibs then
        begin

          if (Sender<>nil) then
          begin
            if (MessageDlg('The building of a crosscompiler failed due to missing cross-tools.' + sLineBreak +
                     'Fpcupdeluxe can try to download them if available !' + sLineBreak +
                     'Do you want to continue ?'
                     ,mtConfirmation,[mbYes, mbNo],0)<>mrYes) then
                     begin
                       exit;
                     end;
          end;

          BinsFileName:='';

          if ((Sender<>nil) AND (CheckAutoClear.Checked)) then memoSummary.Clear;
          memoSummary.Lines.Append('New try building a cross-compiler for '+GetOS(FPCupManager.CrossOS_Target)+'-'+GetCPU(FPCupManager.CrossCPU_Target)+'.');

          AddMessage('Looking for fpcupdeluxe cross-tools on GitHub (if any).');

          if FPCupManager.CrossCPU_Target=TCPU.arm then BinsFileName:='ARM';
          if FPCupManager.CrossCPU_Target=TCPU.aarch64 then BinsFileName:='Aarch64';
          if FPCupManager.CrossCPU_Target=TCPU.x86_64 then BinsFileName:='x64';
          if FPCupManager.CrossCPU_Target=TCPU.i386 then BinsFileName:='i386';
          if FPCupManager.CrossCPU_Target=TCPU.powerpc then BinsFileName:='PowerPC';
          if FPCupManager.CrossCPU_Target=TCPU.powerpc64 then BinsFileName:='PowerPC64';
          if FPCupManager.CrossCPU_Target=TCPU.mips then BinsFileName:='Mips';
          if FPCupManager.CrossCPU_Target=TCPU.mipsel then BinsFileName:='Mipsel';
          if FPCupManager.CrossCPU_Target=TCPU.sparc then BinsFileName:='Sparc';
          if FPCupManager.CrossCPU_Target=TCPU.avr then BinsFileName:='AVR';
          if FPCupManager.CrossCPU_Target=TCPU.i8086 then BinsFileName:='i8086';
          if FPCupManager.CrossCPU_Target=TCPU.m68k then BinsFileName:='m68k';
          if FPCupManager.CrossCPU_Target=TCPU.xtensa then BinsFileName:='xtensa';

          if FPCupManager.CrossOS_Target=TOS.darwin then
          begin
            // Darwin has some universal binaries and libs
            if FPCupManager.CrossCPU_Target=TCPU.i386 then BinsFileName:='x86';
            if FPCupManager.CrossCPU_Target=TCPU.x86_64 then BinsFileName:='x86';
            //Newer bins and libs for Darwin on i386 and x86_64
            //if FPCupManager.CrossCPU_Target=TCPU.i386 then BinsFileName:='x86OSX1012';
            //if FPCupManager.CrossCPU_Target=TCPU.x86_64 then BinsFileName:='x86OSX1012';
            if FPCupManager.CrossCPU_Target=TCPU.powerpc then BinsFileName:='powerpc';
            if FPCupManager.CrossCPU_Target=TCPU.powerpc64 then BinsFileName:='powerpc';
          end;

          if FPCupManager.CrossOS_Target=TOS.aix then
          begin
            // AIX has some universal binaries
            if FPCupManager.CrossCPU_Target=TCPU.powerpc then BinsFileName:='powerpc';
            if FPCupManager.CrossCPU_Target=TCPU.powerpc64 then BinsFileName:='powerpc';
          end;

          if FPCupManager.CrossOS_Target=TOS.morphos then s:='MorphOS' else
            if FPCupManager.CrossOS_Target=TOS.freebsd then s:='FreeBSD' else
              if FPCupManager.CrossOS_Target=TOS.dragonfly then s:='DragonFlyBSD' else
                if FPCupManager.CrossOS_Target=TOS.openbsd then s:='OpenBSD' else
                  if FPCupManager.CrossOS_Target=TOS.netbsd then s:='NetBSD' else
                    if FPCupManager.CrossOS_Target=TOS.aix then s:='AIX' else
                      if FPCupManager.CrossOS_Target=TOS.msdos then s:='MSDos' else
                        if FPCupManager.CrossOS_Target=TOS.freertos then s:='FreeRTOS' else
                          if FPCupManager.CrossOS_Target=TOS.win32 then s:='Windows' else
                            if FPCupManager.CrossOS_Target=TOS.win64 then s:='Windows' else
                              s:=UppercaseFirstChar(GetOS(FPCupManager.CrossOS_Target));

          if FPCupManager.SolarisOI then s:=s+'OI';
          BinsFileName:=s+BinsFileName;

          if FPCupManager.MUSL then BinsFileName:='MUSL'+BinsFileName;

          // normally, we have the same names for libs and bins URL
          LibsFileName:=BinsFileName;

          // normally, we have the standard names for libs and bins paths
          LibPath:=ConcatPaths([CROSSPATH,'lib',GetCPU(FPCupManager.CrossCPU_Target)])+'-';
          BinPath:=ConcatPaths([CROSSPATH,'bin',GetCPU(FPCupManager.CrossCPU_Target)])+'-';
          if FPCupManager.MUSL then
          begin
            LibPath:=LibPath+'musl';
            BinPath:=BinPath+'musl';
          end;
          LibPath:=LibPath+GetOS(FPCupManager.CrossOS_Target);
          BinPath:=BinPath+GetOS(FPCupManager.CrossOS_Target);
          if FPCupManager.SolarisOI then
          begin
            LibPath:=LibPath+'-oi';
            BinPath:=BinPath+'-oi';
          end;

          if FPCupManager.CrossOS_Target=TOS.darwin then
          begin
            // Darwin is special: combined binaries and libs for i386 and x86_64 with osxcross
            if (FPCupManager.CrossCPU_Target=TCPU.i386) OR (FPCupManager.CrossCPU_Target=TCPU.x86_64) then
            begin
              BinPath:=StringReplace(BinPath,GetCPU(FPCupManager.CrossCPU_Target),'x86',[rfIgnoreCase]);
              LibPath:=StringReplace(LibPath,GetCPU(FPCupManager.CrossCPU_Target),'x86',[rfIgnoreCase]);
            end;
            if (FPCupManager.CrossCPU_Target=TCPU.powerpc) OR (FPCupManager.CrossCPU_Target=TCPU.powerpc64) then
            begin
              BinPath:=StringReplace(BinPath,GetCPU(FPCupManager.CrossCPU_Target),GetCPU(TCPU.powerpc),[rfIgnoreCase]);
              LibPath:=StringReplace(LibPath,GetCPU(FPCupManager.CrossCPU_Target),GetCPU(TCPU.powerpc),[rfIgnoreCase]);
            end;

            // Darwin is special: combined libs for arm and aarch64 with osxcross
            if (FPCupManager.CrossCPU_Target=TCPU.arm) OR (FPCupManager.CrossCPU_Target=TCPU.aarch64) then
            begin
              LibPath:=StringReplace(LibPath,GetCPU(FPCupManager.CrossCPU_Target),GetCPU(TCPU.arm),[rfIgnoreCase]);
              LibsFileName:=StringReplace(LibsFileName,'Aarch64','ARM',[rfIgnoreCase]);
            end;
          end;

          if FPCupManager.CrossOS_Target=TOS.aix then
          begin
            // AIX is special: combined binaries and libs for ppc and ppc64 with osxcross
            if (FPCupManager.CrossCPU_Target=TCPU.powerpc) OR (FPCupManager.CrossCPU_Target=TCPU.powerpc64) then
            begin
              BinPath:=StringReplace(BinPath,GetCPU(FPCupManager.CrossCPU_Target),GetCPU(TCPU.powerpc),[rfIgnoreCase]);
              LibPath:=StringReplace(LibPath,GetCPU(FPCupManager.CrossCPU_Target),GetCPU(TCPU.powerpc),[rfIgnoreCase]);
            end;
          end;

          //Put all windows stuff (not that much) in a single windows directory
          if (FPCupManager.CrossOS_Target=TOS.win32) OR (FPCupManager.CrossOS_Target=TOS.win64) then
          begin
            BinPath:=StringReplace(BinPath,GetOS(FPCupManager.CrossOS_Target),'windows',[rfIgnoreCase]);
            LibPath:=StringReplace(LibPath,GetOS(FPCupManager.CrossOS_Target),'windows',[rfIgnoreCase]);
          end;

          if FPCupManager.CrossOS_Target=TOS.linux then
          begin
            // PowerPC64 is special: only little endian libs for now
            if (FPCupManager.CrossCPU_Target=TCPU.powerpc64) then
            begin
              LibsFileName:=StringReplace(LibsFileName,'PowerPC64','PowerPC64LE',[rfIgnoreCase]);
            end;

            // ARM is special: can be hard or softfloat (Windows only binutils yet)
            {$ifdef MSWINDOWS}
            if (FPCupManager.CrossCPU_Target=TCPU.arm) then
            begin
              if (Pos('SOFT',UpperCase(FPCupManager.CrossOPT))>0) OR (Pos('FPC_ARMEL',UpperCase(FPCupManager.FPCOPT))>0) then
              begin
                // use softfloat binutils
                BinsFileName:=StringReplace(LibsFileName,'BinsLinuxARM','BinsLinuxARMSoft',[rfIgnoreCase]);
              end;
            end;
            {$endif}
          end;

          LibsFileName:='CrossLibs'+LibsFileName;
          {$ifdef MSWINDOWS}
          BinsFileName:='WinCrossBins'+BinsFileName;
          {$else}
          BinsFileName:='CrossBins'+BinsFileName;
          {$endif MSWINDOWS}

          // bit tricky ... if bins and libs are already there exit this retry ... ;-)
          if (
             (DirectoryIsEmpty(IncludeTrailingPathDelimiter(sInstallDir)+BinPath))
             OR
             (DirectoryIsEmpty(IncludeTrailingPathDelimiter(sInstallDir)+LibPath))
             )
          then
          begin

            // many files to unpack for Darwin : do not show progress of unpacking files when unpacking for Darwin.
            verbose:=(FPCupManager.CrossOS_Target<>TOS.darwin);

            if MissingCrossBins then
            begin
              AddMessage('Going to look for the right cross-bins. Can (will) take some time !',True);

              BaseBinsURL:='';

              if GetTargetOS=GetOS(TOS.win32) then BaseBinsURL:='wincrossbins'
              else
                 if GetTargetOS=GetOS(TOS.win64) then BaseBinsURL:='wincrossbins'
                 else
                    if GetTargetOS=GetOS(TOS.linux) then
                    begin
                      if GetTargetCPU=GetCPU(TCPU.i386) then BaseBinsURL:='linuxi386crossbins';
                      if GetTargetCPU=GetCPU(TCPU.x86_64) then BaseBinsURL:='linuxx64crossbins';
                    end
                    else
                      if GetTargetOS=GetOS(TOS.freebsd) then
                      begin
                        if GetTargetCPU=GetCPU(TCPU.x86_64) then BaseBinsURL:='freebsdx64crossbins';
                      end
                      else
                        if GetTargetOS=GetOS(TOS.solaris) then
                        begin
                          {if FPCupManager.SolarisOI then}
                          begin
                            if GetTargetCPU=GetCPU(TCPU.x86_64) then BaseBinsURL:='solarisoix64crossbins';
                          end;
                        end
                        else
                          if GetTargetOS=GetOS(TOS.darwin) then
                          begin
                            if GetTargetCPU=GetCPU(TCPU.i386) then BaseBinsURL:='darwini386crossbins';
                            if GetTargetCPU=GetCPU(TCPU.x86_64) then BaseBinsURL:='darwinx64crossbins';
                          end;


              // no cross-bins available
              if (Length(BaseBinsURL)=0) then
              begin
                ShowMessage('No tools available online. You could do a feature request ... ;-)');
                exit;
              end;

              AddMessage('Looking for: '+BinsFileName, True);

              MajorVersion:=1;
              for MinorVersion:=2 downto 0 do
              begin

                //Add version
                BinsURL:=BaseBinsURL+'_v'+InttoStr(MajorVersion)+'.'+InttoStr(MinorVersion);

                success:=false;

                TargetFile:=BinsFileName;

                DownloadURL:=FPCUPGITREPOAPI+'/tags/'+BinsURL;

                AddMessage('Looking for bins in: '+DownloadURL, True);

                aList:=TStringList.Create;
                try
                  aList.Clear;
                  try
                    GetGitHubFileList(DownloadURL,aList,FPCupManager.UseWget,FPCupManager.HTTPProxyHost,FPCupManager.HTTPProxyPort,FPCupManager.HTTPProxyUser,FPCupManager.HTTPProxyPassword);
                  except
                    on E : Exception do
                    begin
                      //AddMessage('Could not get binutils file list from '+DownloadURL+'.');
                      //continue;
                    end;
                  end;
                  //Prefer a zip-file
                  for i:=0 to Pred(aList.Count) do
                  begin
                    if AnsiContainsText(aList[i],TargetFile+'.zip') then
                    begin
                      TargetFile := TargetFile+'.zip';
                      success:=true;
                      break;
                    end;
                  end;
                  if NOT success then
                  begin
                    for i:=0 to Pred(aList.Count) do
                    begin
                      if AnsiContainsText(aList[i],TargetFile) then
                      begin
                        TargetFile := FileNameFromURL(aList[i]);
                        success:=true;
                        break;
                      end;
                    end;
                  end;

                finally
                  aList.Free;
                end;

                if success then
                begin
                  DownloadURL:=FPCUPGITREPO+'/releases/download/'+BinsURL+'/'+TargetFile;
                  AddMessage('Found correct online binutils at: '+DownloadURL);
                  AddMessage('Going to download the cross-bins. Can (will) take some time !',True);
                  TargetFile := IncludeTrailingPathDelimiter(FPCupManager.TempDirectory)+TargetFile;
                  SysUtils.DeleteFile(TargetFile);
                  success:=DownLoad(FPCupManager.UseWget,DownloadURL,TargetFile,FPCupManager.HTTPProxyHost,FPCupManager.HTTPProxyPort,FPCupManager.HTTPProxyUser,FPCupManager.HTTPProxyPassword);
                  if success then AddMessage('Download successfull !');
                end;

                if success then
                begin
                  ZipFile:=(ExtractFileExt(TargetFile)='.zip');
                  TargetPath:=IncludeTrailingPathDelimiter(sInstallDir);
                  {$ifndef MSWINDOWS}
                  TargetPath:=IncludeTrailingPathDelimiter(sInstallDir)+BinPath+DirectorySeparator;
                  {$endif}
                  ForceDirectoriesSafe(TargetPath);

                  AddMessage('Going to extract archive into '+TargetPath);

                  if ZipFile then
                  begin
                    with TNormalUnzipper.Create do
                    begin
                      try
                        success:=DoUnZip(TargetFile,TargetPath,[]);
                      finally
                        Free;
                      end;
                    end;
                  end
                  else
                  begin
                    {$ifdef MSWINDOWS}
                    if (not verbose) then AddMessage('Please wait: going to unpack binary tools archive.');
                    success:={%H-}RunCommand('"C:\Program Files (x86)\WinRAR\WinRAR.exe" x '+TargetFile+' "'+TargetPath+'"',s);
                    if (NOT success) then
                    {$endif}
                    begin
                      {$ifdef MSWINDOWS}
                      UnZipper := IncludeTrailingPathDelimiter(FPCupManager.MakeDirectory) + 'unrar\bin\unrar.exe';
                      {$else}
                      UnZipper := 'unrar';
                      {$endif}
                      success:=CheckExecutable(UnZipper, ['-v'], '');
                      if success then
                      begin
                        if (not verbose) then AddMessage('Please wait: going to unpack binary tools archive.');
                        success:={%H-}RunCommand(UnZipper + ' x "' + TargetFile + '" "' + TargetPath + '"',s);
                      end else AddMessage('Error: '+UnZipper+' not found on system. Cannot unpack cross-tools !');
                    end;
                  end;
                end;

                SysUtils.DeleteFile(TargetFile);

                if success then
                begin
                  aList:=TStringList.Create;
                  try
                    aList.Add('These binary utilities were happily provided to you by fpcupdeluxe.');
                    aList.Add('You can find them at:');
                    aList.Add(DownloadURL);
                    s:=IncludeTrailingPathDelimiter(sInstallDir)+BinPath+DirectorySeparator+FPCUP_ACKNOWLEDGE;
                    SysUtils.DeleteFile(s);
                    aList.SaveToFile(s);
                  finally
                    aList.Free;
                  end;
                  {$IFDEF UNIX}
                  aList:=FindAllFiles(TargetPath);
                  try
                    if (aList.Count > 0) then
                    begin
                      for i:=0 to Pred(aList.Count) do
                      begin
                        fpChmod(aList.Strings[i],&755);
                      end;
                    end;
                  finally
                    aList.Free;
                  end;
                  {$ENDIF}
                  MissingCrossBins:=False;
                  break;
                end;
              end;
            end;

            // force the download of embedded libs if not there ... if this fails, don't worry, building will go on
            if (DirectoryIsEmpty(IncludeTrailingPathDelimiter(sInstallDir)+LibPath)) AND (FPCupManager.CrossOS_Target=TOS.embedded)
              then MissingCrossLibs:=true;

            if MissingCrossLibs then
            begin
              AddMessage('Going to look for the right cross-libraries. Can (will) take some time !',True);

              AddMessage('Looking for: '+LibsFileName,True);

              MajorVersion:=1;
              for MinorVersion:=2 downto 0 do
              begin
                LibsURL:='crosslibs_v'+InttoStr(MajorVersion)+'.'+InttoStr(MinorVersion);

                TargetFile:=LibsFileName;

                DownloadURL:=FPCUPGITREPOAPI+'/tags/'+LibsURL;

                AddMessage('Looking for libs in: '+DownloadURL, True);

                success:=false;
                aList:=TStringList.Create;
                try
                  aList.Clear;
                  try
                    GetGitHubFileList(DownloadURL,aList,FPCupManager.UseWget,FPCupManager.HTTPProxyHost,FPCupManager.HTTPProxyPort,FPCupManager.HTTPProxyUser,FPCupManager.HTTPProxyPassword);
                  except
                    on E : Exception do
                    begin
                      //AddMessage('Could not get libraries file list from '+DownloadURL+'.');
                      //continue;
                    end;
                  end;

                  //Prefer a zip-file
                  for i:=0 to Pred(aList.Count) do
                  begin
                    if Pos(TargetFile+'.zip',aList[i])>0 then
                    begin
                      TargetFile := TargetFile+'.zip';
                      success:=true;
                      break;
                    end;
                  end;
                  if NOT success then
                  begin
                    for i:=0 to Pred(aList.Count) do
                    begin
                      if Pos(TargetFile,aList[i])>0 then
                      begin
                        TargetFile := FileNameFromURL(aList[i]);
                        success:=true;
                        break;
                      end;
                    end;
                  end;
                finally
                  aList.Free;
                end;

                if success then
                begin
                  DownloadURL:=FPCUPGITREPO+'/releases/download/'+LibsURL+'/'+TargetFile;
                  AddMessage('Found correct online libraries at: '+DownloadURL);
                  AddMessage('Going to download the cross-libraries. Can (will) take some time !',True);
                  TargetFile := IncludeTrailingPathDelimiter(FPCupManager.TempDirectory)+TargetFile;
                  SysUtils.DeleteFile(TargetFile);
                  success:=DownLoad(FPCupManager.UseWget,DownloadURL,TargetFile,FPCupManager.HTTPProxyHost,FPCupManager.HTTPProxyPort,FPCupManager.HTTPProxyUser,FPCupManager.HTTPProxyPassword);
                  if success then AddMessage('Download successfull !');
                end;

                if success then
                begin
                  ZipFile:=(ExtractFileExt(TargetFile)='.zip');
                  TargetPath:=IncludeTrailingPathDelimiter(sInstallDir);
                  //TargetPath:=IncludeTrailingPathDelimiter(sInstallDir)+LibPath+DirectorySeparator;
                  //ForceDirectoriesSafe(IncludeTrailingPathDelimiter(sInstallDir)+LibPath);

                  AddMessage('Going to extract archive into '+TargetPath);

                  if ZipFile then
                  begin
                    with TNormalUnzipper.Create do
                    begin
                      try
                        success:=DoUnZip(TargetFile,TargetPath,[]);
                      finally
                        Free;
                      end;
                    end;
                  end
                  else
                  begin
                    {$ifdef MSWINDOWS}
                    if (not verbose) then AddMessage('Please wait: going to unpack library files archive.');
                    success:={%H-}RunCommand('"C:\Program Files (x86)\WinRAR\WinRAR.exe" x '+TargetFile+' "'+TargetPath+'"',s);
                    if (NOT success) then
                    {$endif}
                    begin
                      {$ifdef MSWINDOWS}
                      UnZipper := IncludeTrailingPathDelimiter(FPCupManager.MakeDirectory) + 'unrar\bin\unrar.exe';
                      {$else}
                      UnZipper := 'unrar';
                      {$endif}
                      success:=CheckExecutable(UnZipper, ['-v'], '');
                      if success then
                      begin
                        if (not verbose) then AddMessage('Please wait: going to unpack library files archive.');
                        success:={%H-}RunCommand(UnZipper + ' x "' + TargetFile + '" "' + TargetPath + '"',s);
                      end else AddMessage('Error: '+UnZipper+' not found on system. Cannot unpack cross-tools !');
                    end;
                  end;
                end;
                SysUtils.DeleteFile(TargetFile);

                if success then
                begin
                  aList:=TStringList.Create;
                  try
                    aList.Add('These libraries were happily provided to you by fpcupdeluxe.');
                    aList.Add('You can find them at:');
                    aList.Add(DownloadURL);
                    s:=IncludeTrailingPathDelimiter(sInstallDir)+LibPath+DirectorySeparator+FPCUP_ACKNOWLEDGE;
                    SysUtils.DeleteFile(s);
                    aList.SaveToFile(s);
                  finally
                    aList.Free;
                  end;
                  MissingCrossLibs:=False;
                  break;
                end;
              end;
              // as libraries are not always needed for embedded, end with success even if the above has failed
              if FPCupManager.CrossOS_Target=TOS.embedded then
              begin
                success:=true;
                MissingCrossLibs:=False;
              end;
            end;

            if success then
            begin
              AddMessage('Successfully extracted cross-tools.');
              // run again with the correct libs and binutils
              FPCVersionLabel.Font.Color:=clDefault;
              LazarusVersionLabel.Font.Color:=clDefault;
              AddMessage('Got all tools now. Building a cross-compiler for '+GetOS(FPCupManager.CrossOS_Target)+'-'+GetCPU(FPCupManager.CrossCPU_Target),True);
              memoSummary.Lines.Append('Got all tools now. Start building cross-compiler.');
              if Assigned(FPCupManager.Sequencer) then FPCupManager.Sequencer.ResetAllExecuted;

              {$ifdef RemoteLog}
              aDataClient.UpInfo.UpFunction:=ufInstallCross;
              {$endif}

              success:= RealRun;
            end else AddMessage('No luck in getting then cross-tools ... aborting.');
          end;
        end
        else
        begin
          AddMessage('Building cross-tools failed. Aborting.');
        end;

      end;

      if success then
        Form2.SetCrossAvailable(FPCupManager.CrossCombo_Target,true);

    finally
      DisEnable(Sender,True);
    end;
  end;

  result:=success;
end;

procedure TForm1.InstallClick(Sender: TObject);
var
  s:string;
  FModuleList: TStringList;
begin

  s:='';
  if Sender=BitBtnFPCOnly then
    if (Length(FPCTarget)=0) then s:='Please select a FPC target first';
  if Sender=BitBtnLazarusOnly then
    if (Length(LazarusTarget)=0) then s:='Please select a Lazarus target first';
  if Sender=BitBtnFPCandLazarus then
    if (Length(FPCTarget)=0) or (Length(LazarusTarget)=0) then s:='Please select a FPC and Lazarus target first';

  if Length(s)>0 then
  begin
    ShowMessage(s);
    exit;
  end;

  DisEnable(Sender,False);
  try
    PrepareRun;

    s:='';

    if Form2.UpdateOnly then
    begin

      if Sender=BitBtnFPCOnly then
      begin
        {$ifdef win32}
        s:=_FPCCLEANBUILDONLY+','+_FPC+_CROSSWIN;
        {$else}
        s:=_FPCCLEANBUILDONLY;
        {$endif}
      end;

      if Sender=BitBtnLazarusOnly then
      begin
        s:=_LAZARUSCLEANBUILDONLY;
      end;

      if Sender=BitBtnFPCandLazarus then
      begin
        // still not working 100% for Lazarus ...  todo
        // packages that are installed by the user are not included
        s:=_FPCCLEANBUILDONLY+','+_LAZARUSCLEANBUILDONLY;
        FModuleList:=TStringList.Create;
        try
          GetModuleEnabledList(FModuleList);
          // also include enabled modules (packages) when rebuilding Lazarus
          if FModuleList.Count>0 then s:=s+','+FModuleList.CommaText;
        finally
          FModuleList.Free;
        end;
      end;

      if Length(s)>0 then
        FPCupManager.OnlyModules:=s
      else
        begin
          ShowMessage('No sequence defined. Should never happen. Please file bugger.');
          exit;
        end;
    end
    else
    begin

      if Sender=BitBtnFPCOnly then
      begin
        s:=_FPC;
      end;

      if Sender=BitBtnLazarusOnly then
      begin
        {$IF defined(CPUAARCH64) or defined(CPUARM) or defined(CPUARMHF) or defined(HAIKU) or defined(CPUPOWERPC64)}
        s:=_LAZARUSSIMPLE;
        {$ELSE}
        s:=_LAZARUS;
        {$ENDIF}
      end;

      if Sender=BitBtnFPCandLazarus then
      begin
        //use standard install/default sequence
      end;

      if Length(s)>0 then FPCupManager.OnlyModules:=s;

    end;

    if NOT Form2.IncludeHelp then
    begin
      if ((Sender=BitBtnFPCOnly) OR (Sender=BitBtnFPCandLazarus)) then FPCupManager.SkipModules:=FPCupManager.SkipModules+','+_HELPFPC;
      if ((Sender=BitBtnLazarusOnly) OR (Sender=BitBtnFPCandLazarus)) then FPCupManager.SkipModules:=FPCupManager.SkipModules+','+_HELPLAZARUS;
    end
    else
    begin
      if ((Sender=BitBtnLazarusOnly) OR (Sender=BitBtnFPCandLazarus)) then
      begin
        FPCupManager.IncludeModules:=FPCupManager.IncludeModules+','+_LHELP;
      end;
    end;

    //Delete stray comma
    s:=FPCupManager.IncludeModules;
    if Pos(',',s)=1 then
    begin
      Delete(s,1,1);
      FPCupManager.IncludeModules:=s;
    end;
    //Delete stray comma
    s:=FPCupManager.SkipModules;
    if Pos(',',s)=1 then
    begin
      Delete(s,1,1);
      FPCupManager.SkipModules:=s;
    end;

    if Sender=BitBtnFPCOnly then
      sStatus:='Going to install/update FPC only';
    if Sender=BitBtnLazarusOnly then
      sStatus:='Going to install/update Lazarus only';
    if Sender=BitBtnFPCandLazarus then
      sStatus:='Going to install/update FPC and Lazarus';

    AddMessage(sStatus+' with given options.');

    {$ifdef RemoteLog}
    aDataClient.UpInfo.UpFunction:=ufInstallFPCLAZ;
    if Sender=BitBtnFPCOnly then aDataClient.UpInfo.UpFunction:=ufInstallFPC;
    if Sender=BitBtnLazarusOnly then aDataClient.UpInfo.UpFunction:=ufInstallLAZ;
    {$endif}

    RealRun;

  finally
    DisEnable(Sender,True);
  end;
end;

procedure TForm1.btnSetupPlusClick(Sender: TObject);
begin
  Form2.ShowModal;
  if Form2.ModalResult=mrOk then
  begin
    FPCupManager.ExportOnly:=(NOT Form2.Repo);
    FPCupManager.HTTPProxyHost:=Form2.HTTPProxyHost;
    FPCupManager.HTTPProxyPort:=Form2.HTTPProxyPort;
    FPCupManager.HTTPProxyUser:=Form2.HTTPProxyUser;
    FPCupManager.HTTPProxyPassword:=Form2.HTTPProxyPass;
  end;
end;

procedure TForm1.btnLogClick(Sender: TObject);
var
  aURI: TURI;
  s:string;
  i:integer;
begin
  if (Sender=btnClearLog) then
  begin
    CommandOutputScreen.ClearAll;
    memoSummary.Clear;
  end;
  if (Sender=btnSendLog) then
  begin
    FillChar({%H-}aUri,SizeOf(TURI),0);
    aURI.Protocol:='mailto';
    aURI.Document:='fpcupdeluxe@gmail.com';
    s:=s+'******************** first 20 lines *************************'+#13#10;
    i:=0;
    while (i<CommandOutputScreen.Lines.Count) do
    begin
      s:=s+CommandOutputScreen.Lines.Strings[i]+#13#10;
      if (i>18) then break;
      Inc(i);
    end;
    s:=s+#13#10;
    s:=s+'******************** last 50 lines *************************'+#13#10;
    i:=CommandOutputScreen.Lines.Count-50;
    if (i<18) then i:=18;
    while (i<CommandOutputScreen.Lines.Count) do
    begin
      s:=s+CommandOutputScreen.Lines.Strings[i]+#13#10;
      Inc(i);
    end;
    s:=s+#13#10;
    s:=s+'************************* end ******************************';
    aURI.Params:='subject=Fpcupdeluxe command screen log&body=Please find included part of the command screen output of fpcupdeluxe. You may add more if you want by copy paste of command screen.'+#13#10+#13#10+s;
    OpenDocument(EncodeURI(aURI));
  end;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  sInstallDir:=InstallDirEdit.Text;
  if DirectoryExists(sInstallDir) then GetFPCUPSettings(IncludeTrailingPathDelimiter(sInstallDir));
end;

procedure TForm1.Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  sInstallDir:=InstallDirEdit.Text;
  if DirectoryExists(sInstallDir) then GetFPCUPSettings(IncludeTrailingPathDelimiter(sInstallDir));
end;

procedure TForm1.FPCVersionLabelClick(Sender: TObject);
begin
  MessageTrigger:=True;
end;

{$ifdef usealternateui}
procedure TForm1.alternateuibutClick(Sender: TObject);
begin
  alteranteui_ClickHandler(Sender);
end;
procedure TForm1.alternateuibutEnter(Sender: TObject);
begin
  alteranteui_EnterHandler(Sender);
end;
procedure TForm1.alternateuibutLeave(Sender: TObject);
begin
  alteranteui_LeaveHandler(Sender);
end;
{$endif}

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Self.OnResize:=nil;
  if Assigned(FPCupManager) then
  begin
    Application.MainForm.Cursor:=crHourGlass;
    with TMemIniFile.Create(SafeGetApplicationPath+installerUniversal.DELUXEFILENAME) do
    try
      WriteString('General','InstallDirectory',sInstallDir);
      {$ifdef RemoteLog}
      WriteBool('General','ConsentWarning',false);
      {$endif}

      {$ifdef EnableLanguages}
      WriteString('General','Language',sLanguage);
      {$endif}

      WriteString('ProxySettings','HTTPProxyURL',FPCupManager.HTTPProxyHost);
      WriteInteger('ProxySettings','HTTPProxyPort',FPCupManager.HTTPProxyPort);
      WriteString('ProxySettings','HTTPProxyUser',FPCupManager.HTTPProxyUser);
      WriteString('ProxySettings','HTTPProxyPass',FPCupManager.HTTPProxyPassword);

      WriteInteger('General','CommandFontSize',CommandOutputScreen.Font.Size);

      if Self.WindowState=wsNormal then
      begin
        WriteInteger('General','Top',Self.Top);
        WriteInteger('General','Left',Self.Left);
        WriteInteger('General','Width',Self.Width);
        WriteInteger('General','Height',Self.Height);
        WriteBool('General','Maximized',False);
      end
      else
      begin
        WriteBool('General','Maximized',True);
      end;
      UpdateFile;
    finally
      Free;
    end;

    SetFPCUPSettings(IncludeTrailingPathDelimiter(sInstallDir));

    FPCupManager.Destroy;
    FPCupManager:=nil;

  end;

  CloseAction:=caFree;
end;

procedure TForm1.DisEnable(Sender: TObject;value:boolean);
var
  c: TControl;
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if (NOT (Components[i] is TControl)) then continue;
    c := Components[i] AS TControl;
    if c is TLabel then continue;
    if c is TPanel then continue;
    if c is TGroupBox then continue;
    if c = BitBtnHalt then continue;
    if c = CommandOutputScreen then continue;
    if c = memoSummary then continue;
    c.Enabled := value;
    {$ifdef usealternateui}
    if ((pos('Halt',c.name)>0) or (pos('Halt',c.caption)>0)) then c.Enabled:=true;
    {$endif}
  end;
end;

procedure TForm1.PrepareRun;
begin
  FPCVersionLabel.Font.Color:=clDefault;
  LazarusVersionLabel.Font.Color:=clDefault;

  RealFPCURL.Color:=clDefault;
  RealFPCURL.ReadOnly:=true;
  RealLazURL.Color:=clDefault;
  RealLazURL.ReadOnly:=true;

  if CheckAutoClear.Checked then btnClearLog.Click;

  FPCupManager.Sequencer.ResetAllExecuted;

  MissingCrossBins:=false;
  MissingCrossLibs:=false;
  MissingTools:=false;

  FPCupManager.NoJobs:=(NOT Form2.MakeJobs);

  FPCupManager.SoftFloat:=Form2.UseSoftFloat;
  FPCupManager.OnlinePatching:=Form2.OnlinePatching;

  FPCupManager.OnlyModules:='';
  FPCupManager.IncludeModules:='';
  FPCupManager.SkipModules:='';
  FPCupManager.CrossCPU_Target:=TCPU.cpuNone;
  FPCupManager.CrossOS_Target:=TOS.osNone;
  FPCupManager.CrossOS_SubArch:='';

  FPCupManager.LCL_Platform:='';

  FPCupManager.SolarisOI:=false;
  FPCupManager.MUSL:=false;

  FPCupManager.FPCOPT:=Form2.FPCOptions;
  FPCupManager.CrossOPT:='';

  FPCupManager.CrossLibraryDirectory:='';
  FPCupManager.CrossToolsDirectory:='';

  FPCupManager.FPCDesiredBranch:='';
  FPCupManager.LazarusDesiredBranch:='';
  FPCupManager.FPCDesiredRevision:='';
  FPCupManager.LazarusDesiredRevision:='';

  {$IFDEF DEBUG}
  FPCupManager.Verbose:=True;
  {$ELSE}
  FPCupManager.Verbose:=Form2.ExtraVerbose;
  {$ENDIF}

  // set default values for FPC and Lazarus URL ... can still be changed inside the quick real run button onclicks
  FPCupManager.FPCURL:=FPCTarget;
  FPCupManager.LazarusURL:=LazarusTarget;

  FPCupManager.LazarusOPT:=Form2.LazarusOptions;

  FPCupManager.UseSystemFPC:=Form2.SystemFPC;

  FPCupManager.UseWget:=Form2.UseWget;

  FPCupManager.SwitchURL:=Form2.AutoSwitchURL;

  // set custom FPC compiler by special user input through setup+
  FPCupManager.CompilerOverride:=Form2.GetCompiler(GetTCPU(GetTargetCPU),GetTOS(GetTargetOS));

  sInstallDir:=ExcludeTrailingPathDelimiter(sInstallDir);
  FPCupManager.BaseDirectory:=sInstallDir;

  // do not create shortcut for fpcupeluxe itself: we have already fpcupdeluxe by itself !!
  //FPCupManager.ShortCutNameFpcup:='fpcup_'+ExtractFileName(sInstallDir)+'_update';
  FPCupManager.ShortCutNameFpcup:=EmptyStr;

  FPCupManager.ShortCutNameLazarus:='Lazarus_'+ExtractFileName(sInstallDir);

  sInstallDir:=IncludeTrailingPathDelimiter(sInstallDir);

  FPCupManager.MakeDirectory:=sInstallDir+'fpcbootstrap';

  FPCupManager.BootstrapCompilerDirectory:=sInstallDir+'fpcbootstrap';

  FPCupManager.FPCInstallDirectory:=sInstallDir+'fpc';
  if Form2.SplitFPC
     then FPCupManager.FPCSourceDirectory:=FPCupManager.FPCInstallDirectory+'src'
     else FPCupManager.FPCSourceDirectory:=FPCupManager.FPCInstallDirectory;

  FPCupManager.LazarusInstallDirectory:=sInstallDir+'lazarus';
  if Form2.SplitLazarus
     then FPCupManager.LazarusSourceDirectory:=FPCupManager.LazarusInstallDirectory+'src'
     else FPCupManager.LazarusSourceDirectory:=FPCupManager.LazarusInstallDirectory;

  FPCupManager.LazarusPrimaryConfigPath:=sInstallDir+'config_'+ExtractFileName(FPCupManager.LazarusInstallDirectory);

  FPCupManager.ExportOnly:=(NOT Form2.Repo);

  FPCupManager.FPCPatches:=Form2.FPCPatches;
  FPCupManager.LazarusPatches:=Form2.LazPatches;
  FPCupManager.NativeFPCBootstrapCompiler:=(NOT Form2.FpcupBootstrappersOnly);
  FPCupManager.ForceLocalRepoClient:=Form2.ForceLocalRepoClient;
  FPCupManager.Context:=Form2.AddContext;

  // Set default Darwin LCL platforms
  {$ifdef Darwin}
    FPCupManager.LCL_Platform:='cocoa';
    {$ifdef LCLCARBON}
      FPCupManager.LCL_Platform:='carbon';
    {$endif}
  {$endif}

  // Override default LCL platforms in case of QT[5]
  {$ifdef LCLQT}
    FPCupManager.LCL_Platform:='qt';
  {$endif}
  {$ifdef LCLQT5}
    FPCupManager.LCL_Platform:='qt5';
  {$endif}

  {$ifdef RemoteLog}
  aDataClient.Enabled:=Form2.SendInfo;
  aDataClient.UpInfo.UpFunction:=ufUnknown;
  aDataClient.ClearExtraData;
  aDataClient.UpInfo.CrossCPUOS:='';
  aDataClient.UpInfo.LogEntry:='';
  {$endif}

  sStatus:='Sitting and waiting';
  StatusMessage.Color:=clDefault;
  StatusMessage.Text:=sStatus;

  if CheckAutoClear.Checked then memoSummary.Lines.Clear;
end;

function TForm1.RealRun:boolean;
var
  {$ifdef RemoteLog}
  aVersion:string;
  {$endif}
  s:string;
  aLazarusVersion:word;
begin
  result:=false;

  StatusMessage.Text:=sStatus;

  AddMessage('FPCUP(deluxe) is starting up.');
  AddMessage('');
  {$IFDEF MSWINDOWS}
  AddMessage('Binutils/make dir:     '+FPCupManager.MakeDirectory);
  {$ENDIF MSWINDOWS}
  AddMessage('Bootstrap dir:         '+FPCupManager.BootstrapCompilerDirectory);

  {$IF (defined(BSD)) and (not defined(Darwin))}
  FPCupManager.FPCOpt:=FPCupManager.FPCOpt+' -Fl/usr/local/lib -Fl/usr/pkg/lib';
  FPCupManager.LazarusOpt:=FPCupManager.LazarusOpt+' -Fl/usr/local/lib -Fl/usr/X11R6/lib -Fl/usr/pkg/lib -Fl/usr/X11R7/lib';
  {$endif}

  // default branch and revision overrides
  // for https://github.com/graemeg (FPC/Lazarus mirrors of GitHub) ... always get the right branch
  if (Pos('github.com/graemeg',FPCTarget)>0) then FPCupManager.FPCDesiredBranch:='master';
  if (Pos('github.com/graemeg',LazarusTarget)>0) then FPCupManager.LazarusDesiredBranch:='upstream';

  // for https://github.com/newpascal (FPC/Lazarus NP mirrors of GitHub) ... always get the right branch
  if (Pos('github.com/newpascal',FPCTarget)>0) then FPCupManager.FPCDesiredBranch:='release';
  if (Pos('github.com/newpascal',LazarusTarget)>0) then FPCupManager.LazarusDesiredBranch:='release';
  //if (Pos('github.com/newpascal',FPCTarget)>0) then FPCupManager.FPCDesiredBranch:='freepascal';
  //if (Pos('github.com/newpascal',LazarusTarget)>0) then FPCupManager.LazarusDesiredBranch:='lazarus';
  if (Pos('github.com/LongDirtyAnimAlf',FPCTarget)>0) then FPCupManager.FPCDesiredBranch:='master';
  if (Pos('github.com/LongDirtyAnimAlf',LazarusTarget)>0) then FPCupManager.LazarusDesiredBranch:='upstream';
  if (Pos('github.com/LongDirtyAnimAlf/lazarussource',LazarusTarget)>0) then FPCupManager.LazarusDesiredBranch:='master';

  // branch and revision overrides from setup+
  s:=Form2.FPCBranch;
  if Length(s)>0 then FPCupManager.FPCDesiredBranch:=s;
  s:=Form2.FPCRevision;
  if Length(s)>0 then FPCupManager.FPCDesiredRevision:=s;

  s:=Form2.LazarusBranch;
  if Length(s)>0 then FPCupManager.LazarusDesiredBranch:=s;
  s:=Form2.LazarusRevision;
  if Length(s)>0 then FPCupManager.LazarusDesiredRevision:=s;

  // overrides for old versions of Lazarus
  aLazarusVersion:=CalculateNumericalVersion(LazarusTarget);
  if (aLazarusVersion<>0) AND (aLazarusVersion<CalculateFullVersion(1,0,0)) then
  begin
    s:=FPCupManager.OnlyModules;
    if (Length(s)>0) then
    begin
      if Pos(_LAZARUSSIMPLE,s)=0 then s:=StringReplace(s,_LAZARUS,_LAZARUSSIMPLE,[]);
      s:=StringReplace(s,'FPCCrossWin32-64','',[]);
      s:=StringReplace(s,'LazarusCrossWin32-64','',[]);
      FPCupManager.OnlyModules:=s;
    end
    else
    begin
      FPCupManager.OnlyModules:=_FPC+','+_LAZARUSSIMPLE;
    end;
    AddMessage('Detected a very old version of Lazarus !');
    AddMessage('Switching towards old lazarus sequence !!');
  end;

  AddMessage('FPCupdeluxe basedir:   '+FPCupManager.BaseDirectory);

  AddMessage('FPC URL:               '+FPCupManager.FPCURL);
  AddMessage('FPC options:           '+FPCupManager.FPCOPT);
  AddMessage('FPC source directory:  '+FPCupManager.FPCSourceDirectory);
  AddMessage('FPC install directory: '+FPCupManager.FPCInstallDirectory);

  AddMessage('Lazarus URL:               '+FPCupManager.LazarusURL);
  AddMessage('Lazarus options:           '+FPCupManager.LazarusOPT);
  AddMessage('Lazarus source directory:  '+FPCupManager.LazarusSourceDirectory);
  AddMessage('Lazarus install directory: '+FPCupManager.LazarusInstallDirectory);

  AddMessage('');
  AddMessage('Please stand back and enjoy !');
  AddMessage('');

  //Create base install directory, the place the magic happens
  ForceDirectoriesSafe(FPCupManager.BaseDirectory);

  //save install settings in install directory
  SetFPCUPSettings(IncludeTrailingPathDelimiter(FPCupManager.BaseDirectory));

  Application.ProcessMessages;

  {$ifdef RemoteLog}
  aVersion:=FPCTarget;
  if (ListBoxFPCTarget.ItemIndex<>-1) then aVersion:=ListBoxFPCTarget.GetSelectedText;
  aDataClient.UpInfo.FPCVersion:=ExtractFileName(aVersion);

  aVersion:=LazarusTarget;
  if (ListBoxLazarusTarget.ItemIndex<>-1) then aVersion:=ListBoxLazarusTarget.GetSelectedText;
  aDataClient.UpInfo.LazarusVersion:=ExtractFileName(aVersion);

  aDataClient.UpInfo.UpInstallDir:=FPCupManager.BaseDirectory;
  {$endif}

  AddMessage(DateTimeToStr(now)+': '+BeginSnippet+' V'+RevisionStr+' ('+VersionDate+') started.');
  AddMessage('FPCUPdeluxe V'+DELUXEVERSION+' for '+GetTargetCPUOS+' running on '+GetDistro);
  AddMessage('');

  try
    result:=FPCupManager.Run;
    if (NOT result) then
    begin
      AddMessage('');
      AddMessage('');
      if MissingCrossBins then AddMessage('Fpcupdeluxe failed due to missing cross binary tools.')
      else if MissingCrossLibs then AddMessage('Fpcupdeluxe failed due to missing cross libraries.')
      else
      begin
        AddMessage('ERROR: Fpcupdeluxe fatal error !');
        // skip reporting trivial errors about missing things
        if (NOT MissingTools) then
        begin
          StatusMessage.Text:='Hmmm, something went wrong ... have a good look at the command screen !';
          AddMessage(FPCupManager.RunInfo);
          {$ifdef RemoteLog}
          aDataClient.UpInfo.LogEntry:=memoSummary.Text+LineEnding+FPCupManager.RunInfo;
          aDataClient.SendData;
          {$endif}
        end
        else
        begin
          StatusMessage.Text:='Something went wrong due to missing system tools or dev-libs !';
        end;
      end;
      FPCVersionLabel.Font.Color:=clRed;
      LazarusVersionLabel.Font.Color:=clRed;
    end
    else
    begin
      AddMessage('');
      AddMessage('');
      AddMessage('SUCCESS: Fpcupdeluxe ended without errors.');
      AddMessage('');

      if FPCupManager.ShortcutCreated then
      begin
        {$ifdef MSWINDOWS}
        AddMessage('Fpcupdeluxe has created a desktop shortcut to start Lazarus.');
        AddMessage('Shortcut-name: '+FPCupManager.ShortCutNameLazarus);
        AddMessage('Lazarus by fpcupdeluxe MUST be started with this shortcut !!');
        {$else}
        AddMessage('Fpcupdeluxe has created a shortcut link in your home-directory to start Lazarus.');
        AddMessage('Shortcut-link: '+FPCupManager.ShortCutNameLazarus);
        AddMessage('Lazarus MUST be started with this link !!');
        AddMessage('Fpcupdeluxe has also (tried to) create a desktop shortcut with the same name.');
        {$endif}
      end;
      AddMessage('');

      FPCVersionLabel.Font.Color:=clLime;
      LazarusVersionLabel.Font.Color:=clLime;
      StatusMessage.Text:='That went well !!!';

      {$ifdef RemoteLog}
      aDataClient.UpInfo.LogEntry:='Success !';
      aDataClient.SendData;
      {$endif}

    end;

    memoSummary.Lines.Append(BeginSnippet+' Done !!');

  except
    // just swallow exceptions
    StatusMessage.Text:=BeginSnippet+' Got an unexpected exception ... don''t know what to do unfortunately.';
    StatusMessage.Color:=clRed;
  end;

end;

function TForm1.GetFPCUPSettings(IniDirectory:string):boolean;
var
  aTarget,aURL:string;
  Cores,MemAvailable,SwapAvailable:DWord;
begin
  result:=FileExists(IniDirectory+installerUniversal.DELUXEFILENAME);

  CommandOutputScreen.ClearAll;

  AddMessage('Welcome @ FPCUPdeluxe.');
  AddMessage(Self.Caption);
  {$ifndef NetBSD}
  AddMessage('Running on '+GetDistro);
  {$ifdef FreeBSD}
  AddMessage('Detected mayor FreeBSD version '+InttoStr(GetFreeBSDVersion));
  {$endif FreeBSD}
  {$endif NetBSD}

  {$IFDEF LINUX}
  if IsLinuxMUSL then AddMessage('Seems we are running on a MUSL Linux.');
  {$ENDIF LINUX}

  {$ifdef LCLQT5}
  if LibWhich(LIBQT5) then
    AddMessage('Found system wide libQt5Pas.so and that will be used.')
  else
    AddMessage('No system wide libQt5Pas.so found. Some QT5 trickery will be used');
  {$endif}

  Cores:=GetLogicalCpuCount;
  if Cores<>0 then AddMessage('CPU cores used: '+InttoStr(Cores));

  MemAvailable:=GetTotalPhysicalMemory;
  if (MemAvailable<>0) then AddMessage('Available physical memory: '+InttoStr(MemAvailable)+' MB');

  SwapAvailable:=GetSwapFileSize;

  {$IFDEF LINUX}
  AddMessage('Available swap: '+InttoStr(SwapAvailable)+' MB');
  {$ENDIF}

  MemAvailable:=MemAvailable+SwapAvailable;

  if (MemAvailable<>0) AND (MemAvailable<1500) then
  begin
    AddMessage('Please be warned: memory is very limited for building Lazarus');
    {$IFDEF UNIX}
    AddMessage('Memory advice: Please add (more) swap space !!');
    AddMessage('Memory advice: To build Lazarus, you will need (at least) 1GB of (swap-)RAM space.');
    memoSummary.Lines.Append(BeginSnippet+' Most likely, there will not enough RAM (swap) to build Lazarus.');
    memoSummary.Lines.Append(BeginSnippet+' Expected error: Can''t call the assembler');
    memoSummary.Lines.Append(BeginSnippet+' Expected error:  Can''t call the resource compiler');
    memoSummary.Lines.Append(BeginSnippet+' Please add some RAM or swap-space (+1GB) and re-run fpcupdeluxe.');
    {$ENDIF UNIX}
  end;

  AddMessage('');

  if result then
  begin
    with TIniFile.Create(IniDirectory+installerUniversal.DELUXEFILENAME) do
    try

      AddMessage('Got settings from install directory');
      AddMessage('');

      // get names of cross-compilers
      AutoUpdateCrossCompiler(nil);

      FPCupManager.ExportOnly:=(NOT ReadBool('General','GetRepo',True));

      //Default FPC target

      aTarget:='stable';
      {$ifdef CPUAARCH64}
      aTarget:='fixes';
      {$endif}
      {$IF DEFINED(CPUPOWERPC64) AND DEFINED(FPC_ABI_ELFV2)}
      aTarget:='fixes';
      {$ENDIF}
      {$ifdef Haiku}
      aTarget:='stable.git';
      {$endif}

      aURL:=installerUniversal.GetAlias('fpcURL',aTarget);
      aURL:=ReadString('URL','fpcURL',aURL);
      // correct for [unsafe] URL in old fpcup.ini
      if Pos('http://svn.freepascal.org',aURL)>0 then aURL:=StringReplace(aURL,'http://','https://',[rfIgnoreCase]);
      aURL:=ExcludeTrailingPathDelimiter(aURL);
      FPCTarget:=aURL;


      //Default Lazarus target

      {$ifdef LCLQT5}
      aTarget:='fixes';
      {$endif}
      {$ifdef LCLCOCOA}
      aTarget:='fixes';
      {$endif}

      {$ifdef Haiku}
      {$ifdef CPUX86}
      aTarget:='stable.git';
      {$endif}
      {$ifdef CPUX86_64}
      aTarget:='trunk.git';
      {$endif}
      {$endif}

      aURL:=installerUniversal.GetAlias('lazURL',aTarget);
      aURL:=ReadString('URL','lazURL',aURL);
      // correct for [unsafe] URL in old fpcup.ini
      if Pos('http://svn.freepascal.org',aURL)>0 then aURL:=StringReplace(aURL,'http://','https://',[rfIgnoreCase]);
      aURL:=ExcludeTrailingPathDelimiter(aURL);
      LazarusTarget:=aURL;

      radgrpCPU.ItemIndex:=ReadInteger('Cross','CPUTarget',radgrpCPU.ItemIndex);
      radgrpOS.ItemIndex:=ReadInteger('Cross','OSTarget',radgrpOS.ItemIndex);

      if (listModules.Items.Count>0) then listModules.ItemIndex:=ReadInteger('General','Module',listModules.ItemIndex);

      Form2.FPCOptions:=ReadString('General','FPCOptions',Form2.FPCOptions);
      Form2.LazarusOptions:=ReadString('General','LazarusOptions','');
      Form2.FPCRevision:=ReadString('General','FPCRevision','');
      Form2.LazarusRevision:=ReadString('General','LazarusRevision','');
      Form2.FPCBranch:=ReadString('General','FPCBranch','');
      Form2.LazarusBranch:=ReadString('General','LazarusBranch','');

      Form2.SplitFPC:=ReadBool('General','SplitFPC',Form2.SplitFPC);
      Form2.SplitLazarus:=ReadBool('General','SplitLazarus',Form2.SplitLazarus);

      Form2.UseWget:=ReadBool('General','UseWget',Form2.UseWget);
      Form2.MakeJobs:=ReadBool('General','MakeJobs',Form2.MakeJobs);

      Form2.ExtraVerbose:=ReadBool('General','ExtraVerbose',False);
      Form2.UpdateOnly:=ReadBool('General','UpdateOnly',False);

      Form2.UseSoftFloat:=ReadBool('General','UseSoftFloat',Form2.UseSoftFloat);
      Form2.OnlinePatching:=ReadBool('General','OnlinePatching',Form2.OnlinePatching);

      Form2.SystemFPC:=ReadBool('General','SystemFPC',False);

      Form2.FPCPatches:=ReadString('Patches','FPCPatches','');
      Form2.LazPatches:=ReadString('Patches','LazarusPatches','');

      Form2.AutoSwitchURL:=ReadBool('General','AutoSwitchURL',False);

      Form2.FpcupBootstrappersOnly:=ReadBool('General','FpcupBootstrappersOnly',False);

      Form2.ForceLocalRepoClient:=ReadBool('General','ForceLocalRepoClient',Form2.ForceLocalRepoClient);

    finally
      Free;
    end;

    Form2.SetInstallDir(IniDirectory);

    {$ifdef usealternateui}
    alternateui_update_interface_buttons;
    {$endif}
  end
  else
  begin
    {$ifdef Solaris}
    // current trunk does not build with the standard -O2, so use -O1 for all
    Form2.FPCOptions:='-g -gl -O1';
    FPCupManager.FPCOPT:=Form2.FPCOptions;
    {$endif}
  end;
end;

function TForm1.SetFPCUPSettings(IniDirectory:string):boolean;
var
  aDir:string;
begin
  result:=false;

  if NOT Assigned(FPCupManager) then exit;
  if NOT Assigned(Form2) then exit;

  aDir:=ExtractFileDir(IncludeTrailingPathDelimiter(IniDirectory)+installerUniversal.DELUXEFILENAME);
  result:=DirectoryExists(aDir);

  if (NOT result) then exit;

  try
    with TMemIniFile.Create(aDir+DirectorySeparator+installerUniversal.DELUXEFILENAME) do
    try
      // mmm, is this correct ?  See extrasettings !!
      WriteBool('General','GetRepo',(NOT FPCupManager.ExportOnly));

      if FPCTarget<>'skip' then WriteString('URL','fpcURL',FPCTarget);
      if LazarusTarget<>'skip' then WriteString('URL','lazURL',LazarusTarget);

      if (radgrpCPU.ItemIndex<>-1) then WriteInteger('Cross','CPUTarget',radgrpCPU.ItemIndex);
      if (radgrpOS.ItemIndex<>-1) then WriteInteger('Cross','OSTarget',radgrpOS.ItemIndex);

      if ((listModules.Items.Count>0) AND (listModules.ItemIndex<>-1)) then WriteInteger('General','Module',listModules.ItemIndex);

      WriteString('General','FPCOptions',Form2.FPCOptions);
      WriteString('General','LazarusOptions',Form2.LazarusOptions);
      WriteString('General','FPCRevision',Form2.FPCRevision);
      WriteString('General','LazarusRevision',Form2.LazarusRevision);
      WriteString('General','FPCBranch',Form2.FPCBranch);
      WriteString('General','LazarusBranch',Form2.LazarusBranch);

      WriteBool('General','SplitFPC',Form2.SplitFPC);
      WriteBool('General','SplitLazarus',Form2.SplitLazarus);

      WriteBool('General','SystemFPC',Form2.SystemFPC);

      WriteBool('General','UseWget',Form2.UseWget);
      WriteBool('General','MakeJobs',Form2.MakeJobs);
      WriteBool('General','ExtraVerbose',Form2.ExtraVerbose);
      WriteBool('General','UpdateOnly',Form2.UpdateOnly);
      WriteBool('General','UseSoftFloat',Form2.UseSoftFloat);
      WriteBool('General','OnlinePatching',Form2.OnlinePatching);

      WriteString('Patches','FPCPatches',Form2.FPCPatches);
      WriteString('Patches','LazarusPatches',Form2.LazPatches);

      WriteBool('General','AutoSwitchURL',Form2.AutoSwitchURL);

      WriteBool('General','FpcupBootstrappersOnly',Form2.FpcupBootstrappersOnly);

      WriteBool('General','ForceLocalRepoClient',Form2.ForceLocalRepoClient);

      UpdateFile;
    finally
      Free;
    end;

    result:=FileExists(IniDirectory+installerUniversal.DELUXEFILENAME);

  except
    on E: Exception do
    begin
      //Infoln(installerUniversal.DELUXEFILENAME+': File creation error: '+E.Message,etError);
    end;
  end;

end;

procedure TForm1.AddMessage(const aMessage:string; const UpdateStatus:boolean=false);
var
  aMessageStrings:TStrings;
begin
  if Length(aMessage)=0 then
    CommandOutputScreen.Lines.Append('')
  else
  begin
    aMessageStrings:=TStringList.Create;
    try
      aMessageStrings.Text:=aMessage;
      CommandOutputScreen.Lines.AddStrings(aMessageStrings);
      if UpdateStatus then StatusMessage.Text:=aMessageStrings[0];
    finally
      aMessageStrings.Free;
    end;
  end;
  CommandOutputScreen.CaretX:=0;
  CommandOutputScreen.CaretY:=CommandOutputScreen.Lines.Count;
  {$ifdef usealternateui}
  alternateui_AddMessage(amessage,updatestatus);
  {$endif}
  Application.ProcessMessages;
end;

procedure TForm1.SetFPCTarget(aFPCTarget:string);
begin
  SetTarget(RealFPCURL,aFPCTarget);
end;

procedure TForm1.SetLazarusTarget(aLazarusTarget:string);
begin
  SetTarget(RealLazURL,aLazarusTarget);
end;

procedure TForm1.SetTarget(aControl:TControl;const aTarget:string='');
var
  i:integer;
  aEdit:TEdit;
  change:boolean;
  aLocalTarget:string;
  aKeyword:string;
begin
  aEdit:=nil;
  change:=false;
  aLocalTarget:=aTarget;

  if (aControl is TEdit) then
  begin
    aEdit:=TEdit(aControl);
    if (Length(aLocalTarget)=0) then aLocalTarget:=aEdit.Text;
  end
  else
  begin
    if aControl=ListBoxFPCTarget then
    begin
      aEdit:=RealFPCURL;
      if (ListBoxFPCTarget.ItemIndex<>-1) AND (Length(aLocalTarget)=0) then aLocalTarget:=ListBoxFPCTarget.GetSelectedText;
    end;
    if aControl=ListBoxLazarusTarget then
    begin
      aEdit:=RealLazURL;
      if (ListBoxLazarusTarget.ItemIndex<>-1) AND (Length(aLocalTarget)=0) then aLocalTarget:=ListBoxLazarusTarget.GetSelectedText;
    end;
  end;

  if Length(aLocalTarget)=0 then exit;

  if Pos('://',aLocalTarget)=0 then
  begin
    // translate keyword into a real URL
    if aEdit=RealFPCURL then aLocalTarget:=installerUniversal.GetAlias('fpcURL',aLocalTarget);
    if aEdit=RealLazURL then aLocalTarget:=installerUniversal.GetAlias('lazURL',aLocalTarget);
  end;

  if aEdit=RealFPCURL then
  begin
    change:=(aLocalTarget<>FFPCTarget);
    if change then FFPCTarget:=aLocalTarget;
  end;
  if aEdit=RealLazURL then
  begin
    change:=(aLocalTarget<>FLazarusTarget);
    if change then FLazarusTarget:=aLocalTarget;
  end;

  if change then
  begin
    if (aControl is TEdit) OR (Length(aTarget)>0) then
    begin
      if aEdit=RealFPCURL then
      begin
        aKeyword:=installerUniversal.GetKeyword('fpcURL',aLocalTarget);
        i:=ListBoxFPCTarget.Items.IndexOf(aKeyword);
        if i<>-1 then
        begin
          ListBoxFPCTarget.Selected[i]:=true;
          if i>5 then ListBoxFPCTarget.TopIndex:=(i-1);
        end else ListBoxFPCTarget.ClearSelection;
      end;
      if aEdit=RealLazURL then
      begin
        aKeyword:=installerUniversal.GetKeyword('lazURL',aLocalTarget);
        i:=ListBoxLazarusTarget.Items.IndexOf(aKeyword);
        if i<>-1 then
        begin
          ListBoxLazarusTarget.Selected[i]:=true;
          if i>5 then ListBoxLazarusTarget.TopIndex:=(i-1);
        end else ListBoxLazarusTarget.ClearSelection;
      end;
    end;
    if (aControl is TListBox) OR (Length(aTarget)>0) then
    begin
      aEdit.Text:=aLocalTarget;
    end;
  end;
end;

procedure TForm1.HandleInfo(var Msg: TLMessage);
var
  MsgStr: PChar;
  MsgPasStr: string;
begin
  MsgStr := {%H-}PChar(Msg.wparam);
  MsgPasStr := StrPas(MsgStr);
  CommandOutputScreen.SetFiltered(MsgPasStr);
  StrDispose(MsgStr)
end;

procedure TForm1.InitFpcupdeluxe(Data: PtrInt);
begin
  InitFPCupManager;
  {$ifdef EnableLanguages}
  TransLate(sLanguage);
  {$endif}
  {$ifdef usealternateui}
  // This must only be called once.
  If Not Alternate_ui_created then alternateui_Create_Controls;
  {$endif}
  if Form2.GetUpdates then Application.QueueAsyncCall(@CheckForUpdates,0);
end;

{$ifdef RemoteLog}
procedure TForm1.InitConsent(Data: PtrInt);
var
  aModalResult:TModalResult;
begin
  aDataClient.UpInfo.UpDistro:=GetDistro;
  if (sConsentWarning) OR (Form2.SendInfo) then
  begin
    if (sConsentWarning) then
    begin
      aModalResult:=(MessageDlg(
                   'Attention !'+sLineBreak+
                   sLineBreak +
                   'Fpcupdeluxe is able to log some install info.' + sLineBreak +
                   'This data is send towards a server,' + sLineBreak +
                   'where it is available to anybody.' + sLineBreak +
                   '(see URL shown in screen and statusbar)' + sLineBreak +
                   sLineBreak +
                   'Do you want logging info to be gathered ?'
                 ,mtConfirmation,[mbYes, mbNo],0));
      if aModalResult=mrYes
         then Form2.SendInfo:=True
         else Form2.SendInfo:=False;
    end;
  end;

  if (Form2.SendInfo) then
  begin
    AddMessage('Fpcupdeluxe logging info:');
    AddMessage('http://fpcuplogger.batterybutcher.com:8880/root/getinfohtml',true);
    AddMessage('http://fpcuplogger.batterybutcher.com:8880/root/getinfohtml?ShowErrors=yes');
  end;

end;
{$endif}

procedure TForm1.CheckForUpdates(Data: PtrInt);
var
  s:string;
begin
  AddMessage(upCheckUpdate);
  s:=checkGithubRelease(FPCUPGITREPOAPI+'/latest');
  if Length(s)>0 then
  begin
    AddMessage(upUpdateFound);
    AddMessage(FPCUPGITREPO+'/releases/latest');
    AddMessage(s);
    memoSummary.Lines.Append(upUpdateFound);
  end else AddMessage(upUpdateNotFound);
end;

end.

