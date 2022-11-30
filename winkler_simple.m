%% Winkler Diagram
% Script to plot the Winkler diagram for the matching of turbocharger and
% diesel engines
% Coded by Simon Blakey, August 2022
% Based on Winkler, G, Matching turbocharging and engine graphically,
% IMechE publication 1982

% Instructions:
% 1. Adjust the values of the parameters in the .m file to suit your application
% 2. Run the .m file and a version of the Winkler chart should be generated
% for you to use itteratively to match your system.

clear;

%% parameters
% Turbocharger efficiency parameter
K0 = 0.6;
% Engine load parameter
K1 = 4;
% Engine speed parameter
K2 = 0.007;
% Piston loading parameter
K3 = K1*K2;
% Turbine size parameter
K4 = 0.02;

%% constants
% ratio of specific heats
gamma = 1.35;
% input values to start calcs
up_variable = [1:0.1:5];
right_variable1 = [1:0.1:5];


%% calculation of lines
for i = 1:numel(up_variable)
    right_variable(i) = 1/(1-((up_variable(i)^((gamma-1)/gamma)-1)/(K0*(1+K1*(1/up_variable(i))))))^(gamma/(gamma-1));
end
left_variable = K2*up_variable;
left_axis = [0.000001:0.0001:left_variable(end)];
down_variable = left_axis.*sqrt(1+(K3./left_axis));
for i = 1:numel(right_variable1)
    phi(i) =sqrt((gamma/(gamma-1))*((1/right_variable1(i))^(2/gamma)-(1/right_variable1(i))^((gamma+1)/gamma)));
end
down_variable2 =K4*phi.*right_variable1.*(sqrt(2/gamma));
temp_variable = 1+K1*1./up_variable;

%% plot limits
uplim = [1 4];
rightlim = [1 4];
downlim = [0 0.04];
leftlim = [0 0.04];

%% plot values
tiledlayout(2,3,'TileSpacing','none');

% Tile 1 = Second quadrant
nexttile
plot(left_variable,up_variable,'b-')
set(gca, 'Xdir', 'reverse')
set(gca, 'YAxisLocation','Right')
set(gca, 'xticklabel',[])
set(gca, 'yticklabel',[])
set(gca,'XMinorTick','on','YMinorTick','on')
%yticks(up_variable)
grid on
xlim(leftlim)
ylim(uplim)
text(leftlim(1)+0.005,uplim(2)-0.5,'$\frac{p_C}{p_0}$','interpreter','latex','FontSize', 20)
text(leftlim(2)-0.01,uplim(2)-1,['$K_2 = $' num2str(K2)],'interpreter','latex','FontSize', 14)

% Tile 2 = First quadrant
nexttile
plot(right_variable,up_variable,'b-');
set(gca, 'xticklabel',[])
set(gca,'XMinorTick','on','YMinorTick','on')
grid on
xlim(rightlim)
ylim(uplim)
text(rightlim(2)-0.4,uplim(2)-0.5,'$\frac{p_C}{p_0}$','interpreter','latex','FontSize', 20)
text(0.5,uplim(2)+0.4,'Winkler Diagram','FontSize', 28)
text(2.4,2.5,['$K_0 = $' num2str(K0)],'interpreter','latex','FontSize', 14)
text(2.4,2.3,['$K_1 = $' num2str(K1)],'interpreter','latex','FontSize', 14)

% Tile 3 = temperature ratio
nexttile
plot(temp_variable,up_variable,'b-')
set(gca, 'Xdir', 'reverse')
set(gca, 'xticklabel',[])
set(gca,'XMinorTick','on','YMinorTick','on')
grid on
xlim([1.6 3.2])
ylim(uplim)
xRangeTemp = [1.6 1.8 2 2.2 2.4 2.6 2.8 3];
for c = 1:numel(xRangeTemp)
     text((xRangeTemp(c)),0.96,num2str(xRangeTemp(c)),'VerticalAlignment','top',...
     'HorizontalAlignment','center')
end
text(2,uplim(1)-0.4,'$\frac{T_T}{T_C}$','interpreter','latex','FontSize', 20)
text(2.4,2.3,['$K_1 = $' num2str(K1)],'interpreter','latex','FontSize', 14)

% Tile 4 = Third Quadrant
nexttile
plot(left_axis,down_variable,'b-')
set(gca, 'Xdir', 'reverse')
set(gca, 'Ydir', 'reverse')
set(gca, 'YAxisLocation','Right')
set(gca, 'yticklabel',[])
set(gca, 'xticklabel',[])
set(gca,'XMinorTick','on','YMinorTick','on')
grid on
xlim(leftlim)
ylim(downlim)
xRangeLeft = [0.005:0.01:leftlim(2)];
for c = 1:numel(xRangeLeft)
     text((xRangeLeft(c)),0.001,num2str(xRangeLeft(c)),'VerticalAlignment','top',...
     'HorizontalAlignment','center')
end
text(leftlim(2)-0.005,downlim(1)+0.006,'$\frac{\dot{m}_T}{A_p\rho_0c_0}$','interpreter','latex','FontSize', 20)
text(leftlim(2)-0.01,downlim(2)-0.02,['$K_3 = $' num2str(K3)],'interpreter','latex','FontSize', 14)

% Tile 5 = Fourth Quadrant
nexttile
plot(right_variable1(2:end),down_variable2(2:end),'-b')
set(gca, 'Ydir', 'reverse')
set(gca, 'xticklabel',[])
set(gca,'XMinorTick','on','YMinorTick','on')
grid on
xlim(rightlim)
ylim(downlim)
xRangeRight = [1.2:0.2:rightlim(2)];
for c = 1:numel(xRangeRight)
     text((xRangeRight(c)),0.001,num2str(xRangeRight(c)),'VerticalAlignment','top',...
     'HorizontalAlignment','center')
end
text(rightlim(1)+0.2,downlim(2)-0.01,'$\frac{\dot{m}_T}{A_T\rho_Tc_T}  \frac{p_T}{p_0} \sqrt{\frac{T_0}{T_C}}$','interpreter','latex','FontSize', 20)
text(rightlim(2)-0.4,downlim(1)+0.006,'$\frac{p_T}{p_0}$','interpreter','latex','FontSize', 20)
text(rightlim(2)-1,downlim(2)-0.02,['$K_4 = $' num2str(K4)],'interpreter','latex','FontSize', 14)
