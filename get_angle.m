function angle=get_angle(i,j,points)
    A=zeros(4,1);
    B=zeros(4,1);
    A=points(1:4,i);
    B=points(1:4,j);
    k1=(A(4)-A(3))/(A(2)-A(1));  
    k2=(B(4)-B(3))/(B(2)-B(1));
    cos_alpha=abs(   (1+k1*k2)/( sqrt(1+k1^2)*sqrt(1+k2^2) ) );
    angle=radtodeg(acos(cos_alpha));
end