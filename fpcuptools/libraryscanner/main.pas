unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnStartScan: TButton;
    btnGetFiles: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    procedure btnStartScanClick(Sender: TObject);
    procedure btnGetFilesClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

uses
  process,FileUtil,LazFileUtils,LookupStringList;

const
  UNIXSEARCHDIRS : array [0..4] of string = (
  '/lib',
  '/lib64',
  '/usr/lib',
  '/usr/lib/x86_64-linux-gnu',
  '/usr/local/lib'
  );

const FPCLIBS : array [0..35] of string = (
  'crtbegin.o',
  'crtbeginS.o',
  'crtend.o',
  'crtendS.o',
  'crt1.o',
  'crti.o',
  'crtn.o',
  'Mcrt1.o',
  'Scrt1.o',
  'grcrt1.o',
  'ld-linux.so.2',
  'ld-linux-x86-64.so.2',
  'libanl.so.1',
  'libcrypt.so.1',
  'libc.so',
  'libc.so.6',
  'libc_nonshared.a',
  'libdb1.so.2',
  'libdb2.so.3',
  'libdl.so.2',
  'libm.so.6',
  'libnsl.so.1',
  'libnss_compat.so.2',
  'libnss_dns6.so.2',
  'libnss_dns.so.2',
  'libnss_files.so.2',
  'libnss_hesiod.so.2',
  'libnss_ldap.so.2',
  'libnss_nisplus.so.2',
  'libnss_nis.so.2',
  'libpthread.so.0',
  'libresolv.so.2',
  'librt.so.1',
  'libthread_db.so.1',
  'libutil.so.1',
  'libz.so'
);

const LAZLIBS : array [0..18] of string = (
  'libgdk-x11-2.0.so.0',
  'libgtk-x11-2.0.so.0',
  'libX11.so.6',
  'libXtst.so.6',
  'libgdk_pixbuf-2.0.so.0',
  'libgobject-2.0.so.0',
  'libglib-2.0.so.0',
  'libgthread-2.0.so.0',
  'libgmodule-2.0.so.0',
  'libpango-1.0.so.0',
  'libcairo.so.2',
  'libatk-1.0.so.0',
  'libicui18n.so',
  'libgtk-3.so.0',
  'libsqlite3.so.0',
  'libusb-1.0.so.0',
  'libGL.so',
  'libEGL.so',
  'libvulkan.so.1'
);

{ TForm1 }


function GetStartupObjects:string;
const
  LINKFILE='crtbegin.o';
  SEARCHDIRS : array [0..5] of string = (
    '/usr/local/lib/',
    '/usr/lib/',
    '/usr/local/lib/gcc/',
    '/usr/lib/gcc/',
    '/lib/gcc/',
    '/lib/'
    );

var
  LinkFiles     : TStringList;
  Output,s1,s2  : string;
  i,j           : integer;
  ReturnCode    : integer;
  FoundLinkFile : boolean;
  OutputLines   : TStringList;
