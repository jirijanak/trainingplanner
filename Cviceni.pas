unit Cviceni;
(* Trida TCviceni *)

interface

uses
  SysUtils, Classes, Graphics, Controls, StdCtrls,
  Windows, Messages, Variants, Forms, Dialogs, ComCtrls,
  Buttons, ExtCtrls, MyUtils;

type
  TCviceni = class (TPanel)
    private
      FNazev,FLabel1,FLabel2:TLabel;
      FMinut,FKomentar:TEdit;
      FDelka:Integer;
      procedure onMinutExit(Sender: TObject);
      procedure setDelka(Value:Integer);
      procedure setDelkaStr(Value:String);
      function getNazev():String;
      function getDelkaStr():String;
    public
      procedure setNazev(Value:String); virtual;
      procedure VykresliPopis(Cvs:TCanvas; sirka,vyska:integer; var now_y:integer); virtual;
      constructor Create(AOwner: TComponent); override;
      property Nazev:String read getNazev write setNazev;
      property NazevLabel:TLabel read FNazev write FNazev;
      property Delka:Integer read FDelka write setDelka;
      property DelkaStr:String read getDelkaStr write setDelkaStr;
      property Label1:TLabel read FLabel1 write FLabel1;
      property Label2:TLabel read FLabel2 write FLabel2;
      property Minut:TEdit read FMinut write FMinut;
      property Komentar:TEdit read FKomentar write FKomentar;
  end;


implementation

(* procedure TCviceni.VykresliPopis
FUNKCE:
  Do zadaneho Canvasu vypise udaje o cviceni...
ARGUMENTY:
  Cvs - Canvas do ktereho se ma kreslit
  sirka - sirka plochy do ktere se kresli
  vyska - vyska plochy do ktere se kresli
  now_y - souradnice 'y' v plose kam se kresli (na jaky radek)
*)
procedure TCviceni.VykresliPopis(Cvs:TCanvas; sirka,vyska:integer; var now_y:integer);
var dilek_x,dilek_y,now_x:integer;
begin
  if (Delka>0) or (Komentar.Text<>'') then
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
    now_x:=now_x+TextWidth(Nazev)+dilek_x*5;

    //vypise komentar/popis cviceni
    Font.Style:=[];
    VypisTextDoObrazku(Cvs,now_x,sirka-dilek_x*5,now_y,Komentar.Text);
    now_y:=now_y+TextHeight('M')+dilek_y;
  end;
end;


procedure TCviceni.setNazev(Value:String);
begin
  FNazev.Caption:=Value;
end;


function TCviceni.getNazev():String;
begin
  Result:=FNazev.Caption;
end;


function TCviceni.getDelkaStr():String;
begin
  Result:=IntToStr(FDelka);
end;


procedure TCviceni.setDelka(Value:Integer);
begin
  FDelka:=Value;
  Minut.Text:=IntToStr(Value);
end;


procedure TCviceni.setDelkaStr(Value:String);
begin
  FDelka:=StrToInt(Value);
  Minut.Text:=Value;
end;


procedure TCviceni.onMinutExit(Sender: TObject);
begin
  Minut.Text:=ZpracujNaCislo(Minut.Text);
  DelkaStr:=Minut.Text;
end;


constructor TCviceni.Create(AOwner: TComponent);
begin
  inherited;
  Width:=541;
  Height:=23;
  Left:=2;
  BevelInner:=bvNone;
  BevelOuter:=bvNone;
  Font.Style:=[];
 //vytvoreni polozek
  NazevLabel:=TLabel.Create(nil);
  Label1:=TLabel.Create(nil);
  Label2:=TLabel.Create(nil);
  Minut:=TEdit.Create(nil);
  Komentar:=TEdit.Create(nil);
 //zobrazeni polozek
  NazevLabel.Parent:=self;
  Label1.Parent:=self;
  Label2.Parent:=self;
  Minut.Parent:=self;
  Komentar.Parent:=self;
 //umisteni polozek vodorovne
  NazevLabel.Left:=16;
  Label1.Left:=196;
  Label2.Left:=264;
  Minut.Left:=168;
  Komentar.Left:=320;
 //umisteni polozek svisle
  NazevLabel.Top:=4;
  Label1.Top:=4;
  Label2.Top:=4;
  Minut.Top:=1;
  Komentar.Top:=1;
 //velikost TEditu
  Minut.Width:=25;
  Minut.Height:=21;
  Komentar.Width:=200;
  Komentar.Height:=21;
 //zadani zakladnich textu
  NazevLabel.Caption:='Název cvièení:';
  Label1.Caption:='minut';
  Label2.Caption:='Komentáø:';
  Minut.Text:='0';
  Komentar.Text:='';
  Delka:=0;
 //fonty textu
  NazevLabel.Font.Style:=[];
  Label1.Font.Style:=[];
  Label2.Font.Style:=[];
  Minut.Font.Style:=[fsBold];
  Komentar.Font.Style:=[];
 //nastaveni akci
  Minut.OnExit:=onMinutExit;
end;


end.
