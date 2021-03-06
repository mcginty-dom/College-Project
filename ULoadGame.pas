unit ULoadGame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Data.DB, Data.Win.ADODB, utilities;

type
  TFmLoadGame = class(TForm)
    LblTitle: TLabel;
    BtnSaveFile1: TButton;
    GbxSave1: TGroupBox;
    LblFileName1: TLabel;
    LblFactionName1: TLabel;
    LblMapName1: TLabel;
    LblNumberOfTurns1: TLabel;
    LblFileName1Caption: TLabel;
    LblMapName1Caption: TLabel;
    LblFactionName1Caption: TLabel;
    LblNumberOfTurns1Caption: TLabel;
    GbxSave2: TGroupBox;
    LblFileName2: TLabel;
    LblMapName2: TLabel;
    LblNumberOfTurns2: TLabel;
    LblFactionName2Caption: TLabel;
    LblFileName2Caption: TLabel;
    LblMapName2Caption: TLabel;
    LblNumberOfTurns2Caption: TLabel;
    BtnSaveFile2: TButton;
    GbxSave3: TGroupBox;
    LblFactionName3: TLabel;
    LblFileName3: TLabel;
    LblMapName3: TLabel;
    LblNumberOfTurns3: TLabel;
    LblFactionName3Caption: TLabel;
    LblFileName3Caption: TLabel;
    LblMapName3Caption: TLabel;
    LblNumberOfTurns3Caption: TLabel;
    BtnSaveFile3: TButton;
    ImLogo: TImage;
    ADOQuery1: TADOQuery;
    BtnDeleteFile3: TButton;
    LblFactionName2: TLabel;
    BtnDeleteFile1: TButton;
    BtnDeleteFile2: TButton;
    ADOSaveState: TADOTable;
    ADOTile: TADOTable;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BtnSaveFile1Click(Sender: TObject);
    procedure BtnSaveFile2Click(Sender: TObject);
    procedure BtnSaveFile3Click(Sender: TObject);
    procedure LoadingGame(SaveID:Integer);
    procedure DeletingGame(SaveID:Integer);
    procedure BtnDeleteFile1Click(Sender: TObject);
    procedure BtnDeleteFile3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BtnDeleteFile2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmLoadGame: TFmLoadGame;

implementation

{$R *.dfm}

uses UMenu, UCurrentGame, ULogin;

procedure TFmLoadGame.LoadingGame(SaveID:Integer);
var MapID:Integer;
begin
  //select query to find MapID
  AdoQuery1.Close; //assign new SQL expression
  AdoQuery1.SQL.Clear;
  AdoQuery1.SQL.Add('Select MapID FROM SaveState WHERE ((AccountID = :AccID) AND (SaveId = :SavID))');
  ADOQuery1.Parameters.ParamByName('AccId').Value := AccountId;
  ADOQuery1.Parameters.ParamByName('SavId').Value := SaveID;
  AdoQuery1.Open;
  MapID:=ADOQuery1.Fields[0].AsInteger;
  isLoad:=True;
  fmcurrentgame.tag:=MapID;
  FmCurrentGame.LblSaveId.Caption:=IntToStr(SaveID);
  FmCurrentGame.LblMapTitle.Caption:=Map[MapID].Name;
  FmCurrentGame.Show;
  FmLoadGame.Hide;
end;

procedure TFmLoadGame.DeletingGame(SaveID: Integer);
var X,Y:Integer;
    TileID:String;
begin
  if ADOSaveState.Locate('SaveId;AccountID',VarArrayOf([SaveID,AccountID]),[]) then
  begin
    //Need to delete all tiles before the save state
    for Y := 1 to 4 do
      begin
        for X := 1 to 7 do
          begin
            TileID:='('+IntToStr(X)+','+IntToStr(Y)+')';
            if ADOTile.Locate('TileID;AccountID;SaveID',VarArrayOf([TileID,AccountID,SaveID]),[])
            then ADOTile.Delete;
          end;
      end;
    ADOTile.Refresh;
    adotile.Close; adotile.open;
    ADOSaveState.Delete;
    ADOSaveState.Refresh;
    TLabel(FindComponent('LblFileName'+IntToStr(SaveID))).Caption:='';
    TLabel(FindComponent('LblMapName'+IntToStr(SaveID))).Caption:='';
    TLabel(FindComponent('LblFactionName'+IntToStr(SaveID))).Caption:='';
    TLabel(FindComponent('LblNumberOfTurns'+IntToStr(SaveID))).Caption:='';
    Showmessage('Deleted Save File '+IntToStr(SaveID)+'.');
  end
  else Showmessage('You do not have a save file '+IntToStr(SaveID)+'.');
end;

procedure TFmLoadGame.BtnDeleteFile1Click(Sender: TObject);
begin
  if (LblMapName1.Caption='') then Showmessage('Save file 1 is already empty.')
  else if messageDlg('Are you sure you would like to delete save file 1?',mtconfirmation,[mbyes,mbno],0)=mryes then
    DeletingGame(1);
