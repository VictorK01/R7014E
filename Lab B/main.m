clear

A = [0 0 1.1320 0 -1.0000;
    0 -0.0538 -0.1712 0 0.0705;
    0 0 0 1.0000 0;
    0 0.0485 0 -0.8556 -1.0130;
    0 -0.2909 0 1.0532 -0.6859];
B = [0 0 0;
    -0.1200 1.0000 0;
    0 0 0;
    4.4190 0 -1.6650;
    1.5750 0 -0.0732];
C = [1 0 0 0 0;
    0 1 0 0 0;
    0 0 1 0 0];
D = zeros(3);

x0 = [10000 100 0 0 0]';

states = {'Relative altitude (m)' 'Forward speed (m/s)' 'Pitch angle (deg)' 'Pitch rate (deg/s)' 'Vertical speed (m/s)'};
inputs = {'Spoiler angle (deg/10)' 'Forward acceleration (m/s^2)' 'Elevator angle (deg)'};
outputs = {'Relative altitude (m)' 'Forward speed (m/s)' 'Pitch angle (deg)'};

sys = ss(A,B,C,D,'statename',states,'inputname',inputs,'outputname',outputs)

G = tf(sys)
%%

syms s
figure(1)
Gsym = simplify(C*inv(s*eye(5)-A)*B+D);

w = logspace(-3, 2,100);
DRGA=(Gsym.*pinv(Gsym.'));
G0 = double(simplify(subs(Gsym.*pinv(Gsym.'),s,w)));
for i=1:3
    for j=1:3
        DRGA_x =double(simplify(subs(DRGA(i,j),s,w)));
        subplot(3,3,(i-1)*3 + j) 
        semilogx(w,DRGA_x)
    end
end

G1=G(1,1)
G2=G(2,3)
G3=G(3,2)

s = tf('s');

l = 10;

Q1 = 1/(l*s+1)^3*inv(G1);
Q2 = 1/(l*s+1)^3*inv(G2);
Q3 = 1/(l*s+1)^4*inv(G3);

K1 = minreal(Q1/(1-Q1*G1),1e-1);
K2 = minreal(Q2/(1-Q2*G2),1e-1);
K3 = minreal(Q3/(1-Q3*G3),1e-1);

[N1,D1] = tfdata(K1,'v');
[N2,D2] = tfdata(K2,'v');
[N3,D3] = tfdata(K3,'v');

D1n = 1/((s+(1.4234 + 0.0000i))*(s +0.6576 + 0.0000i)*(s+(0.1500 + 0.0866i))*(s+(0.1500 - 0.0866i))*(s+(0.0553 + 0.0000i)));
D2n = 1/(s*(s+31.5468)*(s+1.1230)*(s+0.15+0.0866i)*(s+0.15-0.0866i));
D3n = 1/(s*(s+6.7618)*(s+0.2)*(s+0.1+0.1i)*(s+0.1-0.1i));

[~,D1]=tfdata(D1n,'v');
[~,D2]=tfdata(D2n,'v');
[~,D3]=tfdata(D3n,'v');

D1 = real(D1);
D2 = real(D2);
D3 = real(D3);

% plot(G0)