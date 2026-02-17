unit SFXBuilderMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  backup, StdCtrls, ComCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button4: TButton;
    Button5: TButton;
    Label2: TLabel;
    EdBackupTitle: TEdit;
    rgBackupMode: TRadioGroup;
    rgCompressionLevel: TRadioGroup;
    Button2: TButton;
    BtnCancel: TButton;
    Panel1: TPanel;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    Panel2: TPanel;
    FileListBox: TListBox;
    BackupFile1: TBackupFile;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BackupFile1Progress(Sender: TObject; Filename: String;
      Percent: TPercentage; var Continue: Boolean);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
   I: Integer;
begin
   if OpenDialog.execute then with FileListbox.items do
   begin
     beginupdate;
     for I := 0 to OpenDialog.files.count-1 do
       if indexof(lowercase(OpenDialog.files[i])) = -1 then
          add(lowercase(OpenDialog.files[i]));
     endupdate;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
   S: string;
begin
     S := extractFilepath(application.exename)+'*.*';
     if InputQuery('Add files with wildcards', 'Enter path + file mask', S) then FileListBox.items.add(S);

end;

procedure TForm1.Button5Click(Sender: TObject);
begin
     filelistbox.items.clear;
end;

procedure TForm1.BtnCancelClick(Sender: TObject);
begin
     if not BackupFile1.busy then close
     else if MessageDlg('Do you want to abort the operation',mtConfirmation, [mbYes,mbNo], 0) = mrYes then
     begin
          Backupfile1.Stop;
//delete SFX
     end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
   Target: TStream;
   DataOffset: Integer;
begin

{ The file "SFX.EXE" is the template file for our self extracting exe.
  We expect the template in the same directory as the SFXBuilder. }

     if not fileexists(extractfilepath(application.exename)+'SFX.EXE') then Showmessage('Cannot find the template "SFX.EXE"')
     else if Filelistbox.items.count = 0 then Showmessage('No files added')
     else with SaveDialog do if execute then
     begin
          if Fileexists(filename) then if MessageDlg('Target file does already exist - do you want to overwrite it?', mtConfirmation, [mbYes,mbNo], 0) <> mrYes then exit;

{ We simply copy the template file ...}
          Copyfile(pchar(extractfilepath(application.exename)+'SFX.EXE'), pchar(Filename), false);
{ ...and open it as a stream to add the backup data }
          Target := TFilestream.create(filename, fmOpenWrite or fmShareExclusive);
{ The size of the target without data is the DataOffset. This is where the backup starts. }
          DataOffset := Target.size;
{ Go to the end of the target file }
          Target.seek(DataOffset,0);

{ Here starts the standard backup operation }
          backupfile1.backuptitle      := EdBackupTitle.text;
          backupfile1.backupmode       := TBackupMode(rgBackupmode.itemindex);
          backupfile1.compressionLevel := TCompressionLevel(rgCompressionLevel.itemindex);

          if backupfile1.backuptoStream(filelistbox.items, Target) then
          begin
{ OK, backup was successful. We write the last 4 bytes, that the SFX knows where its data starts }
               Target.writeBuffer(Dataoffset, sizeof(Dataoffset));
               Target.free;
               Showmessage(filename + ' was successfully created. Compression rate = '+inttostr(BackupFile1.compressionrate)+' %')
          end else
          begin
{ Backup failed. Delete the target file.}
               Target.free;
               Deletefile(filename);
               Showmessage('Creation of self extracting EXE failed or aborted');
          end;
     end;

end;

procedure TForm1.BackupFile1Progress(Sender: TObject; Filename: String;
  Percent: TPercentage; var Continue: Boolean);
begin
     with Progressbar1 do
     begin
          visible := Percent < 100;
          if visible then position := Percent;
     end;
     if Percent < 100 then Label1.caption := Filename else Label1.caption := '';
end;

end.
