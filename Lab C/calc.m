clear all;clc
disp('−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−');
disp('The Nonlinear systems should be written in the following form');
disp('−−Feedback Linearization Controller for a class of Nonlinear systems−−');
disp(' State space equations x=f(x)+g(x)u');
disp('−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−');
%% Declare how many states and inputs
% The your system contains
% Inout the extra parameters
par=input('Parameters ','s');
eval(sprintf('syms %s',par));
parameters=sprintf('%s',par)
n=input('Number of states:=');
nin=input('Number of inputs:=');
x=sym(zeros(1,n));
u=sym(zeros(1,nin));
for j=1:n
    eval(sprintf('syms x%d',j))
    x(:,j)=sprintf('x%d',j);
end
for k=1:nin
    eval(sprintf('syms u%d',k));
    u(:,k)=sprintf('u%d',k);
end
%% Enter the functions from the keyboard
f=input('The vector f(x):=','s');
g=input('The vector g(x):=');
Hc=input('The output variables:=','s');
%% Represent all the functions f(x), g(x) and h(x) on a
%% symbolic format
fx=sym(f);
%g=sym(g);
Hc=sym(Hc); %
%% Use the inoutfeedbacklinearization.m programm to generate
%% the desired functions
disp(['The feedbacklinearization controller Uc:']);
disp(['inv(Lhg)*(−Lhf+u)'])
[Lhf Lhg]=in_out_feedback_linearization(fx,g,Hc,x)
