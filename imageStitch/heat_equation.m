function out_I=heat_equation(mask,mask1,I,iter)
nmin=mask1(1,1);
nmax=mask1(1,2);
mmin=mask1(2,1);
mmax=mask1(2,2);
% I=imread('../linc.jpg');
% I(40:50,70:80,:)=0;
% imshow(I);
% mask2=[20:80;50:100];
% load stripardes.mat
% load mask.mat
% load test1.mat
% g=strip1ades;
% g=im2double(I);
% I=im2double(I);
g=I(nmin:nmax,mmin:mmax,:);
% [m,n,~]=size(g);

% mask=ones(m,n);
% mask(40:50,70:80)=0;
mask=mask(nmin:nmax,mmin:mmax);
% g=I(18:61,48:82,:);
% g=double(g);
[m,n,~]=size(g);
% g = g./max(max(g));
% clims=[0 1];
%Parameters
h1=1;
h2=1;
% T=3000;
dt=0.1;
lambda0=10;
lambda = mask.*lambda0;


% laplacian = L1*u+u*L2
L1=(1/(h1^2))*(diag(-2*ones(m,1)) + diag(ones(m-1,1),1) + diag(ones(m-1,1),-1));
L1(1,1)=-1/h1^2; L1(m,m)=-1/h1^2;

L2=(1/(h2^2))*(diag(-2*ones(n,1)) + diag(ones(n-1,1),1) + diag(ones(n-1,1),-1));
L2(1,1)=-1/h2^2; L2(n,n)=-1/h2^2;


%intialization of u:
u1=g(:,:,1);


u2=g(:,:,2);
u3=g(:,:,3);
% m1=max(max(u1));
% m2=max(max(u2));
% m3=max(max(u3));
% u1=u1/m1;
% u2=u2/m2;
% u3=u3/m3;

for t=1:iter
    u1=u1+dt*(L1*u1+u1*L2+lambda.*(g(:,:,1)-u1));
    u2=u2+dt*(L1*u2+u2*L2+lambda.*(g(:,:,2)-u2));
    u3=u3+dt*(L1*u3+u3*L2+lambda.*(g(:,:,3)-u3));
    

end
g(:,:,1)=u1;
g(:,:,2)=u2;
g(:,:,3)=u3;
% figure;
% imshow(g);
% I=im2double(I);
I(nmin:nmax,mmin:mmax,:)=g;
% I=im2uint8(I);
out_I=I;
% figure
% imshow(I)