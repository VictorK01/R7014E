% Properties
A_a = 33;   % Tank cross section
a = 0.16;   % Outlet cross section
g = 981;
h0 = 3.2; 
h10 = 8;
Ts = 0.1;

% Pump voltage to flow conversion
fu = [0.5 1 1.5 2 2.5 3 3.5 5 8 10];
fq = [17.75 21.65 23.76 27.55 30.01 31.98 33.88 38.18 46.28 49.88];
n = 5.7;      % Linear pump gain

% Water level to sensor voltage conversion
fh = [3 4 5 6 7 8 9 10 11 12 13 14 15];
fv = [0.909 1.685 2.475 3.255 4.055 4.804 5.573 6.332 7.121 7.847 8.617 9.405 10.18];

% State space
A = [-a*g/(A_a*sqrt(2*g*(h10+h0))) 0;
    a*g/(A_a*sqrt(2*g*(h10+h0))) -a*g/(A_a*sqrt(2*g*(h10+h0)))];
B = [n/A_a 0]';
C = [0 1];
D = 0;
sys = ss(A,B,C,D);

% Discrete state space
[Ad,Bd,Cd,Dd] = ssdata(c2d(sys, Ts));