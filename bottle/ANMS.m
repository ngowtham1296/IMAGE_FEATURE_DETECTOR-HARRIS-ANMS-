function final_mat=ANMS(metric1)
q=1;
global metric1 final_mat
%global x_cord_new y_cord_new x_cord_rot_new y_cord_rot_new
for i=1:size(metric1,1)
    for j=1:size(metric1,2)
        if(metric1(i,j)~=0)
        metric1_array(q)=metric1(i,j);
        x_cord(q)=i;
        y_cord(q)=j;
        q=q+1;
        end
        
    end
end
%metric1_array is sorted in decreasing order. x_cord and y_cord are also
%sorted accordingly.
[R,a]=sort(metric1_array,'descend');
        for i=1:size(a,2)
            x_cord_new(i)=x_cord(a(i));
            y_cord_new(i)=y_cord(a(i));    
        end
        
%we need to take each non zero pixel and find the pixel that is k% greater than the pixel under consideration with the least distance between them.        
% let k=15%
k=15;
R_new=0;
for i=2:size(R,2)
    min_dist=100;     %we need to take the max value
    for j=i-1:-1:1
        if(((R(j)-R(i))>(k*R(i)/100)))
            dist=sqrt((x_cord_new(i)-x_cord_new(j))^2+((y_cord_new(i)-y_cord_new(j))^2));
            if (dist<min_dist)
                min_dist=dist;
                if(R_new==0)
                    R_new(1)=max(max(R));
                    radius(1)=450*579;
                    x_cord_sorted(1)=x_cord_new(1);
                    y_cord_sorted(1)=y_cord_new(1);
                end
                R_new(i)=R(j);
                radius(i)=min_dist;
                x_cord_sorted(i)=x_cord_new(i);
                y_cord_sorted(i)=y_cord_new(i);
            end
        end
    end                             
end

%now, we have the array sorted according to the raduis. we need to take top
%k values. Rest of the values will be 0. Convert it into matrix.
%top_n=5
top_n=200;
for i=top_n:size(R_new,2)
    R_new(i)=0;
end


final_mat=zeros(450,579);

for i=1:size(x_cord_new,2)
    final_mat(x_cord_new(i),y_cord_new(i))=R_new(i);

end
end