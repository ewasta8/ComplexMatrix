object FormMain: TFormMain
  Left = 581
  Top = 327
  Caption = 
    'Rozwi'#261'zywanie uk'#322'adu r'#243'wna'#324' liniowych o wsp'#243#322'czynnikach zespolon' +
    'ych'
  ClientHeight = 428
  ClientWidth = 549
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object BtnDoc: TButton
    Left = 8
    Top = 176
    Width = 239
    Height = 25
    Caption = 'Dokumentacja'
    TabOrder = 3
    OnClick = BtnDocClick
  end
  object GrpArithmetic: TGroupBox
    Left = 8
    Top = 8
    Width = 239
    Height = 82
    Caption = 'Typ arytmetyki'
    TabOrder = 0
    object RBtnArithmeticStd: TRadioButton
      Left = 14
      Top = 25
      Width = 227
      Height = 17
      Caption = 'Standardowa (zmiennoprzecinkowa)'
      TabOrder = 0
      OnClick = RadioClick
    end
    object RBtnArithmeticInterval: TRadioButton
      Left = 14
      Top = 48
      Width = 113
      Height = 17
      Caption = 'Przedzia'#322'owa'
      TabOrder = 1
      OnClick = RadioClick
    end
  end
  object GrpDataType: TGroupBox
    Left = 8
    Top = 96
    Width = 239
    Height = 74
    Caption = 'Typ danych'
    TabOrder = 1
    object RBtnDataTypeStd: TRadioButton
      Left = 14
      Top = 23
      Width = 113
      Height = 17
      Caption = 'Standardowe'
      TabOrder = 0
      OnClick = RadioClick
    end
    object RbtnDataTypeInterval: TRadioButton
      Left = 14
      Top = 46
      Width = 113
      Height = 18
      Caption = 'Przedzia'#322'owe'
      TabOrder = 1
      OnClick = RadioClick
    end
  end
  object BtnClear: TButton
    Left = 8
    Top = 399
    Width = 529
    Height = 25
    Caption = 'Resetuj'
    TabOrder = 5
    OnClick = BtnClearClick
  end
  object GrpData: TGroupBox
    Left = 253
    Top = 8
    Width = 284
    Height = 162
    Caption = 'Dane'
    DefaultHeaderFont = False
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeaderFont.Charset = EASTEUROPE_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -12
    HeaderFont.Name = 'Segoe UI'
    HeaderFont.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object LblN: TLabel
      Left = 10
      Top = 16
      Width = 206
      Height = 15
      Caption = 'Podaj warto'#347#263' n (liczba niewiadomych)'
    end
    object LblA: TLabel
      Left = 10
      Top = 66
      Width = 100
      Height = 15
      Caption = 'Podaj warto'#347#263' a[i,j]'
    end
    object LblAre: TLabel
      Left = 10
      Top = 87
      Width = 92
      Height = 15
      Caption = 'Cz'#281#347#263' rzeczywista'
    end
    object LblAim: TLabel
      Left = 164
      Top = 87
      Width = 74
      Height = 15
      Caption = 'Cz'#281#347#263' urojona'
    end
    object BtnSetSize: TButton
      Left = 137
      Top = 37
      Width = 81
      Height = 25
      Caption = 'Ustaw n'
      TabOrder = 1
      OnClick = BtnSetSizeClick
    end
    object BtnEnter: TButton
      Left = 56
      Top = 134
      Width = 169
      Height = 25
      Caption = 'Wprowad'#378
      TabOrder = 8
      OnClick = BtnEnterClick
    end
    object EditN: TEdit
      Left = 10
      Top = 37
      Width = 121
      Height = 23
      TabOrder = 0
      OnExit = EditIntExit
    end
    object EditAre: TEdit
      Left = 10
      Top = 108
      Width = 111
      Height = 23
      TabOrder = 2
      Visible = False
      OnExit = EditExtExit
    end
    object EditAim: TEdit
      Left = 162
      Top = 108
      Width = 111
      Height = 23
      TabOrder = 3
      Visible = False
      OnExit = EditExtExit
    end
    object EditAAre: TEdit
      Left = 10
      Top = 108
      Width = 60
      Height = 23
      TabOrder = 4
      Visible = False
      OnExit = EditExtExit
    end
    object EditABre: TEdit
      Left = 70
      Top = 108
      Width = 60
      Height = 23
      TabOrder = 5
      Visible = False
      OnExit = EditExtExit
    end
    object EditAAim: TEdit
      Left = 153
      Top = 108
      Width = 60
      Height = 23
      TabOrder = 6
      Visible = False
      OnExit = EditExtExit
    end
    object EditABim: TEdit
      Left = 213
      Top = 108
      Width = 60
      Height = 23
      TabOrder = 7
      Visible = False
      OnExit = EditExtExit
    end
  end
  object GrpAnswer: TGroupBox
    Left = 8
    Top = 207
    Width = 531
    Height = 186
    Caption = 'Wyniki'
    DefaultHeaderFont = False
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -12
    HeaderFont.Name = 'Segoe UI'
    HeaderFont.Style = [fsBold]
    TabOrder = 6
    object MemoAnswer: TMemo
      Left = 3
      Top = 24
      Width = 525
      Height = 159
      Cursor = crArrow
      TabStop = False
      Align = alCustom
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object BtnSolve: TButton
    Left = 253
    Top = 176
    Width = 284
    Height = 25
    Caption = 'Oblicz'
    TabOrder = 4
    OnClick = BtnSolveClick
  end
end
