# Program do rozwiązywania układu równań liniowych o współczynnikach zespolonych w arytmetyce przedziałowej

## Zastosowanie

Procedura `piComplexMatrix` rozwiązuje układ `n` równań liniowych dla zespolonych współczynników i wyrazów wolnych w arytmetyce przedziałowej.

Układ równań jest postaci

```math
\sum_{j=1}^{n} a_{ij}x_j = a_{i,n+1}, \qquad i = 1,2,\ldots,n
```

dla zespolonych współczynników w arytmetyce przedziałowej

```math
a_{ij} \quad (i = 1,2,\ldots,n,\ j = 1,2,\ldots,n+1).
```

## Opis metody

Układ równań jest rozwiązywany metodą eliminacji Gaussa-Jordana z pełnym wyborem elementu podstawowego.

## Wywołanie procedury

`piComplexMatrix (n, a, x, st)`

## Dane

n – liczba równań (liczba niewiadomych)

a – tablica rekordów zawierająca współczynniki i wyrazy wolne układu (każdy element a[i,j] składa się z części rzeczywistej a[i,j].re oraz części urojonej a[i,j].im współczynników; elementy a[i,n] powinny zawierać części rzeczywiste i urojone wyrazów wolnych; i=0,1,…,n-1; ,j=0,1,…,n; obie części każdego elementu to przedziały; elementy tablicy są zmieniane przy wyjściu).

## Wyniki

x – tablica rekordów zawierająca części rzeczywiste i urojone niewiadomych, obie części są przedziałami (rozwiązanie ma postać x[k].re + ix[k].im; k=0,1,…,n; i oznacza jednostkę urojoną).

## Inne parametry

st – zmienna której w ramach procedury `piComplexMatrix` przypisywana jest wartość:

- 1, jeśli n < 1,
- 2, jeśli macierz układu jest osobliwa lub prawie osobliwa,
- 0, w przeciwnym wypadku

Jeżeli $st \neq 0$, to elementy tablicy x nie są obliczane.

## Typy parametrów

`Integer : n, st`

`icplxmatrix: a`

`icplxvector: x`

## Identyfikatory nielokalne

`icomplex` – identyfikator typu rekordowego postaci

```text
record
    re,im : interval
end;
```

`icplxmatrix` – identyfikator typu postaci

```text
array of array of icomplex;
```

`icplxvector` – identyfikator typu postaci

```text
array of icomplex;
```

## Przykłady

### a) Układ równań

```math
(1 - i)x_1 + (2 + i)x_2 = 1
```

```math
2ix_1 + (1 - i)x_2 = 3 + i
```

### Dane

```text
n = 2

a[1,1].re = 1          a[1,1].im = -1
a[1,2].re = 2          a[1,2].im =  1
a[1,3].re = 1          a[1,3].im =  0
a[2,1].re = 0          a[2,1].im =  2
a[2,2].re = 1          a[2,2].im = -1
a[2,3].re = 3          a[2,3].im =  1
```

### Wyniki

```text
x[1].re = [ 6.9999999999999999E-0001,  7.0000000000000001E-0001], 
w = 1,0842021724855044E-0019

x[1].im = [-9.0000000000000001E-0001, -8.9999999999999999E-0001], 
w = 1,6263032587282567E-0019

x[2].re = [ 7.9999999999999999E-0001,  8.0000000000000001E-0001], 
w = 5,4210108624275222E-0020

x[2].im = [ 3.9999999999999999E-0001,  4.0000000000000001E-0001], 
w = 2,7105054312137611E-0020

st = 0
```

### b) Układ równań

```math
([1, 1.1] + i\cdot[0.9, 1])x_1 + ([1.9, 2] + i\cdot[1, 1.1])x_2 = [0.9, 1] + i\cdot[-0.1, 0.1]
```

```math
([0, 0.1] + i\cdot[1.9, 2])x_1 + ([0.9, 1] + i\cdot[-1.1, -1])x_2 = [2.9, 3] + i\cdot[0.9, 1]
```

### Dane

```text
n = 2

a[1,1].re = [1, 1.1]          a[1,1].im = [0.9, 1]
a[1,2].re = [1.9, 2]          a[1,2].im = [1, 1.1]
a[1,3].re = [0.9, 1]          a[1,3].im = [-0.1, 0.1]
a[2,1].re = [0, 0.1]          a[2,1].im = [1.9, 2]
a[2,2].re = [0.9, 1]          a[2,2].im = [-1.1, -1]
a[2,3].re = [2.9, 3]          a[2,3].im = [0.9, 1]
```

### Wyniki

```text
x[1].re = [-2.3454437491695701E-0002,  6.8381261251423643E-0001], 
w = 7,0726705000593212E-0001

x[1].im = [-1.5998514693104575E+0000, -8.4032659298003112E-0001], 
w = 7,5952487633042633E-0001

x[2].re = [-7.4143024406865307E-0002,  1.2424743936084826E-0001], 
w = 1,9839046376771356E-0001

x[2].im = [ 4.5189441021776767E-0001,  7.1512217931028560E-0001], 
w = 2,6322776909251792E-0001 

st = 0
```

### c) Układ równań

```math
0\cdot x_1 + 0\cdot x_2 = 1
```

```math
0\cdot x_1 + 0\cdot x_2 = 1
```

### Dane

```text
n = 2

a[1,1].re = 0          a[1,1].im = 0
a[1,2].re = 0          a[1,2].im = 0
a[1,3].re = 1          a[1,3].im = 0
a[2,1].re = 0          a[2,1].im = 0
a[2,2].re = 0          a[2,2].im = 0
a[2,3].re = 1          a[2,3].im = 0
```

### Wyniki

```text
x – nieobliczane
st = 2
```
