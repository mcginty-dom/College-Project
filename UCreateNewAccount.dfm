object FmCreateNewAccount: TFmCreateNewAccount
  Left = 0
  Top = 0
  Caption = 'Create New Account'
  ClientHeight = 450
  ClientWidth = 800
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object LblTitle: TLabel
    Left = 40
    Top = 16
    Width = 182
    Height = 57
    Caption = 'Register'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -48
    Font.Name = 'Cambria'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object GpBxCreate: TGroupBox
    Left = 40
    Top = 100
    Width = 313
    Height = 197
    Caption = 'Create Account'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LblConfirmPassword: TLabel
      Left = 20
      Top = 84
      Width = 120
      Height = 19
      Caption = 'Confirm Password:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
    end
    object LblPassword: TLabel
      Left = 20
      Top = 54
      Width = 66
      Height = 19
      Caption = 'Password:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
    end
    object LblUsername: TLabel
      Left = 20
      Top = 24
      Width = 70
      Height = 19
      Caption = 'Username:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
    end
    object EdConfirmPassword: TEdit
      Left = 146
      Top = 84
      Width = 121
      Height = 27
      PasswordChar = '*'
      TabOrder = 2
    end
    object EdPassword: TEdit
      Left = 146
      Top = 54
      Width = 121
      Height = 27
      PasswordChar = '*'
      TabOrder = 1
    end
    object EdUsername: TEdit
      Left = 146
      Top = 24
      Width = 121
      Height = 27
      TabOrder = 0
    end
    object BtnCreateAccount: TButton
      Left = 3
      Top = 162
      Width = 307
      Height = 33
      Caption = 'Create Account'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = BtnCreateAccountClick
    end
    object CheckBoxExpert: TCheckBox
      Left = 20
      Top = 114
      Width = 247
      Height = 42
      Alignment = taLeftJustify
      Caption = 'Expert:'
      TabOrder = 3
    end
  end
  object ADOPlayer: TADOTable
    TableName = 'ADOPlayers'
    Left = 272
    Top = 32
  end
end
