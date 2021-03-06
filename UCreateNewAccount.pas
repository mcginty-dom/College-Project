unit UCreateNewAccount;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Data.Win.ADODB,Utilities;

type
  TFmCreateNewAccount = class(TForm)
    LblUsername: TLabel;
    LblPassword: TLabel;
    LblConfirmPassword: TLabel;
    EdUsername: TEdit;
    EdPassword: TEdit;
    EdConfirmPassword: TEdit;
    BtnCreateAccount: TButton;
    ADOPlayer: TADOTable;
    LblTitle: TLabel;
    GpBxCreate: TGroupBox;
    CheckBoxExpert: TCheckBox;
    procedure BtnCreateAccountClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmCreateNewAccount: TFmCreateNewAccount;

implementation

{$R *.dfm}

uses ULogin;

procedure TFmCreateNewAccount.BtnCreateAccountClick(Sender: TObject);
var next:integer;
    FreeSpaceFound:boolean;
begin
  if AdoPlayer.Locate('Username',EdUsername.Text,[]) then Showmessage('This username has already been taken')
  else if (length(EdUsername.Text)<5) or (length(EdUsername.Text)>40) then Showmessage('Username must be between 5 and 40 characters long.')
  else if (length(EdPassword.Text)<5) or (length(EdPassword.Text)>25) then Showmessage('Password must be between 5 and 25 characters long.')
  else if (EDPassword.Text<>EDConfirmPassword.Text) then ShowMessage('Passwords do not match.')
  else if (AdoPlayer.RecordCount>=20) then ShowMessage('Database is full, contact administrator.')
  else
    begin
    next:=1;
    FreeSpaceFound:=False;
    AdoPlayer.Edit;
    while Not(FreeSpaceFound) do
    begin
      if Not(ADOPlayer.Locate('AccountID',next,[])) then FreeSpaceFound:=True
      else next:=next+1;
    end;
    AdoPlayer.Append;
    AdoPlayer['AccountID']:=next;
    AdoPlayer['Username']:=EdUsername.text;
    AdoPlayer['Passcode']:=EdPassword.text;
    AdoPlayer['Lastlogin']:=Date();
    AdoPlayer['Expert']:=CheckBoxExpert.Checked;
    AdoPlayer['Wins']:=0;
    AdoPlayer['Losses']:=0;
    AdoPlayer.Post;
    EdUsername.Text:='';
    EdPassword.Text:='';
    EdConfirmPassword.Text:='';
    Showmessage('Saved new account.');
    FmCreateNewAccount.Hide;
    FmLogin.Show;
    //ADOPlayers: Dataset not in edit or insert mode
    end
end;

procedure TFmCreateNewAccount.FormActivate(Sender: TObject);
begin
  AdoPlayer.ConnectionString:= ConnStr;
  AdoPlayer.TableName:='Player';
  AdoPlayer.Open;
end;

procedure TFmCreateNewAccount.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
FmCreateNewAccount.Hide;
FmLogin.Show;
AdoPlayer.Close;
end;

end.
