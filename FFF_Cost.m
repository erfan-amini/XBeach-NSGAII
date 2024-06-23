% Cost function
% x(1): Hsw
% x(2): Av
% x(3): Nv
function Cost = FFF_Cost(x,lb,ub)
        Navg    = 100;

        ICs = 5633;
        DCs = 563;
        RCs = 5633;
        MCs = 262;

        ICv = 295;
        DCv = 59;
        MCv = 59;

        Avmax = ub(2);
        Avmin = lb(2);
        Nvmax = ub(3);
        Nvmin = lb(3);

        Fe = (Avmax*Nvmax-x(2)*x(3))/(Avmax*Nvmax-Avmin*Nvmin);
        Fv = 1.5;
        TCs = Fv*x(1)*ICs+Fe*x(1)*(DCs+RCs+MCs);

        ICv_adj = (x(3)/Navg)*x(2)*ICv;
        TCv = ICv_adj+DCv+MCv;

        Cost = TCs+0.5*TCv;
end