end;

procedure TFmLoadGame.BtnDeleteFile2Click(Sender: TObject);
begin
  if (LblMapName2.Caption='') then Showmessage('Save file 2 is already empty.')
  else if messageDlg('Are you sure you would like to delete save file 2?',mtconfirmation,[mbyes,mbno],0)=mryes then
    DeletingGame(2);
end;

procedure TFmLoadGame.BtnDeleteFile3Click(Sender: TObject);
begin
  if (LblMapName3.Caption='') then Showmessage('Save file 3 is already empty.')
  else if messageDlg('Are you sure you would like to delete save file 3?',mtconfirmation,[mbyes,mbno],0)=mryes then
    DeletingGame(3);
end;

procedure TFmLoadGame.BtnSaveFile1Click(Sender: TObject);
begin
  if (LblMapName1.Caption='') then
    Showmessage('Cannot load an empty file.')
  else LoadingGame(1);
end;

procedure TFmLoadGame.BtnSaveFile2Click(Sender: TObject);
begin
  if (LblMapName2.Caption='') then
    Showmessage('Cannot load an empty file.')
  else LoadingGame(2);
end;

procedure TFmLoadGame.BtnSaveFile3Click(Sender: TObject);
begin
if (LblMapName3.Caption='') then
    Showmessage('Cannot load an empty file.')
  else LoadingGame(3);
end;

procedure TFmLoadGame.FormActivate(Sender: TObject);
begin
  AdoSaveState.ConnectionString:= ConnStr;
  AdoSaveState.TableName:='SaveState';
  AdoSaveState.Open;
  AdoTile.ConnectionString:= ConnStr;
  AdoTile.TableName:='Tile';
  AdoTile.Open;
  AdoQuery1.ConnectionString:=Connstr;
end;

procedure TFmLoadGame.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FmMenu.Show;
AdoSaveState.Close;
AdoTile.Close;
end;
procedure TFmLoadGame.FormShow(Sender: TObject);
var
  I: Integer;
  FileName:Array[1..3] of String;
  FactionID:Array[1..3] of Integer;
  FactionName:Array[1..3] of String;
  MapID:Array[1..3] of Integer;
  MapName:Array[1..3] of String;
  NumberOfTurns:Array[1..3] of Integer;
begin
Activate;
//query to find filename, mapid, factionid and numberofturns for only the current account
for I := 1 to 3 do
  begin
  if ADOSaveState.Locate('AccountID;SaveId',VarArrayOf([AccountID,I]),[]) then
  begin
    AdoQuery1.Close; //assign new SQL expression
    AdoQuery1.SQL.Clear;
    AdoQuery1.SQL.Add('Select FileName,MapID,FactionID,NumberOfTurns FROM SaveState WHERE' +
    '(AccountID = '+IntToStr(AccountID)+') AND (SaveID = '+IntToStr(I)+')');
    AdoQuery1.Open;
    FileName[I]:=ADOQuery1.Fields[0].AsString;
    MapID[I]:=ADOQuery1.Fields[1].AsInteger;
    FactionID[I]:=AdoQuery1.Fields[2].AsInteger;
    NumberOfTurns[I]:=ADOQuery1.Fields[3].AsInteger;
  end;
  end;
//query to find what map ID's link up to find the name of the map
for I := 1 to 3 do
  begin
  AdoQuery1.Close; //assign new SQL expression
  AdoQuery1.SQL.Clear;
  AdoQuery1.SQL.Add('Select Name FROM Map WHERE' +
  '(MapID = '+IntToStr(MapID[I])+')');
  AdoQuery1.Open;
  MapName[I]:=ADOQuery1.Fields[0].AsString;
  end;
//query to find what faction ID's link up to find the name of the faction
for I := 1 to 3 do
  begin
  AdoQuery1.Close; //assign new SQL expression
  AdoQuery1.SQL.Clear;
  AdoQuery1.SQL.Add('Select Name FROM Faction WHERE' +
  '(FactionID = '+IntToStr(FactionID[I])+')');
  AdoQuery1.Open;
  FactionName[I]:=ADOQuery1.Fields[0].AsString;
  end;
//Sets labels to their correct values
LblFileName1.Caption:=FileName[1];
LblFileName2.Caption:=FileName[2];
LblFileName3.Caption:=FileName[3];
LblMapName1.Caption:=MapName[1];
LblMapName2.Caption:=MapName[2];
LblMapName3.Caption:=MapName[3];
LblFactionName1.Caption:=FactionName[1];
LblFactionName2.Caption:=FactionName[2];
LblFactionName3.Caption:=FactionName[3];
LblNumberOfTurns1.Caption:=IntToStr(NumberOfTurns[1]);
LblNumberOfTurns2.Caption:=IntToStr(NumberOfTurns[2]);
LblNumberOfTurns3.Caption:=IntToStr(NumberOfTurns[3]);
end;

end.
