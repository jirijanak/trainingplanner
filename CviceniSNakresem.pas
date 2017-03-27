unit CviceniSNakresem;
(* Trida TCviceniSNakresem *)

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, ComCtrls,
  Messages, Variants, Forms, Dialogs, StdCtrls, ExtCtrls,
  Buttons, jpeg, Cviceni,VzorGUI, MyUtils;

type
  TCviceniSNakresem = class (TCviceni)
    private
      FPopis:TStringList;
      FVzor,FSmaz:TSpeedButton;
      FNakres,PrvniJmeno:String;
      procedure VzorClick(Sender: TObject);
      procedure SmazClick(Sender: TObject);
    public
      procedure setNazev(Value:String); override;
      procedure VykresliNakres(Cvs:TCanvas; sirka_nakresu,vyska_nakresu,x,y:integer);
      procedure VykresliPopis(Cvs:TCanvas; sirka,vyska:integer; var now_y:integer); override;
      constructor Create(AOwner: TComponent); override;
      property Vzor:TSpeedButton read FVzor write FVzor;
      property Smaz:TSpeedButton read FSmaz write FSmaz;
      property Nakres:String read FNakres write FNakres;
      property Popis:TStringList read FPopis write FPopis;
  end;


implementation

(* procedure TCviceniSNakresem.VykresliNakres
FUNKCE:
  Do zadaneho Canvasu vykresli nakres cviceni...
ARGUMENTY:
  Cvs - Canvas do ktereho se ma kreslit
  sirka_nakresu - sirka jakou ma nakres mit
  vyska_nakresu - vyska jakou ma nakres mit
  x,y - souradnice 'x' a 'y' v plose kam se ma nakres vykreslit
*)
procedure TCviceniSNakresem.VykresliNakres(Cvs:TCanvas; sirka_nakresu,vyska_nakresu,x,y:integer);
var copy,paste:TRect;
    copyjpg:TJpegImage;
    copybmp:TBitMap;
begin
  with Cvs do begin
    //prevede nakres z JPG do bitmapy a tu pak nakopiruje na Canvas
    copyjpg:=TJpegImage.Create;
    copyjpg.LoadFromFile(Nakres);
    copybmp:=TBitMap.Create;
    copybmp.Assign(copyjpg);
    copy:=Rect(0,0,240,450);
    paste:=Rect(x,y, x+sirka_nakresu, y+vyska_nakresu);
    CopyRect(paste,copybmp.Canvas,copy);
  end;
end;


(* procedure TCviceniSNakresem.VykresliPopis
FUNKCE:
  Do zadaneho Canvasu vypise udaje o cviceni...
ARGUMENTY:
  Cvs - Canvas do ktereho se ma kreslit
  sirka - sirka plochy do ktere se kresli
  vyska - vyska plochy do ktere se kresli
  now_y - souradnice 'y' v plose kam se kresli (na jaky radek)
*)
procedure TCviceniSNakresem.VykresliPopis(Cvs:TCanvas; sirka,vyska:integer; var now_y:integer);
var dilek_x,dilek_y,now_x,i:integer;
begin
  if (Delka>0) or (Popis.Count>0) then
  with Cvs do begin
    dilek_x:=round(Sirka/190);
    dilek_y:=round(Vyska/265);
    now_x:=dilek_x*5;
    Font.Height:=dilek_y*(-3);

    //vypise pocet minut a nazev cviceni
    Font.Style:=[fsBold];
    TextOut(now_x,now_y,DelkaStr+' min');
    now_x:=now_x+TextWidth('000 min')+dilek_x*5;
    TextOut(now_x,now_y,Nazev);

    //vypise komentar/popis cviceni
    Font.Style:=[];
    now_y:=now_y+TextHeight('M')+dilek_y;
    for i:=0 to Popis.Count-1 do
       VypisTextDoObrazku(Cvs,now_x,sirka-(dilek_x*5),now_y,Popis.Strings[i]);
    now_y:=now_y+TextHeight('M')+dilek_y;
  end;
end;


procedure TCviceniSNakresem.setNazev(Value:String);
begin
  inherited setNazev(Value);
  if PrvniJmeno='' then PrvniJmeno:=Value;
end;


procedure TCviceniSNakresem.VzorClick(Sender: TObject);
begin
  if Vzor.Caption='Vybrat/Vytvoøit'
    then begin
           Aktual:=0;
           Form2.Popis.WordWrap:=true;
           Form2.VypisCviceni(Aktual);
         end
    else begin
           Form2.Name.Text:=Nazev;
           Form2.Minut.Text:=DelkaStr;
           Form2.Image1.Picture.LoadFromFile(Nakres);
           Form2.Popis.Clear;
           Form2.Popis.Lines.AddStrings(Popis);
           Form2.Popis.WordWrap:=true;
         end;

  if Form2.ShowModal = mrOK
      then begin
             Vzor.Caption:='Editovat';
             Smaz.Enabled:=true;
             Nazev:=Form2.Name.Text;
             if Form2.Minut.Text='' then Form2.Minut.Text:='0';
             DelkaStr:=Form2.Minut.Text;
             Nakres:='cviceni\'+ExtractFileName(SeznamSouboru.Strings[Aktual]);
             Popis.Clear;
             Form2.Popis.WordWrap:=false;
             Popis.AddStrings(Form2.Popis.Lines);
           end;
end;


procedure TCviceniSNakresem.SmazClick(Sender: TObject);
begin
  Vzor.Caption:='Vybrat/Vytvoøit';
  Smaz.Enabled:=false;
  Nazev:=PrvniJmeno;
  Nakres:='cviceni\empty.jpg';
  Popis.Clear;
  Delka:=0;
end;


constructor TCviceniSNakresem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Komentar.Visible:=False;
  Label2.Caption:='Volby:';
 //vytvoreni dalsich polozek
  Vzor:=TSpeedButton.Create(nil);
  Smaz:=TSpeedButton.Create(nil);
 //zobrazeni polozek
  Vzor.Parent:=self;
  Smaz.Parent:=self;
 //velikosti polozek
  Vzor.Height:=21;
  Smaz.Height:=21;
  Vzor.Width:=94;
  Smaz.Width:=94;
 //umisteni polozek svisle
  Vzor.Top:=1;
  Smaz.Top:=1;
 //umisteni polozek vodorovne
  Vzor.Left:=320;
  Smaz.Left:=424;
 //napisy na polozky
  Vzor.Caption:='Vybrat/Vytvoøit';
  Smaz.Caption:='Odstranit';
 //font napisu
  Vzor.Font.Style:=[fsBold];
  Smaz.Font.Style:=[fsBold];
 //nastaveni funkci
  Vzor.OnClick:=VzorClick;
  Smaz.OnClick:=SmazClick;
 //disabling
  Smaz.Enabled:=False;
 //inicializace novych polozek
  PrvniJmeno:='';
  Nakres:='cviceni\empty.jpg';
  Popis:=TStringList.Create;
end;


end.
