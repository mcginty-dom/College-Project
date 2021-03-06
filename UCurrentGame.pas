unit UCurrentGame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.Win.ADODB,comobj, Data.DB, strutils,
  Vcl.Imaging.pngimage, Vcl.MPlayer, printers;

type
  TFmCurrentGame = class(TForm)
    TileX1Y1: TImage;
    TileX2Y1: TImage;
    TileX3Y1: TImage;
    TileX4Y1: TImage;
    TileX5Y1: TImage;
    TileX1Y2: TImage;
    TileX1Y3: TImage;
    TileX1Y4: TImage;
    TileX6Y1: TImage;
    TileX7Y1: TImage;
    TileX2Y2: TImage;
    TileX3Y2: TImage;
    TileX4Y2: TImage;
    TileX5Y2: TImage;
    TileX6Y2: TImage;
    TileX7Y2: TImage;
    TileX2Y3: TImage;
    TileX3Y3: TImage;
    TileX3Y4: TImage;
    TileX4Y4: TImage;
    TileX5Y4: TImage;
    TileX6Y4: TImage;
    TileX7Y4: TImage;
    TileX7Y3: TImage;
    TileX4Y3: TImage;
    TileX6Y3: TImage;
    TileX5Y3: TImage;
    LblMapTitle: TLabel;
    TileX2Y4: TImage;
    ADOTile: TADOTable;
    ADOQuery1: TADOQuery;
    ADOCommand1: TADOCommand;
    GbxGeneral: TGroupBox;
    LblMapNameCaption: TLabel;
    LblTurnCaption: TLabel;
    BtnEndTurn: TButton;
    LblSaveId: TLabel;
    LblFactionTitle: TLabel;
    GbxTile: TGroupBox;
    LblFood: TLabel;
    LblFoodPerTurn: TLabel;
    LblGold: TLabel;
    LblGoldPerTurn: TLabel;
    LblHappiness: TLabel;
    LblHappinessPerTurn: TLabel;
    LblNameCaption: TLabel;
    LblName: TLabel;
    LblFoodCaption: TLabel;
    LblGoldCaption: TLabel;
    LblHappinessCaption: TLabel;
    LblPlayingAs: TLabel;
    LblNumberOfTurns: TLabel;
    GbxSettlement: TGroupBox;
    GbxSquadCreate: TGroupBox;
    LblCurrentSettlement: TLabel;
    LblCurrentSettlementCaption: TLabel;
    LblNextSettlement: TLabel;
    LblNextSettlementCaption: TLabel;
    LblSettlementRequirementsCaption: TLabel;
    LblSettlementRequirements: TLabel;
    LblSettlementGoldCaption: TLabel;
    BtnUpgrade: TButton;
    LblSquadCaption: TLabel;
    LblSquadNo: TLabel;
    CmbObjective: TComboBox;
    CmbTile: TComboBox;
    LblSquadRequirementsCaption: TLabel;
    LblSquadFood: TLabel;
    LblSquadHappiness: TLabel;
    LblSquadFoodCaption: TLabel;
    LblSquadHappinessCaption: TLabel;
    LblTileCoordinates: TLabel;
    LblFoodSign: TLabel;
    LblGoldSign: TLabel;
    LblHappinessSign: TLabel;
    LblSaveIDCaption: TLabel;
    SndPlayer: TMediaPlayer;
    BtnPrintTile: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ClearTerrain;
    procedure MapTerrain(MaxXValue,MaxYValue:Integer);
    procedure LoadPreviousGame(MaxXValue,MaxYValue:Integer);
    procedure GenFactionList(MaxFactions:Integer; Var PlayingFactions:TArray<String>);
    function CollisionCheck(CurrentTile:String):Boolean;
    procedure SetTileInfo(CurrentTile, CurrentFaction:String);
    procedure PlaceFactions(MaxXValue,MaxYValue:Integer);
    function CheckExpert():Boolean;
    function CheckGameWon():Boolean;
    procedure SelectTile(Name:String);
    procedure TileX1Y1Click(Sender: TObject);
    procedure TileX2Y1Click(Sender: TObject);
    procedure TileX3Y1Click(Sender: TObject);
    procedure BtnEndTurnClick(Sender: TObject);
    procedure TileX4Y1Click(Sender: TObject);
    procedure BtnUpgradeClick(Sender: TObject);
    procedure TileX5Y1Click(Sender: TObject);
    procedure TileX6Y1Click(Sender: TObject);
    procedure TileX7Y1Click(Sender: TObject);
    procedure TileX1Y2Click(Sender: TObject);
    procedure TileX2Y2Click(Sender: TObject);
    procedure TileX3Y2Click(Sender: TObject);
    procedure TileX4Y2Click(Sender: TObject);
    procedure TileX5Y2Click(Sender: TObject);
    procedure TileX6Y2Click(Sender: TObject);
    procedure TileX7Y2Click(Sender: TObject);
    procedure TileX1Y3Click(Sender: TObject);
    procedure TileX2Y3Click(Sender: TObject);
    procedure TileX3Y3Click(Sender: TObject);
    procedure TileX4Y3Click(Sender: TObject);
    procedure TileX5Y3Click(Sender: TObject);
    procedure TileX6Y3Click(Sender: TObject);
    procedure TileX7Y3Click(Sender: TObject);
    procedure TileX1Y4Click(Sender: TObject);
    procedure TileX2Y4Click(Sender: TObject);
    procedure TileX3Y4Click(Sender: TObject);
    procedure TileX4Y4Click(Sender: TObject);
    procedure TileX5Y4Click(Sender: TObject);
    procedure TileX6Y4Click(Sender: TObject);
    procedure TileX7Y4Click(Sender: TObject);
    procedure BtnPrintTileClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmCurrentGame: TFmCurrentGame;

