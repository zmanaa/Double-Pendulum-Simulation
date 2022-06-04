function zprime = pendulum(t,z,m1,m2,L1,L2)
% pendulum: is the sub-routine to integrate the system EOM.

% z1        ---> represents theta 1
% z2        ---> represents theta 2
% z3        ---> represents theta_prime 1
% z4        ---> represents theta_prime 2

% zprime(1) ---> represents theta_prime 1
% zprime(2) ---> represents theta_prime 2
% zprime(3) ---> represents theta_double_prime 1
% zprime(4) ---> represents theta_double_prime 2

global m1 m2 L1 L2
g=9.81;



zprime=zeros(4,1);

zprime(1)=z(3);
zprime(2)=z(4);

zprime(3)=(-m2*L1*z(4)^2*sin(z(1)-z(2))*cos(z(1)-z(2))...
+g*m2*sin(z(2))*cos(z(1)-z(2))-m2*L2*z(4)^2*sin(z(1)-z(2))...
-(m1+m2)*g*sin(z(1)))/(L1*(m1+m2)-m2*L1*cos(z(1)-z(2))^2);

zprime(4)=(m2*L2*z(4)^2*sin(z(1)-z(2))*cos(z(1)-z(2))...
+g*sin(z(1))*cos(z(1)-z(2))*(m1+m2)+L1*z(4)^2*sin(z(1)-z(2))*(m1+m2)...
-g*sin(z(2))*(m1+m2))/(L2*(m1+m2)-m2*L2*cos(z(1)-z(2))^2);


end