begin
  FoundLinkFile:=false;
  result:='';

  for i:=Low(SEARCHDIRS) to High(SEARCHDIRS) do
  begin
    s1:=SEARCHDIRS[i];
    if FileExists(s1+LINKFILE) then FoundLinkFile:=true;
    if FoundLinkFile then
    begin
      result:=s1;
      break;
    end;
  end;

  {$ifdef Haiku}
  if (NOT FoundLinkFile) then
  begin
    s1:='/boot/system/develop/tools/x86/lib';
    if NOT DirectoryExists(s1) then s1:='/boot/system/develop/tools/lib';
    if DirectoryExists(s1) then
    begin
      LinkFiles := TStringList.Create;
      try
        FindAllFiles(LinkFiles, s1, '*.o', true);
        if (LinkFiles.Count>0) then
        begin
          for i:=0 to (LinkFiles.Count-1) do
          begin
            if Pos(DirectorySeparator+LINKFILE,LinkFiles[i])>0 then
            begin
              result:=ExtractFileDir(LinkFiles[i]);
              FoundLinkFile:=true;
              break;
            end;
          end;
        end;
      finally
        LinkFiles.Free;
      end;
    end;
    if (NOT FoundLinkFile) then
    begin
      s1:='/boot/system/develop/lib/x86/';
      if NOT DirectoryExists(s1) then s1:='/boot/system/develop/lib/';
      if FileExists(s1+'crti.o') then FoundLinkFile:=true;
      if FoundLinkFile then result:=s1;
    end;
  end;
  {$endif}

  if FoundLinkFile then exit;

  try
    Output:='';
    if RunCommand('gcc',['-print-prog-name=cc1'], Output,[poUsePipes, poStderrToOutPut]{$IF DEFINED(FPC_FULLVERSION) AND (FPC_FULLVERSION >= 30200)},swoHide{$ENDIF}) then
    begin
      s1:=Trim(Output);
      if FileExists(s1) then
      begin
        s2:=ExtractFileDir(s1);
        if FileExists(s2+DirectorySeparator+LINKFILE) then
        begin
          result:=s2;
          FoundLinkFile:=true;
        end;
      end;
    end;

    if (NOT FoundLinkFile) then
    begin
      Output:='';
      if RunCommand('gcc',['-print-search-dirs'], Output,[poUsePipes, poStderrToOutPut]{$IF DEFINED(FPC_FULLVERSION) AND (FPC_FULLVERSION >= 30200)},swoHide{$ENDIF}) then
      begin
        Output:=TrimRight(Output);
        if Length(Output)>0 then
        begin
          OutputLines:=TStringList.Create;
          try
            OutputLines.Text:=Output;
            if OutputLines.Count>0 then
            begin
              for i:=0 to (OutputLines.Count-1) do
              begin
                s1:=OutputLines.Strings[i];
                j:=Pos('libraries:',s1);
                if j=1 then
                begin
                  j:=Pos(DirectorySeparator,s1);
                  if j>0 then
                  begin
                    Delete(s1,1,j-1);
                    LinkFiles := TStringList.Create;
                    try
                      LinkFiles.StrictDelimiter:=true;
                      LinkFiles.Delimiter:=':';
                      LinkFiles.DelimitedText:=s1;
                      if LinkFiles.Count>0 then
                      begin
                        for j:=0 to (LinkFiles.Count-1) do
                        begin
                          s2:=ExcludeTrailingPathDelimiter(LinkFiles.Strings[j]);
                          //s2:=ExtractFileDir(LinkFiles.Strings[j]);
                          if FileExists(s2+DirectorySeparator+LINKFILE) then
                          begin
                            result:=s2;
                            FoundLinkFile:=true;
                            break;
                          end;
                        end;
                      end;
                    finally
                      LinkFiles.Free;
                    end;
                  end;
                  break;
                end;
              end;
            end;
          finally
            OutputLines.Free;
          end;
        end;
      end;
    end;

    if (NOT FoundLinkFile) then
    begin
      Output:='';
      if RunCommand('gcc',['-v'], Output,[poUsePipes, poStderrToOutPut]{$IF DEFINED(FPC_FULLVERSION) AND (FPC_FULLVERSION >= 30200)},swoHide{$ENDIF}) then
      begin

        s1:='COLLECT_LTO_WRAPPER=';
        i:=Ansipos(s1, Output);
        if (i>0) then
        begin
          s2:=RightStr(Output,Length(Output)-(i+Length(s1)-1));
          // find space as delimiter
          i:=Ansipos(' ', s2);
          // find lf as delimiter
          j:=Ansipos(#10, s2);
          if (j>0) AND (j<i) then i:=j;
          // find cr as delimiter
          j:=Ansipos(#13, s2);
          if (j>0) AND (j<i) then i:=j;
          if (i>0) then delete(s2,i,MaxInt);
          s2:=ExtractFileDir(s2);
          if FileExists(s2+DirectorySeparator+LINKFILE) then
          begin
            result:=s2;
            FoundLinkFile:=true;
          end;
        end;

        if (NOT FoundLinkFile) then
        begin
          s1:=' --libdir=';
          //s1:=' --libexecdir=';
          i:=Ansipos(s1, Output);
          if (i>0) then
          begin
            s2:=RightStr(Output,Length(Output)-(i+Length(s1)-1));
            // find space as delimiter
            i:=Ansipos(' ', s2);
            // find lf as delimiter
            j:=Ansipos(#10, s2);
            if (j>0) AND (j<i) then i:=j;
            // find cr as delimiter
            j:=Ansipos(#13, s2);
            if (j>0) AND (j<i) then i:=j;
            if (i>0) then delete(s2,i,MaxInt);
            result:=IncludeTrailingPathDelimiter(s2);
          end;

          i:=Ansipos('gcc', result);
          if i=0 then result:=result+'gcc'+DirectorySeparator;

          s1:=' --build=';
          i:=Ansipos(s1, Output);
          if i=0 then
          begin
            s1:=' --target=';
            i:=Ansipos(s1, Output);
          end;
          if (i>0) then
          begin
            s2:=RightStr(Output,Length(Output)-(i+Length(s1)-1));
            // find space as delimiter
            i:=Ansipos(' ', s2);
            // find lf as delimiter
            j:=Ansipos(#10, s2);
            if (j>0) AND (j<i) then i:=j;
            // find cr as delimiter
            j:=Ansipos(#13, s2);
            if (j>0) AND (j<i) then i:=j;
            if (i>0) then delete(s2,i,MaxInt);
            result:=result+s2+DirectorySeparator;
          end;

          s1:='gcc version ';
          i:=Ansipos(s1, Output);
          if (i>0) then
          begin
            s2:=RightStr(Output,Length(Output)-(i+Length(s1)-1));
            // find space as delimiter
            i:=Ansipos(' ', s2);
            // find lf as delimiter
            j:=Ansipos(#10, s2);
            if (j>0) AND (j<i) then i:=j;
            // find cr as delimiter
            j:=Ansipos(#13, s2);
            if (j>0) AND (j<i) then i:=j;
            if (i>0) then delete(s2,i,MaxInt);
            result:=result+s2;
            if FileExists(result+DirectorySeparator+LINKFILE) then
            begin
              FoundLinkFile:=true;
            end;
          end;
        end;
      end;
    end;

  except
    // ignore errors
  end;

  //In case of errors or failures, do a brute force search of gcc link file
  if (NOT FoundLinkFile) then
  begin
    {$IF (defined(BSD)) and (not defined(Darwin))}
    result:='/usr/local/lib/gcc';
    {$else}
    result:='/usr/lib/gcc';
    {$endif}

    if DirectoryExists(result) then
    begin
      LinkFiles := TStringList.Create;
      try
        FindAllFiles(LinkFiles, result, '*.o', true);
        if (LinkFiles.Count>0) then
        begin
          for i:=0 to (LinkFiles.Count-1) do
          begin
            if Pos(DirectorySeparator+LINKFILE,LinkFiles[i])>0 then
            begin
              result:=ExtractFileDir(LinkFiles[i]);
              FoundLinkFile:=true;
              break;
            end;
          end;
        end;
      finally
        LinkFiles.Free;
      end;
    end;
  end;

end;



procedure TForm1.btnStartScanClick(Sender: TObject);
const
  MAGICNEEDED = '(NEEDED)';
  MAGICSHARED = 'Shared library:';

var
  GccDirectory:string;
  SearchLib,SearchDir:string;
  SearchResultList:TStringList;
  FinalSearchResultList:TLookupStringList;
  Index:integer;
  //sd:string;
procedure CheckAndAddLibrary(aLib:string);
var
  SearchResult:string;
  FileName:string;
  i,j: integer;
  sd,s:string;
begin
  for sd in UNIXSEARCHDIRS do
  begin
    FileName:=sd+DirectorySeparator+aLib;
    if FileExists(FileName) then
    begin
      FinalSearchResultList.Add('['+ExtractFileName(FileName)+']');
      while FileIsSymlink(FileName) do FileName:=GetPhysicalFilename(FileName,pfeException);
      SearchResult:='';
      RunCommand('readelf',['-d','-W',FileName],SearchResult,[]);
      SearchResultList.Text:=SearchResult;
      for i:=0 to Pred(SearchResultList.Count) do
      begin
        s:=SearchResultList.Strings[i];
        if (Pos(MAGICNEEDED,s)>0) then
        begin
          j:=Pos(MAGICSHARED,s);
          if (j<>-1) then
          begin
            s:=Trim(Copy(s,j+Length(MAGICSHARED),MaxInt));
            FinalSearchResultList.Add(s);
          end;
        end;
      end;
      FileName:='';
      break;
    end;
  end;
  if (Length(FileName)>0) then
  begin
    FileName:=GccDirectory+DirectorySeparator+aLib;
    if FileExists(FileName) then
    begin
      FinalSearchResultList.Add('['+aLib+']');
      FileName:='';
    end;
    if (Length(FileName)>0) then
    begin
      Memo2.Lines.Append('Not found: '+aLib);
    end;
  end;
end;
begin
  Memo1.Lines.Clear;
  Memo2.Lines.Clear;
  Memo3.Lines.Clear;

  //sd:=SysUtils.GetEnvironmentVariable('LIBRARY_PATH');
  //if (Length(sd)=0) then sd:=SysUtils.GetEnvironmentVariable('LD_LIBRARY_PATH');
  //if ((Length(sd)>0) AND (DirectoryExists(sd))) then
  //begin
  //end;
  GccDirectory:=GetStartupObjects;

  SearchResultList:=TStringList.Create;
  FinalSearchResultList:=TLookupStringList.Create;
  try
    for SearchLib in FPCLIBS do
    begin
      CheckAndAddLibrary(SearchLib);
    end;
    for SearchLib in LAZLIBS do
    begin
      CheckAndAddLibrary(SearchLib);
    end;
    FinalSearchResultList.Sort;
    Memo1.Lines.Text:=FinalSearchResultList.Text;

    for Index:=0 to Pred(FinalSearchResultList.Count) do
    begin
      SearchLib:=FinalSearchResultList.Strings[Index];
      SearchLib:=Copy(SearchLib,2,Length(SearchLib)-2);
      for SearchDir in UNIXSEARCHDIRS do
      begin
        if FileExists(SearchDir+DirectorySeparator+SearchLib) then
        begin
          Memo3.Lines.Append(SearchDir+DirectorySeparator+SearchLib);
          SearchLib:='';
          break;
        end;
      end;
      if (Length(SearchLib)>0) then
      begin
        if FileExists(GccDirectory+DirectorySeparator+SearchLib) then
        begin
          Memo3.Lines.Append(GccDirectory+DirectorySeparator+SearchLib);
          SearchLib:='';
        end;
      end;
      if (Length(SearchLib)>0) then
      begin
        Memo2.Lines.Append('Not found: '+SearchLib);
      end;
    end;
  finally
    FinalSearchResultList.Free;
    SearchResultList.Free;
  end;
end;

procedure TForm1.btnGetFilesClick(Sender: TObject);
var
  Index:integer;
  FileName,TargetFile:string;
begin
  ForceDirectories(Application.Location+'libs');
  for Index:=0 to Pred(Memo3.Lines.Count) do
  begin
    FileName:=Memo3.Lines.Strings[Index];
    TargetFile:=Application.Location+'libs'+DirectorySeparator+ExtractFileName(FileName);
    CopyFile(FileName,TargetFile);
  end;
end;

end.