implementation

{$R *.dfm}

uses UMenu,ULoadGame,Utilities, ULogin;

procedure TFmCurrentGame.FormActivate(Sender: TObject);
begin
  AdoTile.ConnectionString:= ConnStr;
  AdoTile.TableName:='Tile';
  AdoTile.Open;
  AdoQuery1.ConnectionString:= ConnStr;
end;

procedure TFmCurrentGame.FormClose(Sender: TObject; var Action: TCloseAction);
begin
AdoTile.Close;
FmMenu.Show;
end;

procedure TFmCurrentGame.BtnPrintTileClick(Sender: TObject);
var dpmm:integer;
begin
  with printer do
    begin
      begindoc;
        dpmm:=pagewidth div 210;
        with canvas do
        begin
            font.Name:='Calibri';
            font.Size:=24;
            font.Style:=[FSBold];
            textout(15*dpmm,35*dpmm,'Triumphant!'); //Print Title
            font.Name:='Arial';
            font.Size:=12;
            font.Style:=[];
            textout(15*dpmm,70*dpmm,LblName.Caption+' Located at '+LblTileCoordinates.Caption); //Print Capital Information
            textout(15*dpmm,80*dpmm,LblFoodCaption.Caption+' '+LblFood.Caption); //Print Food
            textout(15*dpmm,90*dpmm,LblGoldCaption.Caption+' '+LblGold.Caption); //Print Food
            textout(15*dpmm,100*dpmm,LblHappinessCaption.Caption+' '+LblHappiness.Caption); //Print Food
        end;
      enddoc;
    end;
  Showmessage('Tile '+LblTileCoordinates.Caption+' Printed.');
end;

procedure TFmCurrentGame.BtnUpgradeClick(Sender: TObject);
var NewID,NewGold,NewGoldPerTurn,NewFoodPerTurn,NewHappiness:Integer;
    TileCoordinates:String;
