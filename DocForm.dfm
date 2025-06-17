object DocForm: TDocForm
  Left = 0
  Top = 0
  Caption = 'Dokumentacja'
  ClientHeight = 400
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object MemoDoc: TMemo
    Left = 0
    Top = 0
    Width = 600
    Height = 400
    Align = alClient
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
    ExplicitWidth = 598
    ExplicitHeight = 392
  end
end
