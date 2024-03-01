clear

% Aircraft model
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

x0 = [1000 100 0 0 0]';

k1 = 1;
tau1 = ureal('tau1',0.85,'range',[0.5 1.2]);
k2 = ureal('k2',1,'range',[0.9 1.1]);
tau2 = ureal('tau2',1.5,'range',[0.5 2.5]);
zeta = ureal('zeta', 0.95, 'range', [0.9 1]);
k3 = 1;
tau3 = ureal('tau3', 1.4, 'range', [1 1.8]);

states = {'Relative altitude (m)' 'Forward speed (m/s)' 'Pitch angle (deg)' 'Pitch rate (deg/s)' 'Vertical speed (m/s)'};
inputs = {'Spoiler angle (deg/10)' 'Forward acceleration (m/s2)' 'Elevator angle (deg)'};
outputs = {'Relative altitude (m)' 'Forward speed (m/s)' 'Pitch angle (deg)'};

sys = ss(A,B,C,D,'statename',states,'inputname',inputs,'outputname',outputs);

G = tf(sys);

Gu1 = tf(k1,[tau1 1]);
Gu2 = tf(k2,[tau2^2 2*zeta*tau2 1]);
Gu3 = tf(k3,[tau3 1]);

G1 = [Gu1 0 0;
      0 Gu2 0;
      0 0 Gu3];



A_aug = [A zeros(5,3);
        -C zeros(3)];
B_aug = [B;
        zeros(3)];
C_aug = [C zeros(3)];
D_aug = D;

G_aug = tf(ss(A_aug,B_aug,C_aug,D_aug))

Gu = G_aug*G1

P = [-0.5, -0.6, -0.7, -0.8, -0.9, -1.0, -1.1, -1.2];
K_aug = place(A_aug, B_aug, P)