begin
  if (LblCurrentSettlement.Caption<>'City') then
    begin
      if (StrToInt(LblGold.Caption)>=StrToInt(LblSettlementRequirements.Caption)) then
        begin
          //Upgrade Settlement
          NewGold:=StrToInt(LblGold.Caption)-StrToInt(LblSettlementRequirements.Caption);
          TileCoordinates:=LblTileCoordinates.Caption;
          //Selects information from currenttile
          AdoQuery1.Close; //assign new SQL expression
          AdoQuery1.SQL.Clear;
          AdoQuery1.SQL.Add('Select SettlementID,FoodPerTurn,GoldPerTurn,TotalHappiness FROM Tile WHERE ((TileID = :Coordinates) AND (AccountID = :AccID) AND (SaveId = :SaveID))');
          ADOQuery1.Parameters.ParamByName('Coordinates').Value := TileCoordinates;
          ADOQuery1.Parameters.ParamByName('AccID').Value := AccountID;
          ADOQuery1.Parameters.ParamByName('SaveID').Value := LblSaveID.Caption;
          AdoQuery1.Open;
          NewID := ADOQuery1.Fields[0].AsInteger+1;
          //Showmessage(IntToStr(NewID));
          NewFoodPerTurn := (ADOQuery1.Fields[1].AsInteger)+(Settlement[NewID].FoodPerTurn);
          //Showmessage(IntToStr(NewFoodPerTurn));
          NewGoldPerTurn := (ADOQuery1.Fields[2].AsInteger)+(Settlement[NewID].GoldPerTurn);
          //Showmessage(IntToStr(NewGoldPerTurn));
          NewHappiness := ADOQuery1.Fields[3].AsInteger;
          //Updates TotalGold so that they pay for the upgrading
          AdoQuery1.Close;
          AdoQuery1.SQL.Clear;
          AdoQuery1.SQL.Add('UPDATE Tile SET TotalGold= :NewGold WHERE ((TileID = :CurrentTile) AND (AccountID = :AccID) AND (SaveId = :SaveID))');
          ADOQuery1.Parameters.ParamByName('NewGold').Value := NewGold;
          ADOQuery1.Parameters.ParamByName('CurrentTile').Value := TileCoordinates;
          ADOQuery1.Parameters.ParamByName('AccId').Value := AccountId;
          ADOQuery1.Parameters.ParamByName('SaveId').Value := LblSaveId.Caption;
          AdoQuery1.ExecSQL;
          AdoTile.Refresh;
          //Updates SettlementID to next SettlementID at TileCoordinates
          AdoQuery1.Close;
          AdoQuery1.SQL.Clear;
          AdoQuery1.SQL.Add('UPDATE Tile SET SettlementID= :NewID WHERE ((TileID = :CurrentTile) AND (AccountID = :AccID) AND (SaveId = :SaveID))');
          ADOQuery1.Parameters.ParamByName('NewID').Value := NewID;
          ADOQuery1.Parameters.ParamByName('CurrentTile').Value := TileCoordinates;
          ADOQuery1.Parameters.ParamByName('AccId').Value := AccountId;
          ADOQuery1.Parameters.ParamByName('SaveId').Value := LblSaveId.Caption;
          AdoQuery1.ExecSQL;
          AdoTile.Refresh;
          //Updates FoodPerTurn to NewFoodPerTurn at TileCoordinates
          AdoQuery1.Close;
          AdoQuery1.SQL.Clear;
          AdoQuery1.SQL.Add('UPDATE Tile SET FoodPerTurn= :NewFoodPerTurn WHERE ((TileID = :CurrentTile) AND (AccountID = :AccID) AND (SaveId = :SaveID))');
          ADOQuery1.Parameters.ParamByName('NewFoodPerTurn').Value := NewFoodPerTurn;
          ADOQuery1.Parameters.ParamByName('CurrentTile').Value := TileCoordinates;
          ADOQuery1.Parameters.ParamByName('AccId').Value := AccountId;
          ADOQuery1.Parameters.ParamByName('SaveId').Value := LblSaveId.Caption;
          AdoQuery1.ExecSQL;
          AdoTile.Refresh;
          //Updates GoldPerTurn to NewGoldPerTurn at TileCoordinates
          AdoQuery1.Close;
          AdoQuery1.SQL.Clear;
          AdoQuery1.SQL.Add('UPDATE Tile SET GoldPerTurn= :NewGoldPerTurn WHERE ((TileID = :CurrentTile) AND (AccountID = :AccID) AND (SaveId = :SaveID))');
          ADOQuery1.Parameters.ParamByName('NewGoldPerTurn').Value := NewGoldPerTurn;
          ADOQuery1.Parameters.ParamByName('CurrentTile').Value := TileCoordinates;
          ADOQuery1.Parameters.ParamByName('AccId').Value := AccountId;
          ADOQuery1.Parameters.ParamByName('SaveId').Value := LblSaveId.Caption;
          AdoQuery1.ExecSQL;
          AdoTile.Refresh;
          //Updates _ to New_ at TileCoordinates
          SelectTile(TileCoordinates);
          Showmessage('Settlement Upgraded!');
          SndPlayer.FileName:='Upgrade.mp3';
          SndPlayer.Open;
          SndPlayer.Play;
        end
      else Showmessage('You do not have enough gold.');
  end
  else Showmessage('You have reached the maximum settlement.');
end;

procedure TFmCurrentGame.ClearTerrain;
var CurrentYValue,CurrentXValue:Integer;
    LocationName:String;
begin
//Clears map of terrain
For CurrentYValue := 1 to 4 do
begin
  For CurrentXValue := 1 to 7 do
  begin
    LocationName:='TileX'+IntToStr(CurrentXValue)+'Y'+IntToStr(CurrentYValue);
    TImage(FindComponent(LocationName)).Picture.Assign(nil);
  end;
end;
end;

procedure TFmCurrentGame.MapTerrain(MaxXValue,MaxYValue:Integer);
var I,CurrentYValue,CurrentXValue,RandomNumber:Integer;
    LocationName,MapName:String;
begin
//Maps terrain
LblMapTitle.Caption:=Map[tag].Name;
MapName:= Map[tag].Name+'.png';
For CurrentYValue := 1 to MaxYValue do
begin
  For CurrentXValue := 1 to MaxXValue do
  begin
    LocationName:='TileX'+IntToStr(CurrentXValue)+'Y'+IntToStr(CurrentYValue);
    if (Map[tag].Name='Chaos') then
      begin
        Randomize;
        RandomNumber:=Random(4)+1;
        if (RandomNumber=1) then MapName:='Island'
        else if (RandomNumber=2) then MapName:='Desert'
        else if (RandomNumber=3) then MapName:='Jungle'
        else MapName:='Tundra';
      end
    else
      begin
        MapName:= Map[tag].Name;
      end;
    //Appends to tile table in database
        AdoTile.Append;
        AdoTile['TileID']:='('+IntToStr(CurrentXValue)+','+IntToStr(CurrentYValue)+')';
        AdoTile['SaveID']:=StrToInt(LblSaveId.Caption);
        AdoTile['AccountID']:=AccountID;
        AdoTile['Name']:=MapName;
        //Identifies what tile it is
        if (Map[tag].Name='Chaos') then
          begin
            AdoTile['TotalFood']:=TileSet[RandomNumber].TotalFood;
            AdoTile['FoodPerTurn']:=TileSet[RandomNumber].FoodPerTurn;
            AdoTile['TotalGold']:=TileSet[RandomNumber].TotalGold;
            AdoTile['GoldPerTurn']:=TileSet[RandomNumber].GoldPerTurn;
            AdoTile['TotalHappiness']:=TileSet[RandomNumber].TotalHappiness;
            AdoTile['HappinessPerTurn']:=TileSet[RandomNumber].HappinessPerTurn;
          end;
        for I := 1 to 4 do
          begin
            if (TileSet[I].Name=Map[tag].Name) then
              begin
                AdoTile['TotalFood']:=TileSet[I].TotalFood;
                AdoTile['FoodPerTurn']:=TileSet[I].FoodPerTurn;
                AdoTile['TotalGold']:=TileSet[I].TotalGold;
                AdoTile['GoldPerTurn']:=TileSet[I].GoldPerTurn;
                AdoTile['TotalHappiness']:=TileSet[I].TotalHappiness;
                AdoTile['HappinessPerTurn']:=TileSet[I].HappinessPerTurn;
              end;
          end;
        AdoTile['MapID']:=tag;
        AdoTile.Post;
    TImage(FindComponent(LocationName)).Picture.LoadFromFile(MapName+'.png');
    //Append to database tile info
  end;
