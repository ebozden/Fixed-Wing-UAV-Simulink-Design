function x_dot=EOMs(in)
% Forces and Moments, and Equations of Motion

% *** QUANTITY ****** UNITS *********************************************
% *** mass -> {slugs}
% *** length -> {ft}
% *** area -> {ft^2}
% *** velocity -> {ft/s}
% *** acceleration-> {ft/s^2}
% *** density -> {slugs/ft^3}
% *** force -> {lbf}
% *** moments -> {lbf-ft}
% *** angles -> {radians} (calculations)
% *** velocity -> {ft/s}
% *** ang. vel. -> {rad/s}
% *** ang. accel. -> {rad/s^2}
% ***********************************************************************
global maneuver alpha_dot
% maneuver is a parameter that sets version to sim (glide or turn)
%x_dot=zeros(12,1);
% extract inputs from input vector
T           = in(1);            % Thrust
de          = in(2);            % Elevator Deflection (down is +) {deg}
drt         = in(3);            % Rudder Deflection {deg}
da          = in(4);            % Aileron Deflection (deg)

% extract states from input vector
V           = in(5);            % Velocity {ft/s}
gamma       = in(6);            % Flight path angle {rad}
alpha       = in(7);            % Angle of attack {rad}
q           = in(8);            % Pitch Rate {rad/s}
p           = in(9);            % Roll Rate {rad/s}
mu          = in(10);           % Bank Angle (About Velocity Vector) {rad}
beta        = in(11);           % Sideslip Angle {rad}
r           = in(12);           % Yaw Rate {rad/s}
chi         = in(13);           % Heading angle {rads}
north       = in(14);           % North Position {ft}
east        = in(15);           % East Position {ft}
h           = in(16);           % Altitude {ft}
% extract simulation time{sec} from input(used to calculate windup thrust)
tm          = in(17);

% DEFINE ANY NEEDED TERMS THAT APPEAR IN THE E.O.M.'S
% Define and/or Calculate Necessary Constants
d2r         =pi/180;            %Convert Degrees to Rads -- Although it s already
                                %coded in Matlab (DEG2RAD) - Checked
r2d         =180/pi;            %Convert Rads to Degrees -- Although it s already
                                %coded in Matlab (RAD2DEG) - Checked
rho         =.0023081;          %Air Density (Slugs per ft^3) - Checked
g           =32.17;             %Gravity - Checked
m           =.487669;           %Slugs - Empty Mass of A/C (w/o fuel)(7.117 Kg empty)
Iyy         =1.5523;            %Inertias Experimentally determined using Empty Mass
Ixx         =1.9480;            %Inertia Units are (slugs*ft^2) - Checked
Izz         =1.9166;            % - Checked
Ixz         =0;                 %Assumed zero due to symmetric aircraft - Assumed
S           =10.56;             %Square Feet - Wing Area Converted from
                                %Manuf 1520 sq in area - Checked (also Matches DigDat)
CLow        =.421;              %from Look up table for Eppler 193 at AoA=0,
                                %DigDat = .421, Line # 277 - Checked CL column
