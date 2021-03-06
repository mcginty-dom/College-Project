unit Utilities;

interface
uses sysutils;

Const
  ConnStr='Provider=Microsoft.ACE.OLEDB.12.0; Data Source=Triumphant.accdb; Persist Security Info=False;';

Type
TFaction=record
      Name:string[40];
      TypeOfFaction:string[13];
      CapitalName:string[20];
  end;
TFactionArray=array[0..5] of Tfaction;
TMap=record
      Name:string[20];
      XCoordinate:Integer;
      YCoordinate:Integer;
      NumberOfFactions:Integer;
  end;
TMapArray=array[1..5] of TMap;
TSettlement=record
      Name:string[25];
      Paradigm:string[20];
      GoldToConstruct:Integer;
      FoodPerTurn:Integer;
      GoldPerTurn:Integer;
end;
TSettlementArray=array[1..4] of TSettlement;
//Name,TotalFood,FoodPerTurn,TotalGold,GoldPerTurn,TotalHappiness,HappinessPerTurn
TTileSet=record
      Name:String[20];
      TotalFood:Integer;
      FoodPerTurn:Real;
      TotalGold:Integer;
      GoldPerTurn:Real;
      TotalHappiness:Integer;
      HappinessPerTurn:Real;
end;
TTileArray=array[1..4] of TTileSet;
Var
  AccountID: Integer;
  Faction:TFactionArray;
  Map:TMapArray;
  Settlement:TSettlementArray;
  TileSet:TTileArray;
  isLoad:Boolean;

implementation

end.
