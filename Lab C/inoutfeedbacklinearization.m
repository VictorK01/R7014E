function [Lhf Lhg]=inoutfeedbacklinearization(fx,g,h,x)
% The function inoutfeedbacklinearization is used to find the
% the feedbacklinearization control law for SISO and MIMO
% nonlinear systems using symbolic MATLAB library;
% The user should provide the program with the following
% inputs
% fx : The system function f(x)
% g : The system output function g(x)
% h(x) : The vector of outputs h(x)=[x1;x2, ;xn]
% x : The state vector x=[x1,x2, ,xn]
% After having provided the program the necessary input
% functions
% The program will output the following variables
% Lhf : The lie derivative of h(x) along the function f(x)
% Lhg : The lie derivative of h(x) along the function g(x)
% which is called the decoupling matrix
% u : The vector of inputs u=[u1;u2;...;un]
% The control law will be given by the following formula
% u= inv(Lhg)*(−Lhg+v)
if nargin <4
    error('Not enough input argument');
end
k=1;
Lhg=[];Lhf=[];
nb=length(h);
while k<length(h)+1
    h1=h(k);
    for i=1:nb+1
        % this Lie derivative function
        df=Lie_Derivative(h1,x);
        % solve for the g
        [lhf lhg]=solve_lie_der(df,fx,g);
        [n b]=size(lhg);
        for ii=1:n
            d=any(lhg(ii,:)˜=0);
        end
        if d==1;
            disp(['The relative degree of h',num2str(k)]),
            disp(['equal:=',num2str(i)]);
            break;
        else
            h1=lhf;
        end
        if i==nb+1 && d==0
            disp(['The system dose not admit NFL']);
            return;
        end
    end
    Lhg=[Lhg;lhg];
    Lhf=[Lhf;lhf];
    k=k+1;
end
    function df=LieDerivative(H,x)
        % The LieDerivative MATLAB function is used
        % to find the jacobian vector of a given output
        % H(x) : Is the output function
        % x : The state vector
        % df : The jacobian of h along x
        if nargin<2 & nargin==0
            error('not enough input argument');
        end
        df=[];
        n=length(x);
        for ii=1:n
            xx=x(ii);
            dff=diff(H,xx);
            df=[df,dff];
        end
        df;
    end
    function [lhf lhg]=solvelieder(LH,fx,G)
        % The solvelieder MATLAB function is used to find
        % the lie derivatives of the functions f(x) and g(x)
        % along the vector field h(x)
        % LH : The jacobian vector of h along x
        % fx : The function f(x)
        % g : The input function g(x)
        LHg=[];
        lhf=LH*fx;
        [n,b]=size(G);
        for ii=1:b
            Lgh=LH*G(:,ii);
            LHg=[LHg,Lgh];
        end
        lhg=LHg;
    end
end