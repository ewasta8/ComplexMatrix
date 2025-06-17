unit EAN_main;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.DBCtrls, Vcl.ComCtrls, ComplexMatrix, IntervalArithmetic32and64, DocForm, Vcl.Buttons;
  type
  TFormMain = class(TForm)
    BtnSetSize: TButton;
    BtnEnter: TButton;
    BtnDoc: TButton;
    BtnSolve: TButton;
    BtnClear: TButton;
    GrpArithmetic: TGroupBox;
    GrpDataType: TGroupBox;
    GrpData: TGroupBox;
    GrpAnswer: TGroupBox;
    RBtnArithmeticStd: TRadioButton;
    RBtnArithmeticInterval: TRadioButton;
    RBtnDataTypeStd: TRadioButton;
    RBtnDataTypeInterval: TRadioButton;
    EditN: TEdit;
    EditAre: TEdit;
    EditAim: TEdit;
    EditAAre: TEdit;
	EditAAim: TEdit;
    EditABre: TEdit;
    EditABim: TEdit;
    LblN: TLabel;
    LblA: TLabel;
    LblAre: TLabel;
    LblAim: TLabel;
    MemoAnswer: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure RadioClick(Sender: TObject);
    procedure EditExtExit(Sender: TObject);
    procedure EditIntExit(Sender: TObject);
    procedure BtnSetSizeClick(Sender: TObject);
    procedure BtnEnterClick(Sender: TObject);
    procedure BtnDocClick(Sender: TObject);
    procedure BtnSolveClick(Sender: TObject);
    procedure BtnClearClick(Sender: TObject);
  private
    procedure UpdateVisibility;
    procedure ValidateInt(Edit: TEdit);
    function ValidateExt(Edit: TEdit): Boolean;
    function ComplexMatrixToStr(const x: cplxvector): string;
    function iComplexMatrixToStr(const x: icplxvector): string;
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;
  n, i, j: Integer;
  a: cplxmatrix;
  ai: icplxmatrix;

implementation

{$R *.dfm}

procedure TFormMain.FormCreate(Sender: TObject);
begin
  RBtnArithmeticStd.Checked := True;
  RBtnDataTypeStd.Checked := True;
  UpdateVisibility;
end;

procedure TFormMain.RadioClick(Sender: TObject);
begin
  if RBtnArithmeticStd.Checked then
  begin
    RBtnDataTypeInterval.Enabled := False;
    RBtnDataTypeStd.Checked := True;
  end
  else
      RBtnDataTypeInterval.Enabled := True;
  UpdateVisibility;
  EditAre.Enabled := False; EditAim.Enabled := False;
  EditAAre.Enabled := False; EditABre.Enabled := False;
  EditAAim.Enabled := False; EditABim.Enabled := False;
  BtnEnter.Enabled := False;
  BtnSolve.Enabled := False;
end;

procedure TFormMain.UpdateVisibility;
begin
  if RBtnDataTypeStd.Checked then
  begin
    LblA.Caption := 'Podaj wartoœæ a[i,j]';
    EditAre.Visible := True;
    EditAim.Visible := True;
    EditAAre.Visible := False;
	  EditAAim.Visible := False;
    EditABre.Visible := False;
    EditABim.Visible := False;
  end
  else
  begin
    LblA.Caption := 'Podaj wartoœæ koñców przedzia³u a[i,j].a a[i,j].b';
    EditAre.Visible := False;
    EditAim.Visible := False;
    EditAAre.Visible := True;
	  EditAAim.Visible := True;
    EditABre.Visible := True;
    EditABim.Visible := True;
  end;
end;

procedure TFormMain.ValidateInt(Edit: TEdit);
var
  Value: Integer;
begin
  if Trim(Edit.Text) = '' then
  begin
    ShowMessage('Pole "' + Edit.Name + '" jest puste.');
    Edit.SetFocus;
    Exit;
  end;
  if not TryStrToInt(Trim(Edit.Text), Value) or (Value <= 0) then
  begin
    ShowMessage('Wpisz liczbê ca³kowit¹ wiêksz¹ od zera w polu "' + Edit.Name + '".');
    Edit.SetFocus;
  end;
end;

function TFormMain.ValidateExt(Edit: TEdit): Boolean;
var
  Value: Extended;
  TextVal: string;
  fs: TFormatSettings;
begin
  TextVal := Trim(Edit.Text);
  Result := False;
  if TextVal = '' then
  begin
    ShowMessage('Pole "' + Edit.Name + '" jest puste.');
    Edit.SetFocus;
    Exit;
  end;
  TextVal := StringReplace(TextVal, ',', '.', [rfReplaceAll]);
  fs := TFormatSettings.Create;
  fs.DecimalSeparator := '.';
  if TryStrToFloat(TextVal, Value, fs) then
    Result := True
  else begin
    ShowMessage('B³êdny format liczby zmiennoprzecinkowej w polu "' + Edit.Name + '".');
    Edit.SetFocus;
  end;
