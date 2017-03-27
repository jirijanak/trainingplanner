unit VzorGUI;
(* Formular pro vyber vzoru a editaci cviceni s nakresem *)
(* ===================================================== *)

interface

uses
  Windows, Messages, Variants, Graphics, Dialogs, Buttons,
  SysUtils, Forms, StdCtrls, Controls, Classes, ExtCtrls,
  MyUtils;

type
  TForm2 = class(TForm)
    Image1: TImage;
    ZpetButton: TSpeedButton;
    VpredButton: TSpeedButton;
    Label1: TLabel;
    Name: TEdit;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Popis: TMemo;
    OKButton: TSpeedButton;
    Label3: TLabel;
    Minut: TEdit;
    procedure VypisCviceni(Index:Integer);
    procedure ZpetButtonClick(Sender: TObject);
    procedure VpredButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure aktualizuj_seznam();
    procedure MinutExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  SeznamSouboru:TStringList;
  Aktual,Max: Integer;

implementation

{$R *.dfm}


procedure TForm2.VypisCviceni(Index:Integer);
var filename:String;
begin
  Popis.Lines.Clear;
  filename:=ExtractFileName(SeznamSouboru.Strings[Index]);
  if FileExists('cviceni\'+filename)
    then Image1.Picture.LoadFromFile('cviceni\'+filename);
  filename:=ChangeFileExt(filename,'.TXT');
  if FileExists('text\'+filename)
    then begin
          Popis.Lines.LoadFromFile('text\'+filename);
          Name.Text:=Popis.Lines.Strings[0];
          Popis.Lines.Delete(0);
         end
    else Name.Text:=SeznamSouboru.Strings[Index];
end;


procedure TForm2.aktualizuj_seznam();
var sr: TSearchRec;
begin
  SeznamSouboru.Clear;
  if FindFirst('cviceni\*.JPG', faAnyFile, sr)=0
    then begin
      repeat
        SeznamSouboru.Add(sr.Name);
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;
  SeznamSouboru.Sort;
  Aktual:=0;
  Max:=SeznamSouboru.Count-1;
end;


procedure TForm2.ZpetButtonClick(Sender: TObject);
begin
  Aktual:=Aktual-1;
  If Aktual<0 then Aktual:=Max;
  VypisCviceni(Aktual);
end;


procedure TForm2.VpredButtonClick(Sender: TObject);
begin
  Aktual:=Aktual+1;
  If Aktual>Max then Aktual:=0;
  VypisCviceni(Aktual);
end;


procedure TForm2.FormCreate(Sender: TObject);
begin
  SeznamSouboru:=TStringList.Create;
  aktualizuj_seznam();
  VypisCviceni(Aktual);
end;


procedure TForm2.OKButtonClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;


procedure TForm2.MinutExit(Sender: TObject);
begin
  Minut.Text:=ZpracujNaCislo(Minut.Text);
end;


end.
