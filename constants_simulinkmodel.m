%Constants for Simulink model

rho             =.0023081;                                                  %Air Density (Slugs per ft^3) - Checked
g               =32.17;                                                     %Gravity - Checked
m               =.487669;                                                   %Slugs - Empty Mass of A/C (w/o fuel)(7.117 Kg empty)
Iyy             =1.5523;                                                    %Inertias Experimentally determined using Empty Mass
Ixx             =1.9480;                                                    %Inertia Units are (slugs*ft^2) - Checked
Izz             =1.9166;                                                    % - Checked
Ixz             =0;                                                         %Assumed zero due to symmetric aircraft - Assumed
S               =10.56;                                                     %Square Feet - Wing Area Converted from
                                                                            %Manuf 1520 sq in area - Checked (also Matches DigDat)
CLow            =.421;                                                      %from Look up table for Eppler 193 at AoA=0,
                                                                            %DigDat = .421, Line # 277 - Checked CL column
CLaw            =4.59;                                                      %Coef of Lift for finite wing = Cla/(1+ (Cla/(pi*ARw*e)
                                                                            %DigDat = 4.59, Line #276-277, CLA column- Checked
CDminw          =.011;                                                      %DigDat Min Drag of Wing at AoA = -6 deg,
                                                                            %Dig Dat Line# 274- Checked
ARw             =7.9456;                                                    %Aspect Ratio AR = (b^2)/S- Checked
e               = .75;                                                      %Span efficiency factor -estimation- Checked
Cmw             =-0.005;                                                    %DigDat = AoA =0, Line #277- Checked
cgw             =-.416;                                                     %Distance Aero Center is back from CG, 5 Inches
c               =1.3333;                                                    %Feet - Root Chord of Wing (16")- Checked
b               =9.16;                                                      %Feet - Span (110")- Checked
lambda          =.72955;                                                    %Taper Ratio from S=(Cr*(1+Lambda)*b)/2- Checked
CLat            =.76;                                                       %Dig Dat, Line #346, CLA Column- Checked
CDmint          =.002;                                                      %Dig Dat, Line #345, at AoA = -2 deg
Kt              =.446;                                                      %=1/(pi*e*AR) =SET SAME AS WING OR DIGDAT From BLAKE
it              =0.034906585;                                               %Tail incidence 2 degrees
Te              =.422;                                                      %Blake from DigDat
nt              =1;                                                         %Blake from DigDat
St              =S;                                                         %Horiz Tail Area Square Feet=Reference Area = Wing Area
cgt             =3.5;                                                       %Distance tail Aero Center back from A/C CG,
                                                                            %42 inches - Measured
CLavt           =.0969;                                                     %Dig Dat Line #190
CDminvt         =.001;                                                      %Dig Dat Line #409, AOA = -10 deg, Column CD
Svt             =S;                                                         %Vert Tail Area Square Feet = Reference Area = Wing Area
Tr              =.434;                                                      %Blake from DigDat
nvt             =nt;                                                        %Same as Hori Tail
cgvt            =cgt;                                                       %Same as Hori tail
Cmaf            =.114;                                                      %Dig Dat, Line#209, at AoA = 0
CDf             =.005;                                                      %Dig Dat, Line#209, at AoA = 0
Cnda            = -0.0128;                                                  %per rad DigDat
Clda            = 0.244;                                                    %per rad DigDat

CDvt            =.001;
Clb             =-.1;
Clr             =.01;