end;
end;

function StrInArray(Var Word : String;Var ArrayOfString : Array of String) : Boolean;
var
 Loop : String;
begin
  for Loop in ArrayOfString do
  begin
    if Word = Loop then
    begin
       Exit(true);
    end;
  end;
  result := false;
end;

procedure TFmCurrentGame.GenFactionList(MaxFactions:Integer; Var PlayingFactions:TArray<String>);
//Dynamic array due to not knowing MaxFactions until runtime
//Dynamic arrays start at 0
var I,RandomInt:Integer;
    RandomFaction,ListOfFactions:String;
begin
    Randomize;
  //Sets length of array
  SetLength(PlayingFactions, (MaxFactions));

  //Sets player chosen faction at top of list
  PlayingFactions[0]:=LblFactionTitle.Caption;
  Showmessage('You are playing as: '+PlayingFactions[0]);
  if MaxFactions=2 then
    begin
      Repeat
        RandomInt:=Random(6);
        RandomFaction:=Faction[RandomInt].Name;
      Until (Not(StrInArray(RandomFaction,PlayingFactions)));
      PlayingFactions[1]:=RandomFaction;
      ListOfFactions:=ListOfFactions+'-'+PlayingFactions[1];
    end
  else
  begin
    for I := 1 to (MaxFactions-1) do
      begin
        Repeat
          RandomInt:=Random(6);
          RandomFaction:=Faction[RandomInt].Name;
        Until (Not(StrInArray(RandomFaction,PlayingFactions)));
        PlayingFactions[I]:=RandomFaction;
        ListOfFactions:=ListOfFactions+'-'+PlayingFactions[I]+sLineBreak;
      end;
  end;
  ShowMessage('You will be against: '+ListOfFactions);
end;

function TFmCurrentGame.CollisionCheck(CurrentTile:String):Boolean;
var I:Integer;
    CollisionCoords:String;
    YesNo:Boolean;
begin
  YesNo:=False;
  for I := 0 to 5 do
    begin
      //Finds the tile coordinates of each faction on this save on this account
      AdoQuery1.Close;
      AdoQuery1.SQL.Clear;
      AdoQuery1.SQL.Add('Select TileID FROM Tile WHERE ((Name = :CFaction) AND ' +
      '(AccountID = :AccId) AND (SaveID = :SaveId))');
      ADOQuery1.Parameters.ParamByName('CFaction').Value := Faction[I].Name;
      ADOQuery1.Parameters.ParamByName('AccId').Value := AccountId;
      ADOQuery1.Parameters.ParamByName('SaveId').Value := LblSaveId.Caption;
      AdoQuery1.Open;
      CollisionCoords:=ADOQuery1.Fields[0].AsString;
      //if (CollisionCoords<>'') then Showmessage('Potential Collision between '+CollisionCoords+' and '+CurrentTile);
      if (CollisionCoords=CurrentTile) then
        begin
          //Showmessage('Collision Detected between '+CollisionCoords+' and '+CurrentTile);
          YesNo:=True;
        end;
    end;
  Result:=YesNo;
end;

