classdef Pendulum < handle
    
%%% MEMBERS
    properties
       m1
       m2
       l1
       l2
        g
        
        initialStates   % [theta10 theta20 theta1_dot0 theta2_dot0]
        states          % [theta1 theta2 theta1_dot theta2_dot]
        
        RANK
        t0
        dt
        END_TIME
        timeFrame 
        
        
        theta_1
        theta_2
        theta_1_dot
        theta_2_dot
    end
    
    
%%% METHODS

     methods
         %%% CONSTRUCTOR
         function obj = Pendulum(params, initialStates, tf,h, rank)
             obj.g              = 9.8;
             obj.t0             = 0;
             obj.END_TIME       = tf;
             obj.dt             = h;
             obj.timeFrame      = 0:h:tf;
             obj.m1             = params('m1');
             obj.m2             = params('m2');
             obj.l1             = params('l1');
             obj.l2             = params('l2');
             
             obj.initialStates  = initialStates;
             obj.states         = zeros(1,length(initialStates));
 
             obj.RANK           = rank;
             
             obj.theta_1        = initialStates(1);
             obj.theta_2        = initialStates(2);
             obj.theta_1_dot    = initialStates(3);
             obj.theta_2_dot    = initialStates(4);
         end
         
         
         %%% ACCESS DATA
         function state = getStates(obj)
             state = obj.states;
         end
         
         function initState = getInitStates(obj)
             initState = obj.initialStates;
         end
         
         function h = getH(obj)
             h = obj.dt;
         end
         
         function L1 = getL1(obj)
             L1 = obj.l1;
         end
         
         function mass1 = getm1(obj)
             mass1 = obj.m1;
         end
         
         function mass2 = getm2(obj)
             mass2 = obj.m2;
         end
         
         function L2 = getL2(obj)
             L2 = obj.l2;
         end

         function rank = getRank(obj)
             rank = obj.RANK;
         end
         
         function endTime = getEndTime(obj)
             endTime = obj.END_TIME;
         end
         %%% SOLVE EQ. OF MOTION
         
         function obj = solve(obj)
             
             initStates     = obj.getInitStates();
             h              = obj.getH();
             rank           = obj.getRank();
             endTime        = getEndTime(obj);
             global m1 m2 L1 L2
             m1             = obj.getm1();
             m2             = obj.getm2();
             L1             = obj.getL1();
             L2             = obj.getL2();
             [TOUT, YOUT]   = RK_1_to_4(@system, [0 endTime], ...
                 initStates', h, rank);
             
             obj.states     = YOUT;
             obj.timeFrame  = TOUT;
         end
         
         function [theta1, theta2, dtheta1, dtheta2, tFrame] = organizeStates(obj)
             theta1         =  obj.states(:,1);
             theta2         =  obj.states(:,2);
             dtheta1        =  obj.states(:,3);
             dtheta2        =  obj.states(:,4);
             tFrame         =  obj.timeFrame;
         end
         
         function [x1, x2, y1, y2] = createPhasePlane(obj)
             L1 = obj.getL1();
             L2 = obj.getL2();
             [theta1, theta2, ~, ~, ~] = obj.organizeStates();
             x1 = L1*sin(theta1);
             y1 = -L1*cos(theta1);
             x2 = L1*sin(theta1)+L2*sin(theta2);
             y2 = -L1*cos(theta1)-L2*cos(theta2);
         end
         
     end
    
end
