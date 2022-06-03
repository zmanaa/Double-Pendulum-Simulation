close all;
clc; clear;

addpath('./lib');

%% DEFS.
R2D = 180/pi;
D2R = pi/180;

%% INIT. PARAMS.
pendulum1_params     = containers.Map({'m1','m2','l1','l2'},...
    {1,2,1.5,1});

pendulum1_initStates = [pi/4, ...   % theta_1
    pi/6,...                        % theta_2
    0,...                           % theta1_dot
    0];                             % theta2_dot

simulationTime      = 10;

h                   = 0.06;
rank                = 4;
%% BIRTH OF PENDULUM ONE

pend1 = Pendulum(pendulum1_params, pendulum1_initStates, simulationTime, h,rank);
pend1.solve();

[theta1, theta2, dtheta1, dtheta2, t] = pend1.organizeStates();
[x1, x2, y1, y2] = pend1.createPhasePlane();

%% BIRTH OF PENDULUM TWO

pend2 = Pendulum(pendulum1_params, pendulum1_initStates+0.01, simulationTime, h,rank);
pend2.solve();

[theta1_2, theta2_2, dtheta1_2, dtheta2_2, t_2] = pend2.organizeStates();
[x1_2, x2_2, y1_2, y2_2] = pend2.createPhasePlane();

%% BIRTH OF PENDULUM THREE

pend3 = Pendulum(pendulum1_params, pendulum1_initStates+0.02, simulationTime, h,rank);
pend3.solve();

[theta1_3, theta2_3, dtheta1_3, dtheta2_3, t_3] = pend3.organizeStates();
[x1_3, x2_3, y1_3, y2_3] = pend3.createPhasePlane();

%% INIT. PLOT
fig1 = figure('pos',[0 200 800 800],'color','w');
h = gca;
axis equal;
grid on;

xlabel('$x$ [$m$]','Interpreter','latex','FontSize',14);
ylabel('$y$ [$m$]','Interpreter','latex','FontSize',14);
hold(h, 'on');
axis([-(pendulum1_params('l1')+pendulum1_params('l2'))...
    (pendulum1_params('l1')+pendulum1_params('l2'))...
    -(pendulum1_params('l1')+pendulum1_params('l2'))...
    (pendulum1_params('l1')+pendulum1_params('l2'))]);

fig1_MASS1 = plot(h, x1(1),y1(1),'ko','MarkerSize',pendulum1_params('m1')*5,...
    'MarkerFaceColor','k');
fig1_MASS2 = plot(h, x2(1),y2(1),'ko','MarkerSize',pendulum1_params('m2')*5,...
    'MarkerFaceColor','k');
fig1_L1 = plot(h, [0 x1(1)],[0 y1(1)],'k-');
fig1_L2 = plot(h, [x1(1) x2(1)],...
    [y1(1) y2(1)],'k-');

fig1_MASS1_2 = plot(h, x1_2(1),y1_2(1),'ro','MarkerSize',pendulum1_params('m1')*5,...
    'MarkerFaceColor','r');
fig1_MASS2_2 = plot(h, x2_2(1),y2_2(1),'ro','MarkerSize',pendulum1_params('m2')*5,...
    'MarkerFaceColor','r');
fig1_L1_2 = plot(h, [0 x1_2(1)],[0 y1_2(1)],'r-');
fig1_L2_2 = plot(h, [x1_2(1) x2_2(1)],...
    [y1_2(1) y2_2(1)],'r-');

fig1_MASS1_3 = plot(h, x1_3(1),y1_3(1),'bo','MarkerSize',pendulum1_params('m1')*5,...
    'MarkerFaceColor','b');
fig1_MASS2_3 = plot(h, x2_3(1),y2_3(1),'bo','MarkerSize',pendulum1_params('m2')*5,...
    'MarkerFaceColor','b');
fig1_L1_3 = plot(h, [0 x1_3(1)],[0 y1_3(1)],'b-');
fig1_L2_3 = plot(h, [x1_3(1) x2_3(1)],...
    [y1_2(1) y2_2(1)],'b-');

%% INIT. DATA FIGURE

fig2 = figure('pos',[900 400 800 600],'color','w');
subplot(2,2,1);
title('theta_1 [rad]')
xlabel('time')
grid on;
hold on;
subplot(2,2,2);
title('theta_2 [rad]')
xlabel('time')
grid on;
hold on;
subplot(2,2,3);
title('theta_1 dot [rad/sec]')
xlabel('time')
grid on;
hold on;
subplot(2,2,4);
title('theta_2 dot [rad/sec]')
xlabel('time')
grid on;
hold on;

%% PROPAGATE THE DATA

for idx = 1:length(x1)
    set(fig1_MASS1, ...
        'XData', x1(idx), ...
        'YData', y1(idx));
 
    set(fig1_L1,...
        'XData', [0 x1(idx)],...
        'YData', [0 y1(idx)]);
    set(fig1_MASS2,...
        'XData', x2(idx),...
        'YData', y2(idx));
    set(fig1_L2,...
        'XData', [x1(idx) x2(idx)],...
        'YData', [y1(idx) y2(idx)]);
        
    %%% PENDULUM TWO 
    set(fig1_MASS1_2, ...
        'XData', x1_2(idx), ...
        'YData', y1_2(idx));
 
    set(fig1_L1_2,...
        'XData', [0 x1_2(idx)],...
        'YData', [0 y1_2(idx)]);
    set(fig1_MASS2_2,...
        'XData', x2_2(idx),...
        'YData', y2_2(idx));
    set(fig1_L2_2,...
        'XData', [x1_2(idx) x2_2(idx)],...
        'YData', [y1_2(idx) y2_2(idx)]);
    
    %%% PENDULUM THREE 
    set(fig1_MASS1_3, ...
        'XData', x1_3(idx), ...
        'YData', y1_3(idx));
 
    set(fig1_L1_3,...
        'XData', [0 x1_3(idx)],...
        'YData', [0 y1_3(idx)]);
    set(fig1_MASS2_3,...
        'XData', x2_3(idx),...
        'YData', y2_3(idx));
    set(fig1_L2_3,...
        'XData', [x1_3(idx) x2_3(idx)],...
        'YData', [y1_3(idx) y2_3(idx)]);
    
    figure(2)
    subplot(2,2,1); plot(t(idx), theta1(idx),  'k.');
    subplot(2,2,2); plot(t(idx), theta2(idx),  'k.');
    subplot(2,2,3); plot(t(idx), dtheta1(idx), 'k.');
    subplot(2,2,4); plot(t(idx), dtheta2(idx), 'k.');
    
    subplot(2,2,1); plot(t_2(idx), theta1_2(idx),  'r.');
    subplot(2,2,2); plot(t_2(idx), theta2_2(idx),  'r.');
    subplot(2,2,3); plot(t_2(idx), dtheta1_2(idx), 'r.');
    subplot(2,2,4); plot(t_2(idx), dtheta2_2(idx), 'r.');
    
    subplot(2,2,1); plot(t_3(idx), theta1_3(idx),  'b.');
    subplot(2,2,2); plot(t_3(idx), theta2_3(idx),  'b.');
    subplot(2,2,3); plot(t_3(idx), dtheta1_3(idx), 'b.');
    subplot(2,2,4); plot(t_3(idx), dtheta2_3(idx), 'b.');
    
    drawnow;
    
    fprintf('Timer = %d \n', t(idx));
end
