object FmCreateNewGame: TFmCreateNewGame
  Left = 0
  Top = 0
  Caption = 'New Game'
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LblCreateNewGame: TLabel
    Left = 16
    Top = 16
    Width = 369
    Height = 57
    Caption = 'New Game Setup'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -48
    Font.Name = 'Cambria'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object LblMapName: TLabel
    Left = 63
    Top = 215
    Width = 85
    Height = 19
    Caption = 'Choose Map:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
  end
  object LblSaveFileName: TLabel
    Left = 19
    Top = 134
    Width = 97
    Height = 19
    Caption = 'Save Filename:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
  end
  object LblFactionName: TLabel
    Left = 414
    Top = 120
    Width = 103
    Height = 19
    Caption = 'Choose Faction:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
  end
  object LblSaveID: TLabel
    Left = 19
    Top = 98
    Width = 52
    Height = 19
    Caption = 'Save ID:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
  end
  object LblSaveIDOutput: TLabel
    Left = 134
    Top = 102
    Width = 82
    Height = 13
    Caption = 'LblSaveIDOutput'
  end
  object EdSaveFileName: TEdit
    Left = 134
    Top = 131
    Width = 219
    Height = 27
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = []
    MaxLength = 25
    ParentFont = False
    TabOrder = 0
  end
  object GbxFaction: TGroupBox
    Left = 414
    Top = 150
    Width = 353
    Height = 188
    Caption = 'Faction Information'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object LblFactionTrait: TLabel
      Left = 20
      Top = 150
      Width = 84
      Height = 19
      Caption = 'Faction Trait:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
    end
    object LblFactionTraitOutput: TLabel
      Left = 150
      Top = 150
      Width = 24
      Height = 19
      Caption = '___'
    end
    object LblFactionCapital: TLabel
      Left = 20
      Top = 112
      Width = 101
      Height = 19
      Caption = 'Faction Capital:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
    end
    object LblFactionCapitalOutput: TLabel
      Left = 150
      Top = 112
      Width = 24
      Height = 19
      Caption = '___'
    end
    object LblFactionType: TLabel
      Left = 20
      Top = 74
      Width = 85
      Height = 19
      Caption = 'Faction Type:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
    end
    object LblFactionTypeOutput: TLabel
      Left = 150
      Top = 74
      Width = 24
      Height = 19
      Caption = '___'
    end
    object LblFactionID: TLabel
      Left = 20
      Top = 41
      Width = 69
      Height = 19
      Caption = 'Faction ID:'
    end
    object LblFactionIdOutput: TLabel
      Left = 150
      Top = 41
      Width = 24
      Height = 19
      Caption = '___'
    end
  end
  object GbxMap: TGroupBox
    Left = 63
    Top = 245
    Width = 241
    Height = 132
    Caption = 'Map Information'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object LblMapSize: TLabel
      Left = 3
      Top = 72
      Width = 62
      Height = 19
      Caption = 'Map Size:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
    end
    object LblMapSizeOutput: TLabel
      Left = 106
      Top = 72
      Width = 24
      Height = 19
      Caption = '___'
    end
    object LblMapID: TLabel
      Left = 3
      Top = 33
      Width = 51
      Height = 19
      Caption = 'Map ID:'
    end
    object LblMapIDOutput: TLabel
      Left = 106
      Top = 33
      Width = 24
      Height = 19
      Caption = '___'
    end
    object LblMapNumberOfFactionsOutput: TLabel
      Left = 106
      Top = 110
      Width = 24
      Height = 19
      Caption = '___'
    end
    object LblMapNumberOfFactions: TLabel
      Left = 3
      Top = 110
      Width = 90
      Height = 19
      Caption = 'Max Factions:'
    end
  end
  object BtnCreateGame: TButton
    Left = 414
    Top = 344
    Width = 131
    Height = 57
    Caption = 'Create Game'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = BtnCreateGameClick
  end
  object BtnCancel: TButton
    Left = 642
    Top = 344
    Width = 125
    Height = 57
    Caption = 'Cancel'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = BtnCancelClick
  end
  object DBCmbMap: TDBLookupComboBox
    Left = 154
    Top = 218
    Width = 145
    Height = 21
    TabOrder = 1
    OnClick = DBCmbMapClick
  end
  object DbCmbFaction: TDBLookupComboBox
    Left = 534
    Top = 118
    Width = 145
    Height = 21
    TabOrder = 3
    OnClick = DbCmbFactionClick
  end
  object ADOMap: TADOTable
    Left = 248
    Top = 376
  end
  object DSMap: TDataSource
    Left = 200
    Top = 376
  end
  object ADOFaction: TADOTable
    Left = 576
    Top = 48
  end
  object DSFaction: TDataSource
    Left = 512
    Top = 56
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    Left = 368
    Top = 120
  end
  object ADOSaveState: TADOTable
    Left = 32
    Top = 160
  end
end
