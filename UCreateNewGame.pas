unit UCreateNewGame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.DBCtrls,
  Data.Win.ADODB, Utilities;

type
  TFmCreateNewGame = class(TForm)
    LblCreateNewGame: TLabel;
    LblFactionType: TLabel;
    LblFactionCapital: TLabel;
    LblFactionTrait: TLabel;
    LblMapSize: TLabel;
    LblMapName: TLabel;
    LblSaveFileName: TLabel;
    EdSaveFileName: TEdit;
    GbxFaction: TGroupBox;
    LblFactionTypeOutput: TLabel;
    LblFactionCapitalOutput: TLabel;
    LblFactionTraitOutput: TLabel;
    LblFactionName: TLabel;
    GbxMap: TGroupBox;
    LblMapSizeOutput: TLabel;
    LblSaveID: TLabel;
    BtnCreateGame: TButton;
    BtnCancel: TButton;
    ADOMap: TADOTable;
    DBCmbMap: TDBLookupComboBox;
    DSMap: TDataSource;
    ADOFaction: TADOTable;
    DSFaction: TDataSource;
    DbCmbFaction: TDBLookupComboBox;
    ADOQuery1: TADOQuery;
    ADOSaveState: TADOTable;
    LblFactionID: TLabel;
    LblFactionIdOutput: TLabel;
    LblMapID: TLabel;
    LblMapIDOutput: TLabel;
    LblMapNumberOfFactionsOutput: TLabel;
    LblMapNumberOfFactions: TLabel;
    LblSaveIDOutput: TLabel;
    procedure BtnCancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DbCmbFactionClick(Sender: TObject);
    procedure BtnCreateGameClick(Sender: TObject);
    procedure DBCmbMapClick(Sender: TObject);
    function AutoSaveID:boolean;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmCreateNewGame: TFmCreateNewGame;

implementation

{$R *.dfm}

uses UMenu, ULogin, UCurrentGame;

procedure TFmCreateNewGame.BtnCancelClick(Sender: TObject);
begin
FmCreateNewGame.Hide;
FmMenu.Show;
end;

procedure TFmCreateNewGame.BtnCreateGameClick(Sender: TObject);
begin
  if (DBCmbFaction.Text='') then ShowMessage('Please enter a faction.')
  else if (DBCmbMap.Text='') then ShowMessage('Please enter a map.')
  else if (EdSaveFileName.Text='') then ShowMessage('Please enter a file name.')
  else if (AutoSaveID) then FmCreateNewGame.Close
else
  begin
    AdoSaveState.Append;
    if (AdoSaveState.RecordCount>60) then
      ShowMessage('Database full, contact administrator.')
    else
    AdoSaveState['SaveID']:=LblSaveIDOutput.Caption;
    AdoSaveState['FileName']:=EdSaveFileName.text;
    AdoSaveState['AccountID']:=AccountID;
    AdoSaveState['MapID']:=LblMapIDOutput.Caption;
    AdoSaveState['FactionID']:=LblFactionIDOutput.Caption;
    AdoSaveState['NumberOfTurns']:=1;
    AdoSaveState['CurrentNumberOfFactions']:=LblMapNumberOfFactionsOutput.Caption;
    AdoSaveState.Post;
    Showmessage('Game created.');
    FmCurrentGame.tag:=StrToInt(LblMapIdOutput.Caption);
    FmCurrentGame.LblSaveID.Caption:=LblSaveIdOutput.Caption;
    FmCurrentGame.LblMapTitle.Caption:=DBCmbMap.Text;
    FmCurrentGame.LblFactionTitle.Caption:=DBCmbFaction.Text;
    FmCurrentGame.LblNumberOfTurns.Caption:='1';
    FmCreateNewGame.Hide;
    isLoad:=False;
    FmCurrentGame.Show;
  end
end;

procedure TFmCreateNewGame.DbCmbFactionClick(Sender: TObject);
begin
AdoQuery1.ConnectionString:=Connstr;

AdoQuery1.Close; //assign new SQL expression
AdoQuery1.SQL.Clear;
AdoQuery1.SQL.Add('Select FactionID,Type,CapitalName FROM Faction WHERE Name = :FactionName');
ADOQuery1.Parameters.ParamByName('FactionName').Value := DBCmbFaction.Text;
AdoQuery1.Open;
LblFactionIDOutput.Caption := ADOQuery1.Fields[0].AsString;
LblFactionTypeOutput.Caption := ADOQuery1.Fields[1].AsString;
LblFactionCapitalOutput.Caption := ADOQuery1.Fields[2].AsString;
end;

procedure TFmCreateNewGame.DBCmbMapClick(Sender: TObject);
begin
AdoQuery1.ConnectionString:=Connstr;

AdoQuery1.Close; //assign new SQL expression
AdoQuery1.SQL.Clear;
AdoQuery1.SQL.Add('Select MapID,XCoordinate,YCoordinate,NumberOfFactions FROM Map WHERE Name = :MapName');
ADOQuery1.Parameters.ParamByName('MapName').Value := DBCmbMap.Text;
AdoQuery1.Open;
LblMapIDOutput.Caption := ADOQuery1.Fields[0].AsString;
LblMapSizeOutput.Caption := ADOQuery1.Fields[1].AsString+'x'+AdoQuery1.Fields[2].AsString;
LblMapNumberOfFactionsOutput.Caption := ADOQuery1.Fields[3].AsString;
end;

procedure TFmCreateNewGame.FormActivate(Sender: TObject);
begin
  AdoMap.ConnectionString:= ConnStr;
  AdoMap.TableName:='Map';
  DSMap.DataSet:=AdoMap;
  DBCmbMap.ListSource:=DSMap;
  DBCmbMap.ListField:='Name';
  DBCmbMap.KeyField:='MapID';
  AdoMap.Open;
  AdoFaction.ConnectionString:= ConnStr;
  AdoFaction.TableName:='Faction';
  DSFaction.DataSet:=AdoFaction;
  DBCmbFaction.ListSource:=DSFaction;
  DBCmbFaction.ListField:='Name';
  DBCmbFaction.KeyField:='FactionID';
  AdoFaction.Open;
  AdoSaveState.ConnectionString:= ConnStr;
  AdoSaveState.TableName:='SaveState';
  AdoSaveState.Open;

end;

procedure TFmCreateNewGame.FormClose(Sender: TObject; var Action: TCloseAction);
begin
AdoMap.Close;
AdoFaction.Close;
AdoSaveState.Close;
FmMenu.Show;
end;

function TFmCreateNewGame.AutoSaveID:boolean;
var Full:Boolean;
begin
  Full:=False;
  Activate;
  adosavestate.Close; adosavestate.Open;
  if (ADOSaveState.Locate('SaveID;AccountID',VarArrayOf([1, AccountID]),[])) then
  begin
    if (ADOSaveState.Locate('SaveID;AccountID',VarArrayOf([2, AccountID]),[]))
      then begin
        if (ADOSaveState.Locate('SaveID;AccountID',VarArrayOf([3, AccountID]),[]))
          then begin
          Showmessage('You have reached the maximum number of saves. Please delete a save.');
          Full:=True;
          LblSaveIdOutput.Caption:='Save files full';
          end
          else LblSaveIdOutput.Caption:='3';
      end
      else LblSaveIdOutput.Caption:='2';
  end
  else LblSaveIdOutput.Caption:='1';
  Result:=Full;
end;

procedure TFmCreateNewGame.FormShow(Sender: TObject);
begin
  Activate;
  AutoSaveID;
end;

end.
