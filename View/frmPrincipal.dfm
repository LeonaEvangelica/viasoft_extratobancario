object formPrincipal: TformPrincipal
  Left = 0
  Top = 0
  Caption = 'Principal'
  ClientHeight = 592
  ClientWidth = 953
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 953
    Height = 89
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    ExplicitLeft = 8
    object lblSaldo: TLabel
      Left = 824
      Top = 55
      Width = 5
      Height = 28
      BiDiMode = bdLeftToRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblDescSaldo: TLabel
      Left = 716
      Top = 55
      Width = 102
      Height = 28
      BiDiMode = bdLeftToRight
      Caption = 'Saldo atual:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
    end
    object btnIncluir: TButton
      Left = 2
      Top = 2
      Width = 79
      Height = 85
      Align = alLeft
      Caption = 'Incluir'
      TabOrder = 0
      OnClick = btnIncluirClick
      ExplicitLeft = 17
      ExplicitTop = 0
      ExplicitHeight = 83
    end
    object btnAlterar: TButton
      Left = 81
      Top = 2
      Width = 79
      Height = 85
      Align = alLeft
      Caption = 'Alterar'
      TabOrder = 1
      OnClick = btnAlterarClick
      ExplicitLeft = 166
      ExplicitTop = 0
    end
    object btnExcluir: TButton
      Left = 160
      Top = 2
      Width = 79
      Height = 85
      Align = alLeft
      Caption = 'Excluir'
      TabOrder = 2
      OnClick = btnExcluirClick
      ExplicitLeft = 245
      ExplicitTop = 4
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 89
    Width = 953
    Height = 439
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 1
    ExplicitHeight = 288
    object pnlCampos: TPanel
      Left = 2
      Top = 2
      Width = 415
      Height = 435
      Align = alLeft
      BevelInner = bvLowered
      Enabled = False
      TabOrder = 0
      ExplicitLeft = 0
      ExplicitTop = -2
      object lblDataTransacao: TLabel
        Left = 173
        Top = 4
        Width = 101
        Height = 15
        BiDiMode = bdLeftToRight
        Caption = 'Data da Transa'#231#227'o:'
        ParentBiDiMode = False
      end
      object lblClienteOrigem: TLabel
        Left = 39
        Top = 36
        Width = 99
        Height = 15
        BiDiMode = bdLeftToRight
        Caption = 'Cliente de Origem:'
        ParentBiDiMode = False
      end
      object lblClienteDestino: TLabel
        Left = 39
        Top = 65
        Width = 99
        Height = 15
        BiDiMode = bdLeftToRight
        Caption = 'Cliente de Destino:'
        ParentBiDiMode = False
      end
      object lblDescricao: TLabel
        Left = 15
        Top = 94
        Width = 123
        Height = 15
        BiDiMode = bdLeftToRight
        Caption = 'Descri'#231#227'o da Transa'#231#227'o'
        ParentBiDiMode = False
      end
      object lblValor: TLabel
        Left = 109
        Top = 123
        Width = 29
        Height = 15
        BiDiMode = bdLeftToRight
        Caption = 'Valor:'
        ParentBiDiMode = False
      end
      object lblTipoTransacao: TLabel
        Left = 39
        Top = 152
        Width = 99
        Height = 15
        BiDiMode = bdLeftToRight
        Caption = 'Tipo de Transa'#231#227'o:'
        ParentBiDiMode = False
      end
      object edtClienteOrigem: TEdit
        Left = 144
        Top = 33
        Width = 265
        Height = 23
        TabOrder = 1
      end
      object edtDataTransacao: TDateTimePicker
        Left = 280
        Top = 4
        Width = 129
        Height = 23
        Date = 45845.000000000000000000
        Time = 0.142105127313698200
        Enabled = False
        TabOrder = 0
      end
      object edtClienteDestino: TEdit
        Left = 144
        Top = 62
        Width = 265
        Height = 23
        TabOrder = 2
      end
      object edtDescricaoTransacao: TEdit
        Left = 144
        Top = 91
        Width = 265
        Height = 23
        NumbersOnly = True
        TabOrder = 3
      end
      object edtValor: TMaskEdit
        Left = 144
        Top = 120
        Width = 128
        Height = 23
        EditMask = '99990,00;1;_'
        MaxLength = 8
        TabOrder = 4
        Text = '     ,  '
      end
      object cbxTipoTransacao: TComboBox
        Left = 144
        Top = 149
        Width = 130
        Height = 23
        ItemIndex = 0
        TabOrder = 5
        Text = 'Cr'#233'dito'
        Items.Strings = (
          'Cr'#233'dito'
          'D'#233'bito')
      end
    end
    object strGridTransacao: TStringGrid
      Left = 417
      Top = 2
      Width = 534
      Height = 435
      Align = alClient
      RowCount = 1
      FixedRows = 0
      TabOrder = 1
      ExplicitLeft = 616
      ExplicitTop = 152
      ExplicitWidth = 320
      ExplicitHeight = 120
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 528
    Width = 953
    Height = 64
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 2
    object btnSalvar: TButton
      Left = 872
      Top = 2
      Width = 79
      Height = 60
      Align = alRight
      Caption = 'Salvar'
      TabOrder = 0
      OnClick = btnSalvarClick
    end
  end
end
