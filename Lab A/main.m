% Properties
A_a = 35;   % Tank cross section
a1 = 0.145;   % Upper outlet cross section
a2 = 0.155;     % Lower outlet cross section
g = 981;    % Gravity
h0 = 3.2;   % Additional height
h10 = 7.5;    % Linear operating point (cm)
u0 = 1;     % Operating point pump voltage

Ts = 0.05; % sample time
Np = 0.0001; % Noise power / Variance

% Pump voltage to flow conversion
fu = [0.5 1 1.5 2 2.5 3 3.5 5 8 10];
fq = [17.75 21.65 23.76 27.55 30.01 31.98 33.88 38.18 46.28 49.88];
n = 7.5;      % Linear pump gain at u0

% Water level to sensor voltage conversion
fh = [3 4 5 6 7 8 9 10 11 12 13 14 15];
fv = [0.909 1.685 2.475 3.255 4.055 4.804 5.573 6.332 7.121 7.847 8.617 9.405 10.18];

% Linearized State space model
A = [-a1*g/(A_a*sqrt(2*g*(h10+h0))) 0;
    a1*g/(A_a*sqrt(2*g*(h10+h0))) -a2*g/(A_a*sqrt(2*g*(h10+h0)))];
B = [n/A_a 0]';
C = [0 1];
D = 0;
sys = ss(A,B,C,D);

% Discrete state space
[Ad,Bd,Cd,Dd] = ssdata(c2d(sys, Ts));

% Kalman parameters
Q =  0.1*eye(2);
R = Np*eye(2);
N = eye(2);

x0 = [0 0]';
P0 = zeros(2);
