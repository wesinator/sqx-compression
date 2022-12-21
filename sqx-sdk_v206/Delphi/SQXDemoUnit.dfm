object SQXForm: TSQXForm
  Left = 333
  Top = 122
  Width = 211
  Height = 215
  Caption = 'SQX-Demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnCompressingFiles: TButton
    Left = 24
    Top = 16
    Width = 153
    Height = 25
    Caption = 'Compressing files'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btnCompressingFilesClick
  end
  object btnExtractingFiles: TButton
    Left = 24
    Top = 56
    Width = 153
    Height = 25
    Caption = 'Extracting files'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnExtractingFilesClick
  end
  object btnListingFiles: TButton
    Left = 24
    Top = 96
    Width = 153
    Height = 25
    Caption = 'Listing files'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnListingFilesClick
  end
  object bitbtnClose: TBitBtn
    Left = 24
    Top = 136
    Width = 153
    Height = 25
    Caption = 'Close'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Kind = bkClose
  end
end