procedure TFmCurrentGame.SetTileInfo(CurrentTile, CurrentFaction:String);
var FactionId:Integer;
begin
  //Error comes from tile name not being updated to faction therefore cannot find collision
  //Updates CurrentTile's Name to the CurrentFaction's name
  {If adotile.locate('TileId;AccountID;SaveId',VarArrayOf([currenttile, accountid,lblsaveid.caption]),[]) then
  begin
      AdoTile.Edit;
      AdoTile['Name']:=CurrentFaction;
      //Selects the FactionID from the name of the faction in the array PlayingFactions
      AdoQuery1.Close;
      AdoQuery1.SQL.Clear;
      AdoQuery1.SQL.Add('Select FactionID FROM Faction WHERE Name = :CurrentFaction');
      ADOQuery1.Parameters.ParamByName('CurrentFaction').Value := CurrentFaction;
      AdoQuery1.Open;
      FactionID := ADOQuery1.Fields[0].AsInteger;
      AdoTile['FactionID']:=FactionID;
      AdoTile['SettlementID']:=1;
      AdoTile.Post;
      AdoTile.Refresh;
  end;               }
  AdoQuery1.Close;
  AdoQuery1.SQL.Clear;
  AdoQuery1.SQL.Add('UPDATE Tile SET Name= :CurrentFaction WHERE ((TileID = :CurrentTile) AND (AccountID = :AccID) AND (SaveId = :SaveID))');
  ADOQuery1.Parameters.ParamByName('CurrentFaction').Value := CurrentFaction;
  ADOQuery1.Parameters.ParamByName('CurrentTile').Value := CurrentTile;
  ADOQuery1.Parameters.ParamByName('AccId').Value := AccountId;
  ADOQuery1.Parameters.ParamByName('SaveId').Value := LblSaveId.Caption;
  AdoQuery1.ExecSQL;
  AdoTile.Refresh;
  //Selects the FactionID from the name of the faction in the array PlayingFactions
  AdoQuery1.Close;
  AdoQuery1.SQL.Clear;
  AdoQuery1.SQL.Add('Select FactionID FROM Faction WHERE Name = :CurrentFaction');
  ADOQuery1.Parameters.ParamByName('CurrentFaction').Value := CurrentFaction;
  AdoQuery1.Open;
  FactionID := ADOQuery1.Fields[0].AsInteger;
  //Updates CurrentTile's FactionID to the FactionID of the CurrentFaction WRONG FACTIONID
  AdoQuery1.Close;
  AdoQuery1.SQL.Clear;
  AdoQuery1.SQL.Add('UPDATE Tile SET FactionID= :FactId WHERE ((TileID = :CurrentTile) AND (AccountID = :AccID) AND (SaveId = :SaveID))');
  ADOQuery1.Parameters.ParamByName('FactId').Value := FactionID;
  ADOQuery1.Parameters.ParamByName('CurrentTile').Value := CurrentTile;
  ADOQuery1.Parameters.ParamByName('AccId').Value := AccountId;
  ADOQuery1.Parameters.ParamByName('SaveId').Value := LblSaveId.Caption;
  AdoQuery1.ExecSQL;
  AdoTile.Refresh;
  //Updates CurrentTile's Settlement related information to correct information
  AdoQuery1.Close;
  AdoQuery1.SQL.Clear;
  AdoQuery1.SQL.Add('UPDATE Tile SET SettlementID=1 WHERE ((TileID = :CurrentTile) AND (AccountID = :AccID) AND (SaveId = :SaveID))');
  ADOQuery1.Parameters.ParamByName('CurrentTile').Value := CurrentTile;
  ADOQuery1.Parameters.ParamByName('AccId').Value := AccountId;
  ADOQuery1.Parameters.ParamByName('SaveId').Value := LblSaveId.Caption;
  AdoQuery1.ExecSQL;
  AdoTile.Refresh;

  AdoQuery1.Close;
  AdoQuery1.SQL.Clear;
  AdoQuery1.SQL.Add('UPDATE Tile SET FoodPerTurn=:NewFoodPerTurn WHERE ((TileID = :CurrentTile) AND (AccountID = :AccID) AND (SaveId = :SaveID))');
  ADOQuery1.Parameters.ParamByName('NewFoodPerTurn').Value := Settlement[1].FoodPerTurn;
  ADOQuery1.Parameters.ParamByName('CurrentTile').Value := CurrentTile;
  ADOQuery1.Parameters.ParamByName('AccId').Value := AccountId;
  ADOQuery1.Parameters.ParamByName('SaveId').Value := LblSaveId.Caption;
  AdoQuery1.ExecSQL;
  AdoTile.Refresh;

  AdoQuery1.Close;
  AdoQuery1.SQL.Clear;
  AdoQuery1.SQL.Add('UPDATE Tile SET GoldPerTurn=:NewGoldPerTurn WHERE ((TileID = :CurrentTile) AND (AccountID = :AccID) AND (SaveId = :SaveID))');
  ADOQuery1.Parameters.ParamByName('NewGoldPerTurn').Value := Settlement[1].GoldPerTurn;
  ADOQuery1.Parameters.ParamByName('CurrentTile').Value := CurrentTile;
  ADOQuery1.Parameters.ParamByName('AccId').Value := AccountId;
  ADOQuery1.Parameters.ParamByName('SaveId').Value := LblSaveId.Caption;
  AdoQuery1.ExecSQL;
  AdoTile.Refresh;
end;

//error is/was that the tile record is not being updated
procedure TFmCurrentGame.PlaceFactions(MaxXValue,MaxYValue:Integer);
var I,MaxFactions,MaxPlayingFactions,TempYValue,TempXValue:Integer;
    LocationName,CurrentFaction,CurrentTile:String;
    Occupied:Boolean;
    PlayingFactions:TArray<String>;
begin
MaxFactions:=Map[tag].NumberOfFactions;
GenFactionList(MaxFactions,PlayingFactions);
//This is where for loop needs to change into array of playing factions (1,2,4,6 not 1,2,3,4)
MaxPlayingFactions:=Length(PlayingFactions);
for I := 0 to (MaxPlayingFactions-1) do
  begin
