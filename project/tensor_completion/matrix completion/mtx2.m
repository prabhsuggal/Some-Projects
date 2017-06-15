function [ X ] = mtx2( omega,M,delta,epsilon,tau,max_iter )

Z=zeros(size(M));
Y=Z;

Z(omega)=1;

for k=1:max_iter
    [U,S,V]=svd(Y);
    
    m=diag(S);
    
    r=find((m>tau),1,'last');
    if(isempty(r))
        X=zeros(size(M));
    else
    X=U(:,1:r)*(S(1:r,1:r)-tau*eye(r))*V(:,1:r)';
    end
    
    
    a=norm(X(omega)-M(omega),'fro');
    b=norm(M(omega),'fro');
    if(a/b<=epsilon) 
        break;
    end
    Y=Y.*Z;
    Y(omega)=Y(omega)+delta*(M(omega)-X(omega));
    
    %if(k==5)
     %   X(1:10,1:10)
      %  pause;
    %end
end
k
b
figure;
s=svd(X);
plot(s);