end;

procedure TFormMain.BtnSetSizeClick(Sender: TObject);
begin
  if not TryStrToInt(Trim(EditN.Text), n) or (n <= 0) then
  begin
    ShowMessage('Liczba niewiadomych musi byæ wiêksza od zera');
    Exit;
  end;
  i := 0;
  j := 0;
  if RBtnArithmeticStd.Checked then
    SetLength(a, n, n+1)
  else
    SetLength(ai, n, n+1);
  BtnEnter.Enabled := True;
  EditAre.Enabled := True;
  EditAim.Enabled := True;
  EditAAre.Enabled := True;
  EditAAim.Enabled := True;
  EditABre.Enabled := True;
  EditABim.Enabled := True;
  BtnSetSize.Enabled := False;
  LblA.Caption := Format('Podaj a[%d,%d]:', [i+1, j+1]);
  EditN.Enabled := False;
  BtnSetSize.Enabled := False;
  BtnEnter.Enabled := True;
  if RBtnDataTypeInterval.Checked then
          EditAAre.SetFocus
      else
          EditAre.SetFocus;
end;

procedure TFormMain.EditIntExit(Sender: TObject);
begin
  ValidateInt(TEdit(Sender));
end;

procedure TFormMain.EditExtExit(Sender: TObject);
begin
  ValidateExt(TEdit(Sender));
end;

procedure TFormMain.BtnEnterClick(Sender: TObject);
var
  re, im, reA, reB, imA, imB: Extended;
  valStr: string;
  fs: TFormatSettings;
begin
  if n <= 0 then
  begin
    ShowMessage('Najpierw ustaw n');
    Exit;
  end;

  if RBtnArithmeticStd.Checked then
  begin
    if not (ValidateExt(EditAre) and ValidateExt(EditAim)) then Exit;
    if (i < n) and (j < n+1) then
    begin
      FormatSettings.DecimalSeparator := '.';
      valStr := StringReplace(EditAre.Text, ',', '.', [rfReplaceAll]);
      re := StrToFloat(valStr);
      valStr := StringReplace(EditAim.Text, ',', '.', [rfReplaceAll]);
      im := StrToFloat(valStr);

      a[i][j].re := re;
      a[i][j].im := im;

      Inc(j);
      if j >= n+1 then
      begin
        j := 0;
        Inc(i);
      end;

      if i < n then
	  begin
        LblA.Caption := Format('Podaj a[%d,%d]:', [i+1, j+1]);
        EditAre.Clear;
        EditAim.Clear;
        EditAre.SetFocus;
      end
      else
      begin
        LblA.Caption := 'Macierz zosta³a wype³niona';
		    EditAre.Enabled := False;
        EditAim.Enabled := False;
        BtnEnter.Enabled := False;
        BtnSolve.Enabled := True;
        BtnSolve.SetFocus;
      end;
    end;
    Exit;
  end;

  if (i < n) and (j < n+1) then
  begin
    if RBtnDataTypeInterval.Checked then
    begin
      if not (ValidateExt(EditAAre) and ValidateExt(EditABre)
         and ValidateExt(EditAAim) and ValidateExt(EditABim)) then Exit;

      reA := left_read(StringReplace(EditAAre.Text, ',', '.', [rfReplaceAll]));
      reB := right_read(StringReplace(EditABre.Text, ',', '.', [rfReplaceAll]));
      imA := left_read(StringReplace(EditAAim.Text, ',', '.', [rfReplaceAll]));
      imB := right_read(StringReplace(EditABim.Text, ',', '.', [rfReplaceAll]));
    end
    else
    begin
      fs := TFormatSettings.Create;
      fs.DecimalSeparator := '.';

      if not (ValidateExt(EditAre) and ValidateExt(EditAim)) then Exit;

      valStr := StringReplace(EditAre.Text, ',', '.', [rfReplaceAll]);
      reA := left_read(StringReplace(EditAre.Text, ',', '.', [rfReplaceAll]));
      reB := right_read(StringReplace(EditAre.Text, ',', '.', [rfReplaceAll]));

      valStr := StringReplace(EditAim.Text, ',', '.', [rfReplaceAll]);
      imA := left_read(StringReplace(EditAim.Text, ',', '.', [rfReplaceAll]));
      imB := right_read(StringReplace(EditAim.Text, ',', '.', [rfReplaceAll]));
    end;


    if (reA > reB) or (imA > imB) then
    begin
      ShowMessage('Prawy koniec przedzia³u jest mniejszy ni¿ lewy koniec przedzia³u');
      Exit;
    end;

    ai[i][j].re.a := reA;
    ai[i][j].re.b := reB;
    ai[i][j].im.a := imA;
    ai[i][j].im.b := imB;

    Inc(j);
    if j >= n+1 then
    begin
      j := 0;
      Inc(i);
    end;

    if i < n then
	begin
      LblA.Caption := Format('Podaj a[%d,%d]:', [i+1, j+1]);
	    EditAre.Clear;
      EditAim.Clear;
      EditAAre.Clear;
      EditAAim.Clear;
      EditABre.Clear;
      EditABim.Clear;
      if RBtnDataTypeInterval.Checked then
          EditAAre.SetFocus
      else
          EditAre.SetFocus;
      end
    else
	  begin
        LblA.Caption := 'Macierz zosta³a wype³niona';
        EditAAre.Enabled := False;
        EditAAim.Enabled := False;
        EditABre.Enabled := False;
        EditABim.Enabled := False;
        BtnEnter.Enabled := False;
        BtnSolve.Enabled := True;
        BtnSolve.SetFocus;
      end;
    end;
  end;