//Validates whether the randomly selected tile is already occupied
  Occupied:=True;
  repeat
    TempXValue:=Random(MaxXValue)+1;
    TempYValue:=Random(MaxYValue)+1;
    LocationName:='TileX'+IntToStr(TempXValue)+'Y'+IntToStr(TempYValue);
    CurrentTile:='('+IntToStr(TempXValue)+','+IntToStr(TempYValue)+')';
  //Runs through all factions in database to check for collision
    Occupied:=CollisionCheck(CurrentTile);
  until (Occupied=False);
  CurrentFaction:=PlayingFactions[I];
  SetTileInfo(CurrentTile,CurrentFaction);
  //Changes picture of tile from terrain to base of faction
  TImage(FindComponent(LocationName)).Picture.LoadFromFile(CurrentFaction+'.png');
  end;
end;

procedure TFmCurrentGame.SelectTile(Name:string);
var FactionID, SettlementID:Integer;
begin
LblTileCoordinates.Caption:=Name;
AdoQuery1.Close; //assign new SQL expression
AdoQuery1.SQL.Clear;
AdoQuery1.SQL.Add('Select Name,TotalFood,FoodPerTurn,TotalGold,GoldPerTurn,TotalHappiness,HappinessPerTurn,FactionID,SettlementID FROM Tile WHERE ((TileID = :Coordinates) AND (AccountID = :AccID) AND (SaveId = :SaveID))');
ADOQuery1.Parameters.ParamByName('Coordinates').Value := Name;
ADOQuery1.Parameters.ParamByName('AccID').Value := AccountID;
ADOQuery1.Parameters.ParamByName('SaveID').Value := LblSaveID.Caption;
AdoQuery1.Open;
//ShowMessage(Name);
LblName.Caption := ADOQuery1.Fields[0].AsString;
LblFood.Caption := ADOQuery1.Fields[1].AsString;
LblFoodPerTurn.Caption := ADOQuery1.Fields[2].AsString;
LblGold.Caption := ADOQuery1.Fields[3].AsString;
LblGoldPerTurn.Caption := ADOQuery1.Fields[4].AsString;
LblHappiness.Caption := ADOQuery1.Fields[5].AsString;
LblHappinessPerTurn.Caption := ADOQuery1.Fields[6].AsString;
FactionID := ADOQuery1.Fields[7].AsInteger;
SettlementID := ADOQuery1.Fields[8].AsInteger;
if (LblFactionTitle.Caption=LblName.Caption) then
  begin
  LblCurrentSettlement.Caption:=Settlement[SettlementID].Name;
  if (SettlementID<>4) then
    begin
      LblNextSettlement.Caption:=Settlement[(SettlementID+1)].Name;
      LblSettlementRequirements.Caption:=IntToStr(Settlement[(SettlementID+1)].GoldToConstruct);
    end
  else
    begin
      LblNextSettlement.Caption:='###';
      LblSettlementRequirements.Caption:='###';
    end;
  GbxSettlement.Show;
  GbxSquadCreate.Show;
  end
else
  begin
  GbxSettlement.Hide;
  GbxSquadCreate.Hide;
  end;
end;

procedure TFmCurrentGame.TileX1Y1Click(Sender: TObject);
begin
  selectTile('(1,1)');
end;

procedure TFmCurrentGame.TileX1Y2Click(Sender: TObject);
begin
  selectTile('(1,2)');
end;

procedure TFmCurrentGame.TileX1Y3Click(Sender: TObject);
begin
  selectTile('(1,3)');
end;

procedure TFmCurrentGame.TileX1Y4Click(Sender: TObject);
begin
  selectTile('(1,4)');
end;

procedure TFmCurrentGame.TileX2Y1Click(Sender: TObject);
begin
  selectTile('(2,1)');
end;

procedure TFmCurrentGame.TileX2Y2Click(Sender: TObject);
begin
  selectTile('(2,2)');
end;

procedure TFmCurrentGame.TileX2Y3Click(Sender: TObject);
begin
  selectTile('(2,3)');
end;

procedure TFmCurrentGame.TileX2Y4Click(Sender: TObject);
begin
  selectTile('(2,4)');
end;

procedure TFmCurrentGame.TileX3Y1Click(Sender: TObject);
begin
  selectTile('(3,1)');
end;

procedure TFmCurrentGame.TileX3Y2Click(Sender: TObject);
begin
  selectTile('(3,2)');
end;

procedure TFmCurrentGame.TileX3Y3Click(Sender: TObject);
begin
  selectTile('(3,3)');
end;

procedure TFmCurrentGame.TileX3Y4Click(Sender: TObject);
begin
  selectTile('(3,4)');
end;

procedure TFmCurrentGame.TileX4Y1Click(Sender: TObject);
begin
  selectTile('(4,1)');
end;

procedure TFmCurrentGame.TileX4Y2Click(Sender: TObject);
begin
  selectTile('(4,2)');
end;

procedure TFmCurrentGame.TileX4Y3Click(Sender: TObject);
begin
  selectTile('(4,3)');
end;

procedure TFmCurrentGame.TileX4Y4Click(Sender: TObject);
begin
  selectTile('(4,4)');
end;

procedure TFmCurrentGame.TileX5Y1Click(Sender: TObject);
begin
  selectTile('(5,1)');
end;

