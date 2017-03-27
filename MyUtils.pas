unit MyUtils;
(* Nektere pomocne obsluzne utility *)

interface

uses
  Graphics, SysUtils;

function ZpracujNaCislo(Text:String):String;
procedure VypisTextDoObrazku(Cvs:TCanvas;StartX,EndX:Integer;var now_y:integer;Text:String);


implementation

(* function ZpracujNaCislo
FUNKCE:
  Ze zadaneho textoveho retezce (Text:String) odstrani
  vsechny nenumericke znaky. Je-li pak retezec prazdny,
  vrati '0'
*)
function ZpracujNaCislo(Text:String):String;
var OutText:String;
    IntSet:set of '0'..'9';   //mnozina pripustnych hodnot
    NulaNaZacatku:boolean;
    i:integer;
begin
  IntSet:=['0','1','2','3','4','5','6','7','8','9'];
  NulaNaZacatku:=true;
  for i:=1 to Length(Text) do
    if Text[i] in IntSet
      then begin
            if Text[i]='0'
              then begin
                      if NulaNaZacatku=false
                        then OutText:=OutText+Text[i];
                    end
               else begin
                      NulaNaZacatku:=false;
                      OutText:=OutText+Text[i];
                    end;
           end;
  if OutText='' then OutText:='0';
  Result:=OutText;
end;


(* VypisTextDoObrazku
FUNKCE:
  Do zadaneho Canvasu vypise zadany text...
ARGUMENTY:
  Cvs - Canvas do ktereho se ma kreslit
  StartX - LEVY kraj oblasti plochy kam se ma vypisovat
  EndX - PRAVY kraj oblasti plochy kam se ma vypisovat
  now_y - souradnice 'y' v plose kam se kresli (na jaky radek)
  Text - text k vypsani
*)
procedure VypisTextDoObrazku(Cvs:TCanvas;StartX,EndX:Integer;var now_y:integer;Text:String);
var char_y,sirkaplochy,i,space:integer;
    showtext,slovo:string;
begin
  char_y:=Cvs.TextHeight('M');
  sirkaplochy:=EndX-StartX;
  i:=1;  //aktualni pozice ve vstupnim textovem retezci
  space:=0;  //pozice posledni mezery
  showtext:='';  //obsahuje jeden "graficky radek" k vypsani
  while i<=Length(Text) do begin
    //zkopiruje z textu jedno slovo
    while ((i<=Length(Text)) and (Text[i]<>' '))
      do begin
          slovo:=slovo+Text[i];
          i:=i+1;
         end;
    //zjisti jestli se nactene slovo jeste vleze na dany
    //radek, pokud ano pripoji ho k radku, pokud ne
    //vypise radek a skoci na novy
    if Cvs.TextWidth(showtext+slovo)<sirkaplochy
      then begin
             showtext:=showtext+slovo;
             slovo:=' ';
             i:=i+1;
             space:=i;
           end
      else begin
             Cvs.TextOut(StartX,now_y,showtext);
             now_y:=now_y+char_y;
             showtext:='';
             slovo:='';
             i:=space;
           end;
  end;
  Cvs.TextOut(StartX,now_y,showtext);
  now_y:=now_y+char_y;
end;


end.