procedure TFormMain.BtnDocClick(Sender: TObject);
var
  f: TDocForm;
begin
  f := TDocForm.Create(Self);
  try
    f.ShowModal;
  finally
    f.Free;
  end;
end;

function TFormMain.ComplexMatrixToStr(const x: cplxvector): string;
var
  idx: Integer;
  fmt: string;
  fs: TFormatSettings;
begin
  Result := '';
  fmt := '0.0000000000000000E+0000';
  fs := TFormatSettings.Create;
  fs.DecimalSeparator := '.';

  for idx := 0 to High(x) do
    Result := Result +
      'x[' + IntToStr(idx+1) + '].re = ' + FormatFloat(fmt, x[idx].re, fs) + sLineBreak +
      'x[' + IntToStr(idx+1) + '].im = ' + FormatFloat(fmt, x[idx].im, fs) + sLineBreak;

end;

function TFormMain.iComplexMatrixToStr(const x: icplxvector): string;
var
  idx: Integer;
  fmt: string;
  fs: TFormatSettings;
  wRe, wIm: Extended;
  leftStr, rightStr: string;
begin
  Result := '';
  fmt := '0.0000000000000000E+0000';
  fs := TFormatSettings.Create;
  fs.DecimalSeparator := '.';

  for idx := 0 to High(x) do
  begin
    wRe := int_width(x[idx].re);
    wIm := int_width(x[idx].im);

    iends_to_strings(x[idx].re, leftStr, rightStr);
    Result := Result +
      'x[' + IntToStr(idx+1) + '].re = [' + leftStr + ', ' + rightStr + '],' + sLineBreak +
      'w = ' + FormatFloat(fmt, wRe, fs) + sLineBreak;

    iends_to_strings(x[idx].im, leftStr, rightStr);
    Result := Result +
      'x[' + IntToStr(idx+1) + '].im = [' + leftStr + ', ' + rightStr + '],' + sLineBreak +
      'w = ' + FormatFloat(fmt, wIm, fs) + sLineBreak;
  end;
end;

procedure TFormMain.BtnSolveClick(Sender: TObject);
var
  resultText: string;
  x: cplxvector;
  xi: icplxvector;
  st: Integer;
begin
  try
    if RBtnArithmeticStd.Checked then
    begin
      SetLength(x, n);
      pComplexMatrix(n, a, x, st);
      if st = 0 then
        resultText := ComplexMatrixToStr(x)
      else
        resultText := 'Uk³ad jest osobliwy (st=' + IntToStr(st) + ')';
    end
    else
    begin
      SetLength(xi, n);
      piComplexMatrix(n, ai, xi, st);
      if st = 0 then
        resultText := iComplexMatrixToStr(xi)
      else
        resultText := 'Uk³ad jest osobliwy (st=' + IntToStr(st) + ')';
    end;

    MemoAnswer.Lines.Text := resultText;
    BtnSolve.Enabled := False;
  except
    on E: Exception do
      ShowMessage('B³¹d podczas rozwi¹zywania: ' + E.Message);
  end;
end;

procedure TFormMain.BtnClearClick(Sender: TObject);
begin
  EditN.Clear;
  EditAre.Clear; EditAim.Clear;
  EditAAre.Clear; EditABre.Clear;
  EditAAim.Clear; EditABim.Clear;
  MemoAnswer.Clear;
  EditN.Enabled := True;
  BtnSetSize.Enabled := True;
  EditAre.Enabled := False; EditAim.Enabled := False;
  EditAAre.Enabled := False; EditABre.Enabled := False;
  EditAAim.Enabled := False; EditABim.Enabled := False;
  BtnEnter.Enabled := False;
end;

end.

