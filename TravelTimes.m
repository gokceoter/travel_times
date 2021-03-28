clc
clear all
nlyr=5;
nteta=50;
h=[1 0.5 3 2 1];
vel=[1.5 2.0 3.0 2.0 5.0];
clear x z
teta=-60*pi/180;
dteta=2*teta/nteta;
for ir=1:nteta
    teta=teta-dteta;
    
    % Compute travel times
    
    zs=sum(h);
    z(nlyr+1)=zs;
    x(nlyr+1,ir)=0;
    ttot=h(nlyr)/(vel(nlyr)*cos(teta));
    xtot = h(nlyr)*tan(teta);
    p=sin(teta)/vel(nlyr);
    z(nlyr)=sum(h(1:nlyr))-h(nlyr);
    x(nlyr,ir)=xtot;
    for il=nlyr-1:-1:1
        pv=p*vel(il);
        cpv=sqrt(1-pv*pv);
        ttot=ttot+h(il)/(vel(il)*cpv);
        xtmp=h(il)*pv/cpv;
        xtot=xtot+xtmp
        x(il,ir)=zs+xtot
        z(il)=z(il+1)-h(il);
    end
    xt(ir)=xtot;
    tt(ir)=ttot;
end
plot(xt,tt,'r-');
ylabel('Time(ms)','FontSize',9)
set(gca,'FontSize',7,'LineWidth',0.1)
