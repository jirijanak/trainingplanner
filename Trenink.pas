unit Trenink;
(* Trida TTrenink *)

interface

uses
  Graphics, SysUtils, Hlavicka, Cviceni,
  CviceniSNakresem, MyUtils;

type
  TTrenink = class
    private
      FDelka:Integer;
      FHlavicka:THlavicka;
      FRozcvicka,FRozchytani,FFyzicka,FZacvicka,FHra:TCviceni;
      FCvik1,FCvik2,FCvik3,FCvik4:TCviceniSNakresem;
    public
      procedure CasNaHru(Sender: TObject);
      procedure VykresliNaCanvas(Canvas:TCanvas; sirka,vyska:integer);
      constructor Create();
      property Delka:Integer read FDelka write FDelka;
      property Hlavicka:THlavicka read FHlavicka write FHlavicka;
      property Rozcvicka:TCviceni read FRozcvicka write FRozcvicka;
      property Rozchytani:TCviceni read FRozchytani write FRozchytani;
      property Cvik1:TCviceniSNakresem read FCvik1 write FCvik1;
      property Cvik2:TCviceniSNakresem read FCvik2 write FCvik2;
      property Cvik3:TCviceniSNakresem read FCvik3 write FCvik3;
      property Cvik4:TCviceniSNakresem read FCvik4 write FCvik4;
      property Hra:TCviceni read FHra write FHra;
      property Fyzicka:TCviceni read FFyzicka write FFyzicka;
      property Zacvicka:TCviceni read FZacvicka write FZacvicka;
  end;


implementation

(* procedure TTrenink.VykresliNaCanvas
FUNKCE:
  Do zadaneho Canvasu vykresli PLAN TRENINKU...
ARGUMENTY:
  Cvs - Canvas do ktereho se ma kreslit
  sirka - sirka plochy do ktere se kresli
  vyska - vyska plochy do ktere se kresli
*)
procedure TTrenink.VykresliNaCanvas(Canvas:TCanvas; sirka,vyska:integer);
var dilek_x,dilek_y,nakres_x,nakres_y,now_y:integer;
begin
  dilek_x:=round(sirka/190);
  dilek_y:=round(vyska/265);
  nakres_x:=(sirka-2*dilek_x) div 4;
  nakres_y:=round(nakres_x*1.875);
  with Canvas do begin
    now_y:=dilek_y*3;
    Pen.Color := clBlack;
    Font.Name:='Arial';
   {vytvoreni vnejsiho oramovani}
    Pen.Width := dilek_x;
    Rectangle(0, 0, Sirka, Vyska);
   {vypsani hlavicky}
    Hlavicka.Vykresli(Canvas,Sirka,Vyska,now_y);
   {vytvoreni delici cary mezi hlavickou a nakresy/popisy cv.}
    now_y:=now_y+dilek_y*3;
    Pen.Width := dilek_x*2;
    MoveTo(0,now_y);
    LineTo(Sirka,now_y);
   {vykresleni nakresu cviceni}
    now_y:=now_y+dilek_y*7;
    Cvik1.VykresliNakres(Canvas,nakres_x,nakres_y,dilek_x,now_y);
    Cvik2.VykresliNakres(Canvas,nakres_x,nakres_y,dilek_x+nakres_x,now_y);
    Cvik3.VykresliNakres(Canvas,nakres_x,nakres_y,dilek_x+2*nakres_x,now_y);
    Cvik4.VykresliNakres(Canvas,nakres_x,nakres_y,dilek_x+3*nakres_x,now_y);
   {vypsani popisu cviceni}
    now_y:=now_y+nakres_y+dilek_y*7;
    Rozcvicka.VykresliPopis(Canvas,Sirka,Vyska,now_y);
    Rozchytani.VykresliPopis(Canvas,Sirka,Vyska,now_y);
    Cvik1.VykresliPopis(Canvas,Sirka,Vyska,now_y);
    Cvik2.VykresliPopis(Canvas,Sirka,Vyska,now_y);
    Cvik3.VykresliPopis(Canvas,Sirka,Vyska,now_y);
    Cvik4.VykresliPopis(Canvas,Sirka,Vyska,now_y);
    Hra.VykresliPopis(Canvas,Sirka,Vyska,now_y);
    Fyzicka.VykresliPopis(Canvas,Sirka,Vyska,now_y);
    Zacvicka.VykresliPopis(Canvas,Sirka,Vyska,now_y);
  end;
end;


(* procedure TTrenink.CasNaHru
FUNKCE:
  Spocita kolik casu zbyva na hru vzdy kdyz se zmeni
  delka nektereho z cviceni *)
procedure TTrenink.CasNaHru(Sender: TObject);
begin
  Hra.Delka:=Delka
        - Rozcvicka.Delka
        - Rozchytani.Delka
        - Cvik1.Delka
        - Cvik2.Delka
        - Cvik3.Delka
        - Cvik4.Delka
        - Fyzicka.Delka
        - Zacvicka.Delka;
end;


constructor TTrenink.Create();
begin
  Delka:=120;
  Hlavicka:=THlavicka.Create;
  Rozcvicka:=TCviceni.Create(nil);
  Rozchytani:=TCviceni.Create(nil);
  Cvik1:=TCviceniSNakresem.Create(nil);
  Cvik2:=TCviceniSNakresem.Create(nil);
  Cvik3:=TCviceniSNakresem.Create(nil);
  Cvik4:=TCviceniSNakresem.Create(nil);
  Hra:=TCviceni.Create(nil);
  Fyzicka:=TCviceni.Create(nil);
  Zacvicka:=TCviceni.Create(nil);

  Rozcvicka.Nazev:='Rozbìhání a protažení:';
  Rozchytani.Nazev:='Základní rozchytání brankáøù:';
  Fyzicka.Nazev:='Trénink fyzické kondice:';
  Zacvicka.Nazev:='Závìreèný výklus:';
  Hra.Nazev:='Hra:';
  Cvik1.Nazev:='Cvièení 1:';
  Cvik2.Nazev:='Cvièení 2:';
  Cvik3.Nazev:='Cvièení 3:';
  Cvik4.Nazev:='Cvièení 4:';

  Rozcvicka.OnExit:=CasNaHru;
  Rozchytani.OnExit:=CasNaHru;
  Cvik1.OnExit:=CasNaHru;
  Cvik2.OnExit:=CasNaHru;
  Cvik3.OnExit:=CasNaHru;
  Cvik4.OnExit:=CasNaHru;
  Fyzicka.OnExit:=CasNaHru;
  Zacvicka.OnExit:=CasNaHru;

  Hra.Minut.Enabled:=false;
  Hra.Minut.Width:=30;
  Hra.Minut.Left:=Hra.Minut.Left-5;
end;


end.