procedure TFmCurrentGame.TileX5Y2Click(Sender: TObject);
begin
  selectTile('(5,2)');
end;

procedure TFmCurrentGame.TileX5Y3Click(Sender: TObject);
begin
  selectTile('(5,3)');
end;

procedure TFmCurrentGame.TileX5Y4Click(Sender: TObject);
begin
  selectTile('(5,4)');
end;

procedure TFmCurrentGame.TileX6Y1Click(Sender: TObject);
begin
  selectTile('(6,1)');
end;

procedure TFmCurrentGame.TileX6Y2Click(Sender: TObject);
begin
  selectTile('(6,2)');
end;

procedure TFmCurrentGame.TileX6Y3Click(Sender: TObject);
begin
  selectTile('(6,3)');
end;

procedure TFmCurrentGame.TileX6Y4Click(Sender: TObject);
begin
  selectTile('(6,4)');
end;

procedure TFmCurrentGame.TileX7Y1Click(Sender: TObject);
begin
  selectTile('(7,1)');
end;

procedure TFmCurrentGame.TileX7Y2Click(Sender: TObject);
begin
  selectTile('(7,2)');
end;

procedure TFmCurrentGame.TileX7Y3Click(Sender: TObject);
begin
  selectTile('(7,3)');
end;

procedure TFmCurrentGame.TileX7Y4Click(Sender: TObject);
begin
  selectTile('(7,4)');
end;

procedure TFmCurrentGame.BtnEndTurnClick(Sender: TObject);
var
  X,MaxXValue,Y,MaxYValue: Integer;
  Coordinates:String;
begin
  if (StrToInt(LblNumberOfTurns.Caption)>=20) then
  begin
    ShowMessage('You have run out of time! '+sLineBreak+'You have been Defeated.');
    FmLogin.Close;
  end
  else
  begin
    MaxXValue:=Map[tag].XCoordinate;
    MaxYValue:=Map[tag].YCoordinate;
    for Y := 1 to MaxYValue do
      begin
        for X := 1 to MaxXValue do
          begin
            //Refreshes Information
            Coordinates:='('+IntToStr(X)+','+IntToStr(Y)+')';
            SelectTile(Coordinates);
            //Updates Food
            AdoQuery1.Close;
            AdoQuery1.SQL.Clear;
            AdoQuery1.SQL.Add('UPDATE Tile SET TotalFood= :NewFood WHERE ((TileID = :CurrentTile) AND (AccountID = :AccID) AND (SaveId = :SaveID))');
            ADOQuery1.Parameters.ParamByName('NewFood').Value :=StrToInt(LblFood.Caption)+StrToInt(LblFoodPerTurn.Caption);
            ADOQuery1.Parameters.ParamByName('CurrentTile').Value := Coordinates;
            ADOQuery1.Parameters.ParamByName('AccId').Value := AccountId;
            ADOQuery1.Parameters.ParamByName('SaveId').Value := LblSaveId.Caption;
            AdoQuery1.ExecSQL;
            AdoTile.Refresh;
            //Updates Gold
            AdoQuery1.Close;
            AdoQuery1.SQL.Clear;
            AdoQuery1.SQL.Add('UPDATE Tile SET TotalGold= :NewGold WHERE ((TileID = :CurrentTile) AND (AccountID = :AccID) AND (SaveId = :SaveID))');
            ADOQuery1.Parameters.ParamByName('NewGold').Value :=StrToInt(LblGold.Caption)+StrToInt(LblGoldPerTurn.Caption);
            ADOQuery1.Parameters.ParamByName('CurrentTile').Value := Coordinates;
            ADOQuery1.Parameters.ParamByName('AccId').Value := AccountId;
            ADOQuery1.Parameters.ParamByName('SaveId').Value := LblSaveId.Caption;
            AdoQuery1.ExecSQL;
            AdoTile.Refresh;
            //Updates Happiness
            AdoQuery1.Close;
            AdoQuery1.SQL.Clear;
            AdoQuery1.SQL.Add('UPDATE Tile SET TotalHappiness= :NewHappiness WHERE ((TileID = :CurrentTile) AND (AccountID = :AccID) AND (SaveId = :SaveID))');
            ADOQuery1.Parameters.ParamByName('NewHappiness').Value :=StrToInt(LblHappiness.Caption)+StrToInt(LblHappinessPerTurn.Caption);
            ADOQuery1.Parameters.ParamByName('CurrentTile').Value := Coordinates;
            ADOQuery1.Parameters.ParamByName('AccId').Value := AccountId;
            ADOQuery1.Parameters.ParamByName('SaveId').Value := LblSaveId.Caption;
            AdoQuery1.ExecSQL;
            AdoTile.Refresh;
          end;
      end;
    //Update Turns to +1
    AdoQuery1.Close;
    AdoQuery1.SQL.Clear;
    AdoQuery1.SQL.Add('UPDATE SaveState SET NumberOfTurns= :NewTurns WHERE ((AccountID = :AccID) AND (SaveId = :SaveID))');
    ADOQuery1.Parameters.ParamByName('NewTurns').Value :=StrToInt(LblNumberOfTurns.Caption)+1;
    ADOQuery1.Parameters.ParamByName('AccId').Value := AccountId;
    ADOQuery1.Parameters.ParamByName('SaveId').Value := LblSaveId.Caption;
    AdoQuery1.ExecSQL;
    AdoTile.Refresh;
    LblNumberOfTurns.Caption:=IntToStr(StrToInt(LblNumberOfTurns.Caption)+1);
    //Empty Information
    LblName.Caption:='';
    LblFood.Caption:='';
    LblFoodPerTurn.Caption:='';
    LblGold.Caption:='';
    LblGoldPerTurn.Caption:='';
    LblHappiness.Caption:='';
    LblHappinessPerTurn.Caption:='';
    LblTileCoordinates.Caption:='( , )';
    GbxSettlement.Hide;
    GbxSquadCreate.Hide;
    Showmessage('Saved Game. You are now on Turn '+LblNumberOfTurns.Caption+'.');
    end;
