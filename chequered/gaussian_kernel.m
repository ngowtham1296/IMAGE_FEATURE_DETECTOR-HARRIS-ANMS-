function kernel= gaussian_kernel(Sigma)
kernel=zeros(5,5);          % 5 cross 5 kernel matrix
w=0;
% Kernel matrix
for i=1:5
    for j=1:5
        d=(i-3)^2 + (j-3)^2;
        kernel(i,j)= exp(-1*(d)/(2*Sigma*Sigma))/sqrt(2*pi*Sigma);  
        w=w+kernel(i,j);             % Sum of all elements in kernel matrix
    end
end

kernel=kernel/w;   
end