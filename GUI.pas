unit GUI;
(* Hlavni formular celeho programu *)
(* =============================== *)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  Buttons, jpeg, Printers, Trenink, MyUtils;

type
  TForm1 = class(TForm)
    NextButton: TButton;
    BackButton: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
   //polozky prvniho listu
    Nadpis1: TLabel;
    Image1: TImage;
    AutorPanel: TPanel;
      AutorLabel: TLabel;
      EmailLabel: TLabel;
      WebLabel: TLabel;
      MyNameLabel: TLabel;
      MyMailLabel: TLabel;
      MyWebLabel: TLabel;
      LineLabel: TLabel;
   //polozky druheho listu
    Nadpis2: TLabel;
    ZakladniUdaje: TGroupBox;
      Label1: TLabel;
      Label2: TLabel;
      DelkaTreninku: TEdit;
    VedlejsiUdaje: TGroupBox;
      Label3: TLabel;
      Label4: TLabel;
      Label5: TLabel;
      Label6: TLabel;
      NazevDruzstva: TComboBox;
      Obdobi: TComboBox;
      Mikrocyklus: TEdit;
      Datum: TEdit;
    ZamereniTreninku: TGroupBox;
      Tema1: TCheckBox;
      Tema2: TCheckBox;
      Tema3: TCheckBox;
      Tema4: TCheckBox;
      Tema5: TCheckBox;
      Tema6: TCheckBox;
   //polozky tretiho listu
    Nadpis3: TLabel;
    Priprava: TGroupBox;
    HlavniCast: TGroupBox;
    Zaver: TGroupBox;
   //polozky ctvrteho listu
    Nadpis4: TLabel;
    Ulozit: TGroupBox;
      SirkaObrazku: TEdit;
      VyskaObrazku: TEdit;
      Label8: TLabel;
      Label9: TLabel;
      SaveButton: TButton;
    Vytisknout: TGroupBox;
      TiskButton: TButton;
    Image2: TImage;
    SaveDialog1: TSaveDialog;
    PrintDialog1: TPrintDialog;
   //obsluzne procedury
    procedure FormCreate(Sender: TObject);
    procedure NextButtonClick(Sender: TObject);
    procedure BackButtonClick(Sender: TObject);
    procedure DelkaTreninkuExit(Sender: TObject);
    procedure NazevDruzstvaExit(Sender: TObject);
    procedure ObdobiExit(Sender: TObject);
    procedure MikrocyklusExit(Sender: TObject);
    procedure DatumExit(Sender: TObject);
    procedure SirkaObrazkuExit(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure TiskButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Plan: TTrenink;
  TiskPlanu:TPrinter;


implementation

{$R *.dfm}


procedure TForm1.FormCreate(Sender: TObject);
begin
  //zakladni nastaveni a nacteni udaju z ext.souboru
  //do nekterych poli
  PageControl1.ActivePageIndex:=0;
  if FileExists('druzstva.txt') then NazevDruzstva.Items.LoadFromFile('druzstva.txt');
  if FileExists('obdobi.txt') then Obdobi.Items.LoadFromFile('obdobi.txt');
  Image2.Picture:=Image1.Picture;
  //nastaveni implicitni sirky obrazku pro ulozeni
  SirkaObrazku.Text:='800';
  VyskaObrazku.Text:=IntToStr(round(StrToInt(SirkaObrazku.Text)*1.414));

  Plan:=TTrenink.Create;
  with Plan do begin
    Rozcvicka.Parent:=self.Priprava;
    Rozchytani.Parent:=self.Priprava;
    Cvik1.Parent:=self.HlavniCast;
    Cvik2.Parent:=self.HlavniCast;
    Cvik3.Parent:=self.HlavniCast;
    Cvik4.Parent:=self.HlavniCast;
    Hra.Parent:=self.HlavniCast;
    Fyzicka.Parent:=self.Zaver;
    Zacvicka.Parent:=self.Zaver;

    Rozcvicka.Top:=19;
    Rozchytani.Top:=43;
    Cvik1.Top:=20;
    Cvik2.Top:=44;
    Cvik3.Top:=68;
    Cvik4.Top:=92;
    Hra.Top:=122;
    Fyzicka.Top:=19;
    Zacvicka.Top:=43;

    Rozcvicka.Font.Style:=[];
    Rozchytani.Font.Style:=[];
    Cvik1.Font.Style:=[];
    Cvik2.Font.Style:=[];
    Cvik3.Font.Style:=[];
    Cvik4.Font.Style:=[];
    Hra.Font.Style:=[];
    Fyzicka.Font.Style:=[];
    Zacvicka.Font.Style:=[];
  end;
end;


procedure TForm1.NextButtonClick(Sender: TObject);
var cannext:boolean;
 { Funkce vytvarejici text obsahujici zaskrknute polozky
   se zamerenim treninku  }
    function ZamereniTreninkuString():String;
    var Text:String;
    begin
      Text:='';
      if Form1.Tema1.Checked then Text:=Text+Form1.Tema1.Caption+'; ';
      if Form1.Tema2.Checked then Text:=Text+Form1.Tema2.Caption+'; ';
      if Form1.Tema3.Checked then Text:=Text+Form1.Tema3.Caption+'; ';
      if Form1.Tema4.Checked then Text:=Text+Form1.Tema4.Caption+'; ';
      if Form1.Tema5.Checked then Text:=Text+Form1.Tema5.Caption+'; ';
      if Form1.Tema6.Checked then Text:=Text+Form1.Tema6.Caption+'; ';
      Result:=Text;
    end;
 { Konec funkce}
begin
  cannext:=true;
  case PageControl1.ActivePageIndex of
    0: BackButton.Enabled:=True;
    1: begin
         Plan.Hlavicka.ZamereniTreninku:=ZamereniTreninkuString;
         Plan.Hra.Delka:=Plan.Delka;
       end;
    2: begin
         //zkontroluje ze soucet delek jednotlivych casti
         //treninku je mensi nebo roven delce treninku
         cannext:=false;
         Plan.CasNaHru(nil);
         if Plan.Hra.Delka<0
           then begin
                  ShowMessage('Dostali jste se s èasem do mínusu. Upravte èasové rozvržení.');
                end
           else begin
                 NextButton.Caption:='&Ukonèit';
                 cannext:=true;
                end;
       end;
    3: close;
  end;
 // nastaveni nasledujici stranky
  if cannext then PageControl1.ActivePage:=
    PageControl1.FindNextPage(PageControl1.ActivePage,True,False);
end;


procedure TForm1.BackButtonClick(Sender: TObject);
begin
 // nastaveni predchozi stranky
  case PageControl1.ActivePageIndex of
    1: BackButton.Enabled:=False;
    3: NextButton.Caption:='&Další  >>';
  end;
  PageControl1.ActivePage:=
    PageControl1.FindNextPage(PageControl1.ActivePage,False,False);
end;


procedure TForm1.DelkaTreninkuExit(Sender: TObject);
var ZadaneCislo:integer;
begin
  self.DelkaTreninku.Text:=ZpracujNaCislo(self.DelkaTreninku.Text);
  ZadaneCislo:=StrToInt(self.DelkaTreninku.Text);
  if ZadaneCislo<=0
    then begin
      ShowMessage('Spatne zadana delka treninku...');
      self.DelkaTreninku.Text:=IntToStr(Plan.Delka);
      end
    else Plan.Delka:=ZadaneCislo;
end;


procedure TForm1.NazevDruzstvaExit(Sender: TObject);
begin
  Plan.Hlavicka.Druzstvo:=self.NazevDruzstva.Text;
end;


procedure TForm1.ObdobiExit(Sender: TObject);
begin
  Plan.Hlavicka.Obdobi:=self.Obdobi.Text;
end;


procedure TForm1.MikrocyklusExit(Sender: TObject);
begin
  self.Mikrocyklus.Text:=ZpracujNaCislo(self.Mikrocyklus.Text);
  Plan.Hlavicka.Mikrocyklus:=self.Mikrocyklus.Text;
end;


procedure TForm1.DatumExit(Sender: TObject);
begin
  Plan.Hlavicka.Datum:=self.Datum.Text;
end;


procedure TForm1.SirkaObrazkuExit(Sender: TObject);
begin
  SirkaObrazku.Text:=ZpracujNaCislo(SirkaObrazku.Text);
  VyskaObrazku.Text:=IntToStr(round(StrToInt(SirkaObrazku.Text)*1.414));
end;


procedure TForm1.SaveButtonClick(Sender: TObject);
var JpegImg: TJpegImage;
    BmpImg: TBitMap;
    ActualDirectory: String;
begin
  GetDir(0,ActualDirectory);
  SaveDialog1.Filter := 'JPG files (*.jpg)|*.jpg';
  SaveDialog1.DefaultExt := 'jpg';
  SaveDialog1.FileName:='trenink.jpg';
  if SaveDialog1.Execute then begin
    ChDir(ActualDirectory);
    BmpImg:=TBitMap.Create;
    BmpImg.Width:=StrToInt(SirkaObrazku.Text);
    BmpImg.Height:=round(BmpImg.Width*1.414);
    Plan.VykresliNaCanvas(BmpImg.Canvas,BmpImg.Width,BmpImg.Height);
    JpegImg:=TJpegImage.Create;
    try
      JpegImg.Assign(BmpImg);
      JpegImg.SaveToFile(SaveDialog1.FileName);
    finally
      JpegImg.Free;
      BmpImg.Free;
    end;
  end;
end;


procedure TForm1.TiskButtonClick(Sender: TObject);
begin
  if PrintDialog1.Execute then
    with Printer do begin
      BeginDoc;
      Plan.VykresliNaCanvas(Canvas,PageWidth,PageHeight);
      EndDoc;
    end;
end;


end.
