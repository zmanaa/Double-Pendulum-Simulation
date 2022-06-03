function [tout, yout] = RK_1_to_4(ode_function, tspan, y0, h, rank)
%
%  RK_1_to_4:  uses a selected Runge-Kutta scheme to integrate
%  a system of first-order differential equations x_dot = f(t,x).
%
%    INPUTS:
%
%      ode_function  - handle for function in which the derivatives
%                      are computed
%      tspan         - the vector [t0 t_final] giving the time interval for the
%                      solution
%      y0            - column vector of initial values of the vector y
%
%      h             - time step
%      rank            - time at the beginning of a time step

%    OUTPUTS:
%      tout          - column vector of times at which y was evaluated
%      yout          - a matrix, each row of which contains the components
%                      of y evaluated at the correponding time in tout
%

switch rank
    case 1
        rank_no = 1;
        a = 0;
        b = 0;
        c = 1;
    case 2
        rank_no = 2;
        a = [0 1];
        b = [0 1]';
        c = [1/2 1/2];
    case 3
        rank_no = 3;
        a = [0 1/2 1];
        b = [ 0  0 
             1/2 0
             -1  2];
        c = [1/6 2/3 1/6];
    case 4
        rank_no = 4;
        a = [0 1/2 1/2 1];
        b = [ 0   0   0
             1/2  0   0
              0  1/2  0
              0   0   1];
        c = [1/6 1/3 1/3 1/6];
    otherwise
         throw('The rank  should have a value between 1:4.')          
end

t0   = tspan(1);
t_final   = tspan(2);
t    = t0;
y    = y0;
tout = t;
yout = y';

while t < t_final
    ti = t;
    yi = y;

    for i = 1:rank_no
        t_inner = ti + a(i)*h;
        y_inner = yi;
        for j = 1:i-1
            y_inner = y_inner + h*b(i,j)*f(:,j);
        end
        f(:,i)  = feval(ode_function, t_inner, y_inner);
    end

    h    = min(h, t_final-t);
    t    = t + h;
    y    = yi + h*f*c';               
    tout = [tout;t];  
    yout = [yout;y'];
end

end
