function [x_cord_new y_cord_new]=func()
global x_cord_new y_cord_new final_mat_rot count
c=1;
for i=1:size(final_mat_rot,1)
    for j=1:size(final_mat_rot,2)
        if(final_mat_rot(i,j)~=0)
            array_without_rot(c)=final_mat_rot(i,j);
            x_cord(c)=i;
            y_cord(c)=j;
            c=c+1;
end
end
end
[R,a]=sort(array_without_rot,'descend');
        for i=1:size(a,2)
            x_cord_new(i)=x_cord(a(i));
            y_cord_new(i)=y_cord(a(i));    
        end

%put all the non zero values of the final_mat_rot into an array
c=1;
for i=1:size(final_mat_rot,1)
    for j=1:size(final_mat_rot,2)
        if(final_mat_rot(i,j)~=0)
            array_with_rot(c)=final_mat_rot(i,j);
            x_cord_rot(c)=i;
            y_cord_rot(c)=j;
            c=c+1;
end
end
end
[R_rot,a_rot]=sort(array_with_rot,'descend');
        for i=1:size(a_rot,2)
            x_cord_rot_new(i)=x_cord_rot(a_rot(i));
            y_cord_rot_new(i)=y_cord_rot(a_rot(i));    
end

%Now, we need to compare and match the features. So, we have to compare the
% R and R_rot. The number of same features are stored in count variable
count=0;
for i=1:size(R,2)
    for j=1:size(R,2)
        if(sqrt((x_cord_new(i)-x_cord_rot_new(j))^2+(y_cord_new(i)-y_cord_rot_new(j))^2)<3)
            count=count+1;
        end
    end
end

end