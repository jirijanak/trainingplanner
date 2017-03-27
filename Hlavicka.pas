unit Hlavicka;
(* Trida THlavicka *)

interface

uses
  Graphics, SysUtils, MyUtils;

type
  THlavicka = class
    private
      FDruzstvo,FObdobi,FDatum,FMikrocyklus,FZamereniTreninku:String;
    public
      property Druzstvo:String read FDruzstvo write FDruzstvo;
      property Obdobi:String read FObdobi write FObdobi;
      property Datum:String read FDatum write FDatum;
      property Mikrocyklus:String read FMikrocyklus write FMikrocyklus;
      property ZamereniTreninku:String read FZamereniTreninku
                                       write FZamereniTreninku;
      procedure Vykresli(Cvs:TCanvas; sirka,vyska:integer; var now_y:integer);
      constructor Create();
  end;


implementation

(* procedure THlavicka.Vykresli
FUNKCE:
  Do zadaneho Canvasu vykresli text hlavicky...
ARGUMENTY:
  Cvs - Canvas do ktereho se ma kreslit
  sirka - sirka plochy do ktere se kresli
  vyska - vyska plochy do ktere se kresli
  now_y - souradnice 'y' v plose kam se kresli (na jaky radek)
*)
procedure THlavicka.Vykresli(Cvs:TCanvas; sirka,vyska:integer; var now_y:integer);
var dilek_x,dilek_y,now_x:integer;
begin
  dilek_x:=round(Sirka/190);
  dilek_y:=round(Vyska/265);
  with Cvs do begin
    Font.Height:=dilek_y*(-4);

   //tucne vypise nazvy poli
    Font.Style:=[fsBold];
    now_x:=dilek_x*2;
    TextOut(now_x,now_y,'Družstvo:');
    now_x:=round(sirka/4);
    TextOut(now_x,now_y,'Datum:');
    now_x:=round(sirka/5*3);
    TextOut(now_x,now_y,'Období:');

   //tucne vypise obsah polozek k polim
    Font.Style:=[];
    now_x:=dilek_x*2+TextWidth('Družstvo:')+dilek_x*5;
    TextOut(now_x,now_y,Druzstvo);
    now_x:=round(sirka/4)+TextWidth('Datum:')+dilek_x*5;
    TextOut(now_x,now_y,Datum);
    now_x:=round(sirka/5*3)+TextWidth('Období:')+dilek_x*5;
    TextOut(now_x,now_y,Obdobi);

    //novy radek
    now_y:=now_y+TextHeight('M')+dilek_y;

   //tucne vypise nazvy poli
    Font.Style:=[fsBold];
    now_x:=dilek_x*2;
    TextOut(now_x,now_y,'Trénink è.:');
    now_x:=round(sirka/4);
    TextOut(now_x,now_y,'zamìøený na:');

   //tucne vypise obsah polozek k polim
    Font.Style:=[];
    now_x:=dilek_x*2+TextWidth('Družstvo:')+dilek_x*5;
    TextOut(now_x,now_y,Mikrocyklus);
    now_x:=round(sirka/4)+TextWidth('zamìøený na:')+dilek_x*5;
    VypisTextDoObrazku(Cvs,now_x,sirka-dilek_x*5,now_y,ZamereniTreninku);
  end;
end;


constructor THlavicka.Create();
begin
  Druzstvo:='';
  Obdobi:='';
  Datum:='';
  ZamereniTreninku:='';
  Mikrocyklus:='';
end;


end.
