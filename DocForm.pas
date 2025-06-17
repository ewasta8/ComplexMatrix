unit DocForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TDocForm = class(TForm)
    MemoDoc: TMemo;
    procedure FormCreate(Sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TDocForm.FormCreate(Sender: TObject);
begin
  MemoDoc.Lines.Text :=
    'Program do rozwiązywania układu równań liniowych o współczynnikach zespolonych w arytmetyce przedziałowej' + sLineBreak + sLineBreak +

    '1. Zastosowanie' + sLineBreak +
    'Procedura piComplexMatrix rozwiązuje układ n równań liniowych dla zespolonych współczynników i wyrazów wolnych w arytmetyce przedziałowej.' + sLineBreak + sLineBreak +

    '2. Opis metody' + sLineBreak +
    'Układ równań jest rozwiązywany metodą eliminacji Gaussa-Jordana z pełnym wyborem elementu podstawowego.' + sLineBreak + sLineBreak +

    '3. Wywołanie procedury' + sLineBreak +
    'piComplexMatrix (n, a, x, st)' + sLineBreak + sLineBreak +

    '4. Dane' + sLineBreak +
    'n – liczba równań (liczba niewiadomych)' + sLineBreak +
    'a – tablica rekordów zawierająca współczynniki i wyrazy wolne układu (każdy element a[i,j] składa się z części rzeczywistej a[i,j].re oraz części urojonej a[i,j].im współczynników; elementy a[i,n] powinny zawierać części rzeczywiste i urojone wyrazów wolnych; i=0,1,…,n-1; j=0,1,…,n; obie części każdego elementu to przedziały; elementy tablicy są zmieniane przy wyjściu).' + sLineBreak + sLineBreak +

    '5. Wyniki' + sLineBreak +
    'x – tablica rekordów zawierająca części rzeczywiste i urojone niewiadomych, obie części są przedziałami (rozwiązanie ma postać x[k].re + ix[k].im; k=0,1,…,n; i oznacza jednostkę urojoną).' + sLineBreak + sLineBreak +

    '6. Inne parametry' + sLineBreak +
    'st – zmienna której w ramach procedury piComplexMatrix przypisywana jest wartość:' + sLineBreak +
    '    1, jeśli n < 1,' + sLineBreak +
    '    2, jeśli macierz układu jest osobliwa lub prawie osobliwa,' + sLineBreak +
    '    0, w przeciwnym wypadku' + sLineBreak +
    'Jeżeli st≠0, to elementy tablicy x nie są obliczane.' + sLineBreak + sLineBreak +

    '7. Typy parametrów' + sLineBreak +
    'Integer : n, st' + sLineBreak +
    'icplxmatrix: a' + sLineBreak +
    'icplxvector: x' + sLineBreak + sLineBreak +

    '8. Identyfikatory nielokalne' + sLineBreak +
    'icomplex – identyfikator typu rekordowego postaci:' + sLineBreak +
    '' + sLineBreak +
    '        record' + sLineBreak +
    '            re, im : interval;' + sLineBreak +
    '        end;' + sLineBreak +
    '' + sLineBreak +
    'icplxmatrix – identyfikator typu postaci:' + sLineBreak +
    '        array array of icomplex;' + sLineBreak +
    '' + sLineBreak +
    'icplxvector – identyfikator typu postaci:' + sLineBreak +
    '        array of icomplex;' + sLineBreak + sLineBreak +

    '9. Przykłady' + sLineBreak + sLineBreak +

    'Układ równań:' + sLineBreak +
    '(1 - i)x₁ + (2+ i)x₂ = 1' + sLineBreak +
    '2ix₁ + (1- i)x₂ = 3 + i' + sLineBreak + sLineBreak +

    'Dane:' + sLineBreak +
    'n = 2' + sLineBreak +
    'a[1,1].re = 1          a[1,1].im = -1' + sLineBreak +
    'a[1,2].re = 2          a[1,2].im =  1' + sLineBreak +
    'a[1,3].re = 1          a[1,3].im =  0' + sLineBreak +
    'a[2,1].re = 0          a[2,1].im =  2' + sLineBreak +
    'a[2,2].re = 1          a[2,2].im = -1' + sLineBreak +
    'a[2,3].re = 3          a[2,3].im =  1' + sLineBreak + sLineBreak +

    'Wyniki:' + sLineBreak +
    'x[1].re = [6.9999999999999999E-0001,  7.0000000000000001E-0001],' + sLineBreak +
    'w = 1,0842021724855044E-0019' + sLineBreak +
    'x[1].im = [-9.0000000000000001E-0001, -8.9999999999999999E-0001],' + sLineBreak +
    'w = 1,6263032587282567E-0019' + sLineBreak +
    'x[2].re = [7.9999999999999999E-0001,  8.0000000000000001E-0001],' + sLineBreak +
    'w = 5,4210108624275222E-0020' + sLineBreak +
    'x[2].im = [3.9999999999999999E-0001,  4.0000000000000001E-0001],' + sLineBreak +
    'w = 2,7105054312137611E-0020'  + sLineBreak +

    'st = 0' + sLineBreak + sLineBreak +

    'Układ równań:' + sLineBreak +
    '([1, 1.1] + i·[0.9, 1])x₁ + ([1.9, 2] + i·[1, 1.1])x₂ = [0.9, 1] + i·[-0.1, 0.1]' + sLineBreak +
    '([0, 0.1] + i·[1.9, 2])x₁ + ([0.9, 1] + i·[-1.1, -1])x₂ = [2.9, 3] + i·[0.9, 1]' + sLineBreak + sLineBreak +

    'Dane:' + sLineBreak +
    'n = 2' + sLineBreak +
    'a[1,1].re = [1, 1.1]          a[1,1].im = [0.9, 1]' + sLineBreak +
    'a[1,2].re = [1.9, 2]          a[1,2].im = [1, 1.1]' + sLineBreak +
    'a[1,3].re = [0.9, 1]          a[1,3].im = [-0.1, 0.1]' + sLineBreak +
    'a[2,1].re = [0, 0.1]          a[2,1].im = [1.9, 2]' + sLineBreak +
    'a[2,2].re = [0.9, 1]          a[2,2].im = [-1.1, -1]' + sLineBreak +
    'a[2,3].re = [2.9, 3]          a[2,3].im = [0.9, 1]' + sLineBreak + sLineBreak +

    'Wyniki:' + sLineBreak +
    'x[1].re = [-2.3454437491695701E-0002,  6.8381261251423643E-0001],' + sLineBreak +
    'w = 7,0726705000593212E-0001' + sLineBreak +
    'x[1].im = [-1.5998514693104575E+0000, -8.4032659298003112E-0001],' + sLineBreak +
    'w = 7,5952487633042633E-0001' + sLineBreak +
    'x[2].re = [-7.4143024406865307E-0002,  1.2424743936084826E-0001],' + sLineBreak +
    'w = 1,9839046376771356E-0001' + sLineBreak +
    'x[2].im = [ 4.5189441021776767E-0001,  7.1512217931028560E-0001],' + sLineBreak +
    'w = 2,6322776909251792E-0001' + sLineBreak +

    'st = 0' + sLineBreak + sLineBreak +

    'Układ równań:' + sLineBreak +
    '0·x₁ + 0·x₂ = 1' + sLineBreak +
    '0·x₁ + 0·x₂ = 1' + sLineBreak + sLineBreak +

    'Dane:' + sLineBreak +
    'n = 2' + sLineBreak +
    'a[1,1].re = 0          a[1,1].im = 0' + sLineBreak +
    'a[1,2].re = 0          a[1,2].im = 0' + sLineBreak +
    'a[1,3].re = 1          a[1,3].im = 0' + sLineBreak +
    'a[2,1].re = 0          a[2,1].im = 0' + sLineBreak +
    'a[2,2].re = 0          a[2,2].im = 0' + sLineBreak +
    'a[2,3].re = 1          a[2,3].im = 0' + sLineBreak + sLineBreak +

    'Wyniki:' + sLineBreak +
    'x – nieobliczane' + sLineBreak +
    'st = 2';
end;

end.

