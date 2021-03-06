  unit UMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Data.DB, Data.Win.ADODB, Utilities;

type
  TFmMenu = class(TForm)
    BtnCreateNewGame: TButton;
    BtnLoadGame: TButton;
    LblMenu: TLabel;
    ImLogo: TImage;
    BtnLogOut: TButton;
    BtnDeleteAccount: TButton;
    ADOPlayer: TADOTable;
    ADOSaveState: TADOTable;
    procedure BtnLogOutClick(Sender: TObject);
    procedure BtnCreateNewGameClick(Sender: TObject);
    procedure BtnLoadGameClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnDeleteAccountClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmMenu: TFmMenu;

implementation

{$R *.dfm}

uses ULogin, UCreateNewGame, ULoadGame;

procedure TFmMenu.BtnCreateNewGameClick(Sender: TObject);
begin
FmMenu.Close;
FmCreateNewGame.Show;
end;

procedure TFmMenu.BtnDeleteAccountClick(Sender: TObject);
var FileFound:Boolean;
  I: Integer;
begin
//Checks to ensure choice to delete account wasn't accidental
if messageDlg('Are you sure you would like to delete your account?',mtconfirmation,[mbyes,mbno],0)=mryes then
  begin
//Checks if Account is linked to any savestates
  FileFound:=False;
  for I := 1 to 3 do
    begin
      if ADOSaveState.Locate('SaveId;AccountID',VarArrayOf([I,AccountID]),[]) then FileFound:=True
    end;
  if FileFound then showmessage('Please delete all saves before deleting an account.')
  else
    begin
      //Finds Account in database and deletes record
      if ADOPlayer.Locate('AccountID',AccountID,[]) then AdoPlayer.Delete;
      showmessage('Account deleted.');
      FmLogin.Close;
    end;
  end;
end;

procedure TFmMenu.BtnLoadGameClick(Sender: TObject);
begin
FmMenu.Close;
FmLoadGame.Show;
end;

procedure TFmMenu.BtnLogOutClick(Sender: TObject);
begin
FmMenu.Close;
FmLogin.Show;
end;

procedure TFmMenu.FormActivate(Sender: TObject);
begin
  AdoPlayer.ConnectionString:= ConnStr;
  AdoPlayer.TableName:='Player';
  AdoPlayer.Open;
  AdoSaveState.ConnectionString:= ConnStr;
  AdoSaveState.TableName:='SaveState';
  AdoSaveState.Open;
end;

procedure TFmMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
AdoPlayer.Close;
AdoSaveState.Close;
FmLogin.Show;
end;

end.
