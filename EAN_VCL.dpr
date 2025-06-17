program EAN_VCL;

uses
  Vcl.Forms,
  EAN_main in 'EAN_main.pas' {FormMain},
  DocForm in 'DocForm.pas' {DocForm};

{$R *.res}

begin
  AssignFile(Output, 'calculations.txt');
  Rewrite(Output);
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