end;

procedure TFmCurrentGame.LoadPreviousGame(MaxXValue,MaxYValue:Integer);
var X,Y:integer;
    Coordinates,TilePicture,LocationName:String;
begin
  for Y := 1 to MaxYValue do
      begin
        for X := 1 to MaxXValue do
          begin
            Coordinates:='('+IntToStr(X)+','+IntToStr(Y)+')';
            //Showmessage('Coordinates: '+Coordinates);
            LocationName:='TileX'+IntToStr(X)+'Y'+IntToStr(Y);
            //Showmessage('LocationName: '+LocationName);
            AdoQuery1.Close; //assign new SQL expression
            AdoQuery1.SQL.Clear;
            AdoQuery1.SQL.Add('Select Name FROM Tile WHERE ((TileID = :CurrentTile) AND (AccountID = :AccID) AND (SaveId = :SavID))');
            ADOQuery1.Parameters.ParamByName('CurrentTile').Value := Coordinates;
            ADOQuery1.Parameters.ParamByName('AccId').Value := AccountId;
            ADOQuery1.Parameters.ParamByName('SavId').Value := LblSaveID.Caption;
            AdoQuery1.Open;
            TilePicture:=(ADOQuery1.Fields[0].AsString)+'.png';
            //Showmessage('TilePicture: '+TilePicture);
            if (TilePicture<>'') then
            //TImage(FindComponent(LocationName)).Picture.LoadFromFile(MapName+'.png');
            TImage(FindComponent(LocationName)).Picture.LoadFromFile(TilePicture);
          end;
      end;
  AdoQuery1.Close; //assign new SQL expression
  AdoQuery1.SQL.Clear;
  AdoQuery1.SQL.Add('Select FactionID,NumberOfTurns FROM SaveState WHERE ((AccountID = :AccID) AND (SaveId = :SavID))');
  ADOQuery1.Parameters.ParamByName('AccId').Value := AccountId;
  ADOQuery1.Parameters.ParamByName('SavId').Value := LblSaveID.Caption;
  AdoQuery1.Open;
  LblFactionTitle.Caption:=Faction[ADOQuery1.Fields[0].AsInteger].Name;
  LblNumberOfTurns.Caption:=ADOQuery1.Fields[1].AsString;
end;

function TFmCurrentGame.CheckExpert():Boolean;
var QueryResult:boolean;
begin
AdoQuery1.Close; //assign new SQL expression
AdoQuery1.SQL.Clear;
AdoQuery1.SQL.Add('Select Expert FROM Player WHERE AccountID = :AccID');
ADOQuery1.Parameters.ParamByName('AccID').Value := AccountID;
AdoQuery1.Open;
QueryResult:=ADOQuery1.Fields[0].AsBoolean;
Result:=QueryResult;
end;

function TFmCurrentGame.CheckGameWon():Boolean;
var YesNo:boolean;
begin
YesNo:=True;
Result:=YesNo;
end;

procedure TFmCurrentGame.FormShow(Sender: TObject);
var MaxXValue,MaxYValue:Integer;
begin
//error: faction collision
//Error: need to make maps actually load
//Random List of Factions Chosen, -1 due to player selected faction must always be included
//Idea: When faction controls a city on a tile its recultivated into a new .png
//Hides faction related boxes
GbxSettlement.Hide;
GbxSquadCreate.Hide;
//Sets values
FmCurrentGame.Activate;
MaxXValue:=Map[tag].XCoordinate;
MaxYValue:=Map[tag].YCoordinate;
//If player is not an expert then they will be informed of rules and win condition(s)
if (Not(CheckExpert)) then
ShowMessage('How To Play: -Click on a tile to display information about that tile.'+sLineBreak
+'-When you are finished with your turn, click the end turn button.'+sLineBreak
+'How To Win: '+sLineBreak+'-Destroy all enemy faction bases.');

if Not(isLoad) then
begin
//Clears terrain, creates the map and creates the faction list and places maps tiles
ClearTerrain;
MapTerrain(MaxXValue,MaxYValue);
PlaceFactions(MaxXValue,MaxYValue);
end else
begin
//Clears terrain then loads previous information from a save state specified
  ClearTerrain;
  LoadPreviousGame(MaxXValue,MaxYValue);
end;

end;

end.