CLaw        =4.59;              %Coef of Lift for finite wing = Cla/(1+ (Cla/(pi*ARw*e)
                                %DigDat = 4.59, Line #276-277, CLA column- Checked
CDminw      =.011;              %DigDat Min Drag of Wing at AoA = -6 deg,
                                %Dig Dat Line# 274- Checked
ARw         =7.9456;            %Aspect Ratio AR = (b^2)/S- Checked
e           = .75;              %Span efficiency factor -estimation- Checked
Kw          = 1/(pi*ARw*e);     % = 1/(pi*AR*e)- Checked
Cmw         =-0.005;            %DigDat = AoA =0, Line #277- Checked
cgw         =-.416;             %Distance Aero Center is back from CG, 5 Inches
c           =1.3333;            %Feet - Root Chord of Wing (16")- Checked
b           =9.16;              %Feet - Span (110")- Checked
lambda      =.72955;            %Taper Ratio from S=(Cr*(1+Lambda)*b)/2- Checked
CLat        =.76;               %Dig Dat, Line #346, CLA Column- Checked
CDmint      =.002;              %Dig Dat, Line #345, at AoA = -2 deg
Kt          =.446;              %=1/(pi*e*AR) =SET SAME AS WING OR DIGDAT From BLAKE
it          =2*d2r;             %Tail incidence 2 degrees
Te          =.422;              %Blake from DigDat
nt          =1;                 %Blake from DigDat
St          =S;                 %Horiz Tail Area Square Feet=Reference Area = Wing Area
cgt         =3.5;               %Distance tail Aero Center back from A/C CG,
                                %42 inches - Measured
CLavt       =.0969;             %Dig Dat Line #190
CDminvt     =.001;              %Dig Dat Line #409, AOA = -10 deg, Column CD
Svt         =S;                 %Vert Tail Area Square Feet = Reference Area = Wing Area
Tr          =.434;              %Blake from DigDat
nvt         =nt;                %Same as Hori Tail
cgvt        =cgt;               %Same as Hori tail
Cmaf        =.114;              %Dig Dat, Line#209, at AoA = 0
CDf         =.005;              %Dig Dat, Line#209, at AoA = 0
Cnda        = -0.0128;          %per rad DigDat
Clda        = 0.244;            %per rad DigDat

% Define/calculate any needed coefficients, forces, etc.
CLw         =CLow+CLaw*alpha;
CDw         =CDminw+Kw*CLw^2;
E           =2*(CLow+CLaw*(alpha-alpha_dot*(cgt+cgw)/V))/(pi*ARw);
alphat      =alpha+it+Te*de+q*cgt/V-E;
CLt         =CLat*alphat;
CDt         =CDmint+Kt*CLt^2;
Cmf         =Cmaf*alpha;
CDvt        =CDminvt;
Clp         =-1/12*CLaw*(1+3*lambda)/(1+lambda);
Clb         =-.1;
Clr         =.01;
qb          =.5*rho*V^2;
Lw          =qb*S*CLw;
Dw          =qb*S*CDw;
Mw          =qb*S*c*Cmw;
Lt          =nt*qb*St*CLt;
Dt          =nt*qb*St*CDt;
Df          =qb*S*CDf;
Mf          =qb*S*c*Cmf;
Dvt         =nt*qb*Svt*CDvt;

% Calculate Forces and Moments
% Lift
L           =Lw+Lt*cos(E-q*cgt/V)-(Dt+Dvt)*sin(E-q*cgt/V);
% Drag
D           =Dw+(Dt+Dvt)*cos(E-q*cgt/V)+Lt*sin(E-q*cgt/V)+Df;
% Side Force
Y           =nvt*qb*Svt*CLavt*(-beta+Tr*drt+r*cgvt/V);
% Pitch Moment
Mc          =Lw*cgw*cos(alpha)+Dw*cgw*sin(alpha)+Mw-Lt*cgt*...
    cos(alpha-E+q*cgt/V)-(Dt+Dvt)*cgt*sin(alpha-E+q*cgt/V)+Mf;
% Yaw Moment
Nc          =-qb*nvt*Svt*CLavt*(-beta+Tr*drt+r*cgvt/V)*cgvt+(-qb*S*b*Cnda*da);
% Roll Moment
Lc          =qb*S*b^2/(2*V)*(Clp*p+2*V/b*Clb*beta+Clr*drt+Clda*da*2*V/b);

% -=-=-=-=-=- NONLINEAR 6-DOF EQUATION OF MOTION (EOMs) -=-=-=-=-=-=-=-=-
%
% These are the state derivative equations; the comment names the state,
% but the equation is for its derivative (rate)
%
% The equations are arranged by aircraft mode
%
% NOTE: These assume that Ixz=0, if not, then eq's need to be modified
% Longitudinal (phugoid and short period): V, gamma, q, alpha
% Phugoid: V, gamma
% Velocity
x_dot       =1/m*(-D*cos(beta)+Y*sin(beta)+T*cos(beta)*cos(alpha))-...
    g*sin(gamma);
% Flight Path Angle
gamma_dot   =1/(m*V)*(-D*sin(beta)*sin(mu)-Y*sin(mu)*cos(beta)...
    +L*cos(mu)+T*(cos(mu)*sin(alpha)+sin(mu)*sin(beta)*cos(alpha)))...
    -g/V*cos(gamma);
% Short Period: alpha, q
% Angle of Attach
alpha_dot   =q-tan(beta)*(p*cos(alpha)+r*sin(alpha))-1/(m*V*cos(beta))...
    *(L+T*sin(alpha))+g*cos(gamma)*cos(mu)/(V*cos(beta));
% Pitch Rate
q_dot       =Mc/Iyy+1/Iyy*(Izz*p*r-Ixx*r*p);
% Lateral (roll) - Directional (yaw): p, mu, beta, r
% Roll: p, mu
% Roll Rate 
p_dot       =Lc/Ixx+1/Ixx*(Iyy*r*q-Izz*q*r);
% Bank Angle (about velocity vector)
mu_dot      =1/cos(beta)*(p*cos(alpha)+r*sin(alpha))+1/(m*V)*(D*sin(beta)...
    *cos(mu)*tan(gamma)+Y*tan(gamma)*cos(mu)*cos(beta)+L*(tan(beta)+...
    tan(gamma)*sin(mu))+T*(sin(alpha)*tan(gamma)*sin(mu)+sin(alpha)*...
    tan(beta)-cos(alpha)*tan(gamma)*cos(mu)*sin(beta)))-...
    g/V*cos(gamma)*cos(mu)*tan(beta);
% Dutch Roll: beta, r
% Side Slip Angle
beta_dot    =-r*cos(alpha)+p*sin(alpha)+1/(m*V)*(D*sin(beta)+Y*cos...
    (beta)-T*sin(beta)*cos(alpha))+g/V*cos(gamma)*sin(mu);
% Yaw Rate
r_dot       =Nc/Izz+1/Izz*(Ixx*p*q-Iyy*p*q);
% Heading Angle (from North)
chi_dot     =1/(m*V*cos(gamma))*(D*sin(beta)*cos(mu)+Y*cos(mu)*cos(beta)...
    +L*sin(mu)+T*(sin(mu)*sin(alpha)-cos(mu)*sin(beta)*cos(alpha)));

% Kinematic Equations
% North Position
n_dot       =V*cos(gamma)*cos(chi);
% East Position
e_dot       =V*cos(gamma)*sin(chi);
% Altitude
h_dot       =V*sin(gamma);
% Pack derivatives into output vector x_dot
x_dot(1)    = V_dot;
x_dot(2)    = gamma_dot;
x_dot(3)    = alpha_dot;
x_dot(4)    = q_dot;
x_dot(5)    = p_dot;
x_dot(6)    = mu_dot;
x_dot(7)    = beta_dot;
x_dot(8)    = r_dot;
x_dot(9)    = chi_dot;
x_dot(10)   = n_dot;
x_dot(11)   = e_dot;
x_dot(12)   = h_dot;
end