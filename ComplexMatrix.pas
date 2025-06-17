unit ComplexMatrix;

interface

uses
  SysUtils, IntervalArithmetic32and64, Math;

type

  complex = record
    re: Extended;
    im: Extended;
  	end;

  icomplex = record
    re: interval;
    im: interval;
  end;

type
  cplxvector = array of complex;
  icplxvector = array of icomplex;
  // Macierz zespolona: n wierszy i n+1 kolumn
  cplxmatrix = array of array of complex;
  icplxmatrix = array of array of icomplex;
procedure pComplexMatrix(
  n: Integer;
  var a: cplxmatrix;  // wymiary: n x (n+1)
  var x: cplxvector;   // długość: n
  var st: Integer      // status: 0=prawidłowe,1=błędne n,2=osobliwa
);

procedure piComplexMatrix(
  n: Integer;
  var a: icplxmatrix;  // wymiary: n x (n+1)
  var x: icplxvector;   // długość: n
  var st: Integer      // status: 0=prawidłowe,1=błędne n,2=osobliwa
);

implementation

function interval_abs(const x: interval): interval;
begin
  if x.a >= 0 then begin
    Result.a := x.a;
    Result.b := x.b;
  end else if x.b <= 0 then begin
    Result.a := -x.b;
    Result.b := -x.a;
  end else begin
    Result.a := 0;
    if -x.a > x.b then
      Result.b := -x.a
    else
      Result.b := x.b;
  end;
end;

procedure pComplexMatrix(n: Integer;
                        var a: cplxmatrix;
                        var x: cplxvector;
                        var st: Integer);
var
  i, ih, j, k: Integer;
  d: Extended;
  aa, b, c: complex;
  alb: Boolean;
begin
  if n < 1 then
  begin
    st := 1;
    Exit;
  end;

  st:=0;
  k:=0;
  while (k < n) and (st = 0) do
  begin
    d:=0;
    ih:=k;
    for i:=k to n-1 do
    begin
      b.re := Abs(a[i][k].re) + Abs(a[i][k].im);
      if b.re > d then
      begin
        d := b.re;
        ih := i;
      end;
    end;
    if d = 0 then
    begin
      st := 2;
      Break;
    end;

    aa:=a[ih][k];
    alb:=Abs(aa.re)<Abs(aa.im);
    if alb then
    begin
      b.re := aa.re;
	  aa.re := aa.im;
	  aa.im := b.re;
    end;
    b.re:=aa.im/aa.re;
    aa.im:=1/(b.re*aa.im+aa.re);
    aa.re:=aa.im*b.re;
    if not alb then
    begin
      b.re:=aa.re;
	  aa.re:=aa.im;
	  aa.im:=b.re;
    end;

    a[ih][k] := a[k][k];

    for j:=k+1 to n do
    begin
      c := a[ih][j];
      if d<(Abs(c.re)+Abs(c.im))*1e-16 then
      begin
        st := 2;
        Break;
      end;
      a[ih][j]:=a[k][j];
      b.re:=c.im*aa.im+c.re*aa.re;
      b.im:=c.im*aa.re-c.re*aa.im;
      a[k][j]:=b;
      for i:=k+1 to n-1 do
      begin
        c:=a[i][k];
        a[i][j].re:=a[i][j].re-c.re*b.re+c.im*b.im;
        a[i][j].im:=a[i][j].im-c.re*b.im-c.im*b.re;
      end;
    end;

    Inc(k);
  end;

  if st=0 then
  begin
    x[n-1]:=a[n-1][n];
    for i:=n-2 downto 0 do
    begin
      aa := a[i][n];
      for j:=i+1 to n-1 do
      begin
        b:=a[j][n];
        c:=a[i][j];
        aa.re:=aa.re-c.re*b.re+c.im*b.im;
        aa.im:=aa.im-c.re*b.im-c.im*b.re;
      end;
      a[i][n] := aa;
      x[i] := aa;
    end;
  end;
end;

// =====================================================
// Procedura piComplexMatrix – wersja przedziałowa
// =====================================================
procedure piComplexMatrix(n: Integer;
                          var a: icplxmatrix;
                          var x: icplxvector;
                          var st: Integer);
var
  i, ih, j, k: Integer;
  d: interval;
  aa, b, c: icomplex;
  alb: Boolean;
begin
  if n<1 then
  begin
    st:=1;
    Exit;
  end;

  st:=0;
  k:=0;
  while (k<n) and (st=0) do
  begin

    // wybór pivotu
    d:=interval(0);
    ih:=k;
    for i:=k to n-1 do
    begin
      b.re:=interval_abs(a[i][k].re) + interval_abs(a[i][k].im);
      if b.re.a>d.b then
      begin
        d:=b.re;
        ih:=i;
      end;
    end;

    if (d.a<=0) and (d.b>=0) then
    begin
      st:=2;
      Break;
    end;

    // przygotowanie pivotu
    aa:=a[ih][k];

    alb:=Abs(aa.re.b)<Abs(aa.im.a);
    if alb then
    begin
      b.re:=aa.re.a;
      aa.re:=aa.im;
      aa.im:=interval(b.re);
    end;

    if (((aa.re.a<=0) and (aa.re.b>=0)) or ((aa.re.a<0) and (aa.re.b>0))) then
    begin
      st := 2;
      Break;
    end;

    b.re:=aa.im/aa.re;
    aa.im:=interval(1)/(b.re*aa.im+aa.re);
    aa.re:=aa.im*b.re;

    if not alb then
    begin
      b.re:=aa.re.a;
      aa.re:=aa.im;
      aa.im:=interval(b.re);
    end;

    //zamiana wierszy
    a[ih][k]:=a[k][k];
    a[k][k]:=aa;  //przyjmujemy, że pivot trafia na a[k][k]

    //eliminacja w dół
    for j:=k+1 to n do
    begin
      c:=a[ih][j];

      if d.b<((interval_abs(c.re)+interval_abs(c.im))*interval(1e-16)).a then
      begin
        st:=2;
        Break;
      end;

      a[ih][j]:=a[k][j];
      b.re:=c.im*aa.im+c.re*aa.re;
      b.im:=c.im*aa.re-c.re*aa.im;
      a[k][j]:=b;

      for i:=k+1 to n-1 do
      begin
        c:=a[i][k];
        a[i][j].re := a[i][j].re - c.re * b.re + c.im * b.im;
        a[i][j].im := a[i][j].im - c.re * b.im - c.im * b.re;
      end;
    end;

    Inc(k);
  end;

  if st=0 then
  begin
    x[n-1] := a[n-1][n];

    for i:=n-2 downto 0 do
    begin
      aa:=a[i][n];
      for j:=i+1 to n-1 do
      begin
        b:=a[j][n];
        c:=a[i][j];
        aa.re:=aa.re-c.re*b.re+c.im*b.im;
        aa.im:=aa.im-c.re*b.im-c.im*b.re;
      end;
      a[i][n]:=aa;
      x[i]:=aa;
    end;
  end;
end;

end.
