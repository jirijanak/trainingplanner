object Form2: TForm2
  Left = 192
  Top = 107
  Width = 491
  Height = 492
  Caption = 'V'#253'b'#283'r vzoru'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 9
    Top = 9
    Width = 240
    Height = 450
  end
  object OKButton: TSpeedButton
    Left = 320
    Top = 432
    Width = 90
    Height = 25
    Caption = 'OK'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = OKButtonClick
  end
  object VpredButton: TSpeedButton
    Left = 376
    Top = 400
    Width = 90
    Height = 25
    Caption = 'Dal'#353#237'  >>'
    OnClick = VpredButtonClick
  end
  object ZpetButton: TSpeedButton
    Left = 272
    Top = 400
    Width = 90
    Height = 25
    Caption = '<<  P'#345'edchoz'#237
    OnClick = ZpetButtonClick
  end
  object GroupBox1: TGroupBox
    Left = 264
    Top = 8
    Width = 209
    Height = 377
    Caption = '  O cvi'#269'en'#237'  '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 17
      Top = 24
      Width = 87
      Height = 13
      Caption = 'N'#225'zev cvi'#269'en'#237':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 17
      Top = 72
      Width = 82
      Height = 13
      Caption = 'Popis cvi'#269'en'#237':'
    end
    object Label3: TLabel
      Left = 153
      Top = 24
      Width = 36
      Height = 13
      Caption = 'Minut:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Name: TEdit
      Left = 17
      Top = 39
      Width = 120
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object Popis: TMemo
      Left = 17
      Top = 88
      Width = 175
      Height = 273
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Lines.Strings = (
        'Popis')
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 1
    end
    object Minut: TEdit
      Left = 153
      Top = 39
      Width = 32
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = '0'
      OnExit = MinutExit
    end
  end
end
