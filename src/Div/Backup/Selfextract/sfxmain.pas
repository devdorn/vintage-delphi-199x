unit SFXMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Buttons, ExtCtrls, backup, StdCtrls;

type          
  TForm1 = class(TForm)
    ListView: TListView;
    ImageList1: TImageList;
    Panel1: TPanel;
    StatusBar: TStatusBar;
    BtnSelect: TSpeedButton;
    BackupFile1: TBackupFile;
    BtnClear: TSpeedButton;
    BtnRestore: TSpeedButton;
    CbPath: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure ListViewClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnRestoreClick(Sender: TObject);
    procedure BackupFile1RestoreFile(Sender: TObject; var Filename: String;
      FA: Integer; var DoRestore: Boolean);
    procedure BackupFile1Progress(Sender: TObject; Filename: String;
      Percent: TPercentage; var Continue: Boolean);
    procedure BtnSelectClick(Sender: TObject);
    procedure BtnClearClick(Sender: TObject);
  private
    Source: TStream;
    DataOffset: Integer;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var
   Files: TStringlist;
   I: integer;
   S, FA, SZ: string;
   Item: TListItem;
begin
{ SOURCE is a TStream object and we create it while we are opening the SFX (ourselfs).
  The format of the SFX must be:

  <SFX.EXE>       The original compiled EXE file without data.
  <Data...        This is the backup data, the compressed files
   ...>           that we want to extract.
  <DataOffset>    The last 4 byte must point to the Offset where the backup data starts.
}


     try
{ Create a stringlist to read the content from the built-in archive }
        Files := TStringlist.create;
{ Create the SOURCE filestream - this is the SFX itself }
        Source := TFilestream.create(application.exename, fmOpenRead or fmShareDenyNone);
{ Goto the very end of the file ... }
        Source.seek(source.size - sizeof(DataOffset), 0);
{ ... and read the last 4 bytes. They tell us where the archive data starts }
        Source.readbuffer(DataOffset, sizeof(DataOffset));
{ Set the source stream position to the DataOffset. This is the absolute offset from the beginning of the file }
        Source.seek(DataOffset, 0);

{ OK - here we read the BackupTitle and the file list. If this is NOT a valid SFX,
  this function would fail and the program raises an exception }
        Form1.caption := backupfile1.getArchiveTitleFromStream(Source, Files);

{ FILES now contains the list of files in the archive. We resolve the strings and
  fill the listview }
        Listview.items.beginupdate;
        Listview.items.clear;

        Statusbar.panels[1].text := 'Total '+inttostr(backupfile1.FilesTotal)+' files, '+inttostr(backupfile1.SizeTotal)+' bytes';
        for I := 0 to Files.count-1 do
        begin
            S  := copy(files[i],1,pos(#9,Files[i])-1);  //file name
            FA := copy(files[i],pos(#9,Files[i])+1,pos('=',Files[i])-pos(#9,Files[i])-1);  //file age
            SZ := copy(files[i],pos('=',Files[i])+1, length(Files[i])-pos('=',Files[i]));  //file size in Bytes

            Item := ListView.Items.Add;
            Item.Caption := ExtractFileName(S);
            if pos(lowercase(extractfileext(s)),'.exe.com') = 0 then Item.imageindex := 1;

            Item.Subitems.Add( DateToStr(FileDateToDateTime(StrtoInt(FA))) );
            Item.Subitems.Add( TimeToStr(FileDateToDateTime(StrtoInt(FA))) );
            Item.SubItems.Add( SZ );
            Item.SubItems.Add( ExtractFileDir(S) );
        end;
        Listview.items.endupdate;
{ Done. We don't need the stringlist anymore }
        files.free;
{ Just update the status bar }
        ListViewClick(self);
     except
        Files.free;
        Source.free;
        Showmessage('Not a valid self extracting archive. Please use SFXBuilder first.');
{ Stop the program on exception }
        halt;
     end;
end;

procedure TForm1.ListViewClick(Sender: TObject);
var
   I: integer;
   Item: TListItem;
begin
     i := 0;
     if ListView.selcount > 0 then
     begin
        Item := Listview.selected;
        while Item <> nil do
        begin
           i := i + strtoint(Item.subitems[2]);
           Item := ListView.getnextitem(item, sdAll, [isSelected]);
        end;
     end;
     Statusbar.panels[0].text := 'Selected ' + inttostr(Listview.selcount)+' files, '+inttostr(i)+' bytes';
     BtnRestore.enabled := Listview.selcount > 0;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     try
        Source.free;
     except
     end;
end;

procedure TForm1.BtnRestoreClick(Sender: TObject);
begin
     Screen.cursor := crHourglass;
{ Move stream position to the start of the data stream }
     Source.seek(DataOffset, 0);
{ Start restore operation }
     BackupFile1.restorefromstream(Source, '');
{ Upate the status bar }
     Listviewclick(self);
     Screen.cursor := crDefault;
end;

procedure TForm1.BackupFile1RestoreFile(Sender: TObject; var Filename: String; FA: Integer; var DoRestore: Boolean);
var
   Item: TListItem;
begin
     DoRestore := false;
{ We have to check if the current file is selected to restore }
     Item := Listview.selected;
     while (Item <> nil) do
     begin
          if filename = (item.subitems[3]+'\'+item.caption) then
          begin
{ Yes, it is }
               DoRestore := true;
               break;
          end;
          Item := ListView.getnextitem(item, sdAll, [isSelected]);
     end;

{ Expand path name of target file }
     if DoRestore then
     begin
          if CbPath.checked then Filename := extractfilepath(application.exename) + copy(filename, 4, length(filename)-4)
          else Filename := extractfilepath(application.exename) + extractfilename(filename);

          if FileExists(filename) then
          begin
               case MessageDlg('File "'+filename+'" does already exist. Do you want to overwrite it?', mtConfirmation, mbYesNoCancel, 0) of
               mrYes: DoRestore := true;
               mrNo:  DoRestore := false;
               mrCancel: begin
                         DoRestore := false;
                         BackupFile1.stop;
                         end;
               end;
          end;
     end;
end;

procedure TForm1.BackupFile1Progress(Sender: TObject; Filename: String;
  Percent: TPercentage; var Continue: Boolean);
begin
     Statusbar.panels[1].text := 'Extracting ...  ' + inttostr(Percent) + '% completed';
end;

procedure TForm1.BtnSelectClick(Sender: TObject);
var
   I: integer;
begin
     for I := 0 to Listview.items.count-1 do Listview.items[i].selected := true;
     Listviewclick(self);
end;

procedure TForm1.BtnClearClick(Sender: TObject);
var
   I: integer;
begin
     for I := 0 to Listview.items.count-1 do Listview.items[i].selected := false;
     Listviewclick(self);
end;

end.
