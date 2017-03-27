program Florbal;

uses
  Forms,
  GUI in 'GUI.pas' {Form1},
  VzorGUI in 'VzorGUI.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
