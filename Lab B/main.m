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
inputs = {'Spoiler angle (deg/10)' 'Forward acceleration (m/s2)' 'Elevator angle (deg)'};
outputs = {'Relative altitude (m)' 'Forward speed (m/s)' 'Pitch angle (deg)'};

sys = ss(A,B,C,D,'statename',states,'inputname',inputs,'outputname',outputs)

G = tf(sys)