clc
clear all
%%
%h=input('Enter the step value(0<h<6):');%�������
h=0.1;
x=0:h:80;
h2=h*h;
Nx=length(x);
g=[0.5;zeros(Nx-2,1);0.5];

yi=0.5/40/40*(x-40).^2;%��ʼ����ֵ

yi=yi'+0.1;
yi=yi*pi;

%% ����ϡ�����
Fhand=@(t)sparse(1:Nx,1:Nx,t,Nx,Nx);
M=sparse(2:Nx,1:Nx-1,1,Nx,Nx)+Fhand(-2)+sparse(2:Nx,1:Nx-1,1,Nx,Nx)';
%%
for k=1:1000;%����ѭ��
    MJ=M+Fhand(h2/10^(-11)*0.74106*(-5.2)*8.85*10^(-12)*cos(2*yi)*3.01*(1.45/80)^2);%�ſɱȾ���
    fyi=(M+Fhand(h2/2/10^(-11)*0.74106*(-5.2)*8.85*10^(-12)*sin(2*yi)*3.01./yi*(1.45/80)^2))*yi+g;
    MF=MJ\fyi;
    if norm(MF)<10^-14%ѭ��ֹͣ���������
        break;
    end
    delta=abs(MF);%�����������εĲ�ֵ
    yi=yi-MF;%������ʽ
%     yi(1)=1;
%     yi(Nx)=0;
end
k
norm(MF)
subplot(2,1,1)
plot(x,yi');
title('The solution of ODE');
subplot(2,1,2)
plot(x,delta,'r')
title('{y^{(k+1)}}-{y^{(k)}}');