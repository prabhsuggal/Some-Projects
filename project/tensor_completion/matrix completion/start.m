m=magic(300);
a=m;
for i=1:size(m,2)
    mu=mean(m(:,i));
    m(:,i)=(m(:,i)-mu)/std(m(:,i));   % normalize the data
end
b=m;
s=svd(m);
plot(s);
n=numel(m);
omega=randsample( n,20000);
%delta=1.2*n^2/5000;
tau = 5*sqrt(n);
epsilon=0.00001;
z=zeros(size(m));
z(omega)=1;
m=m.*z;
max_iter=1000;
X=mtx2( omega,m,2,epsilon,700,max_iter );
