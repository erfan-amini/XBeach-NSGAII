%------------------------------------------------------------------------
% Regression model generated by GeneXproTools 5.0 on 2/27/2024 3:54:07 PM
% GEP File: H:\My Drive\AAA_PhD_Research\06___2023___Vegetation Optimization\Data_and_Model\Veg_Opt_Robustness.gep
% Training Records:  6400
% Validation Records:   6400
% Fitness Function:  Quantile RRSE
% Training Fitness:  778.571778026533
% Training R-square: 0.889790957466006
% Validation Fitness:   772.745307317841
% Validation R-square:  0.890703563542598
%------------------------------------------------------------------------

% x(1): Hsw
% x(2): Av
% x(3): Nv

function result = FFF_GEP_Robustness(wave_power,x)

G2C4 = -12.9376578480683;
G3C6 = -6.07975824335608;
G3C7 = -4.5363811595763;

y = (reallog(x(1))/gep3Rt((x(1)*(x(1)^3))));
y = y + exp(((((G2C4-wave_power)/x(2))+reallog(x(3)))-(1.0/(x(1)))));
y = y + ((x(1)*((G3C6*x(1))-(G3C7^3)))*tanh((1.0/(x(1)))));


% G1C3 = -2.53326829397246;
% G1C5 = 3.19454435027511;
% G2C1 = 3.52623643125742;
% G3C7 = 7.70594230357005;
% G3C5 = 8.00957559189044;
% G3C0 = -10.0463980050343;
% 
% y = 0.0;
% 
% y = (gep3Rt((((1.0/(d(4)))*(d(5)-d(2)))/(G1C5/d(6))))+G1C3);
% y = y + (G2C1-(d(2)-((d(1)-d(2))*(1.0/(d(4))))));
% y = y + ((G3C7+(reallog((d(6)-((G3C5*G3C0)+d(5))))/reallog(10)))^2);

result = y;
result(result>100) = 100;
result(result<0) = 0;

function result = gep3Rt(x)
if (x < 0.0)
	result = -((-x)^(1.0/3.0));
else
	result = x^(1.0/3.0);
end


