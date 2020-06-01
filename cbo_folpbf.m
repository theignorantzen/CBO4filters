itercur=0; itermax=10; N=3; np=30;
%marking the expansion of the coefficients
mn=0; mx=255;
D=2*(N+1);
count=1;
X=zeros(np,D);
%initializing all colliding bodies
while(count<=np)
X(count,:) = mn+rand(1,D).*(mx-mn);
  a0=X(count,5);a1=X(count,6);a2=X(count,7);a3=X(count,8);
if (a1*a2-a0*a3)>0
    count = count + 1;
end
end
fbest=inf;
L=500;n=1;a=0.8;
%main loop for optimization using iterative method
while(itercur<itermax)
itercur=itercur+1;
m=zeros(np,1); 
F=zeros(np,1);  
for e=1:np  %loop 1
    Fsum=0;
  for w=0.02:0.02:10 %loop 2
	mag1=1/(1+(w)^(2*(n+a)))^0.5; %for ideal FOLPBF
	num=X(e,1:N+1);   
	den=X(e,(N+2):D);  
	H=tf(num,den);  
	mag2=bode(H,w);  %for tradition LPBF
	P=(mag1-mag2)^2;
	Fsum=Fsum+P;  
  end  %loop 2
F(e)=(Fsum/L)^0.5;  %obtaining the fitness function  	 
end %loop 1

%finding out the gbest
[fbest,I]=min(F);
gbest=X(I,:);

%defining the mass of CBs
sum=0;
for k=1:np 
   sum=sum+(1/F(k));
end
for j=1:np
   m(j)=(1/F(j))/sum;
end

%sorting CB in descending order acc to masses
[mass,order]=sort(m,'descend');
X = X(order,:);

%Modelling the velocities
vel=zeros(np,D); 
new_vel=zeros(np,D);
COR=(1-(itercur/itermax)); % coefficient of restitution
for i=1:np/2  %loop3
   	idx_S=i; 
   	idx_M=np/2 +i; 
 	 
vel(idx_M,:) = (X(idx_M,:) - X(idx_S,:)); 
new_vel(idx_S,:)=((m(idx_M,:))*(1+COR)*vel(idx_M,:))/(m(idx_S,:)+m(idx_M,:));
new_vel(idx_M,:)=(m(idx_M,:)-COR*m(idx_S,:))*vel(idx_M,:)/(m(idx_S,:)+m(idx_M,:));
%Updating the position of SG CBs
Temp = X(idx_S,:)+(2.*rand-1).*new_vel(idx_S,:);
  a0=Temp(5);a1=Temp(6);a2=Temp(7);a3=Temp(8);
if ( (a0>0) && (a1>0) && (a2>0) && (a3>0) && (a1*a2-a0*a3)>0 )
    X(idx_S,:) = Temp;
end
%Updating the position of MG CBs
Temp=X(idx_S,:)+(2.*rand-1).*new_vel(idx_M,:);
  a0=Temp(5);a1=Temp(6);a2=Temp(7);a3=Temp(8);
if ( (a0>0) && (a1>0) && (a2>0) && (a3>0) && (a1*a2-a0*a3)>0 )
    X(idx_M,:) = Temp;
end
end   %loop 3
end   %while loop