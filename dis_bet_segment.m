function [ min_length ] = dis_bet_segment( i,j,final_points )
    result=zeros(1,4);
    
    line1_x1=final_points(1,i);
    line1_y1=final_points(3,i);
    line1_x2=final_points(2,i);
    line1_y2=final_points(4,i);
    
    line2_x1=final_points(1,j);
    line2_y1=final_points(3,j);
    line2_x2=final_points(2,j);
    line2_y2=final_points(4,j);
    
%     length1=final_points(6,i);%表示直线1的长度
%     length2=final_points(6,j);%表示直线2的长度
    length1=sqrt((line1_x1-line1_x2)^2+(line1_y1-line1_y2)^2);
    length2=sqrt((line2_x1-line2_x2)^2+(line2_y1-line2_y2)^2);

    len1_1=sqrt((line1_x1-line2_x1)^2+(line1_y1-line2_y1)^2);
    len1_2=sqrt((line1_x1-line2_x2)^2+(line1_y1-line2_y2)^2);
    len2_1=sqrt((line1_x2-line2_x1)^2+(line1_y2-line2_y1)^2);
    len2_2=sqrt((line1_x2-line2_x2)^2+(line1_y2-line2_y2)^2);

    
    %第一种情况
    a=length2;
    b=len1_1;
    c=len1_2;
    p=(a+b+c)/2;
    area=sqrt(p*(p-a)*(p-b)*(p-c));
    
    cos_ba=(b^2+a^2-c^2)/(2*a*b);
    cos_ca=(c^2+a^2-b^2)/(2*a*c);
    
    if(cos_ba>=0 && cos_ca>=0)
        result(1)=2*area/a;
    else
        result(1)=Inf;
    end

    %第二种情况
    a=length2;
    b=len2_1;
    c=len2_2;
    p=(a+b+c)/2;
    area=sqrt(p*(p-a)*(p-b)*(p-c));
    
    cos_ba=(b^2+a^2-c^2)/(2*a*b);
    cos_ca=(c^2+a^2-b^2)/(2*a*c);
    
    if(cos_ba>=0 && cos_ca>=0)
        result(2)=2*area/a;
    else
        result(2)=Inf;
    end
    
    %第三种情况
    a=length1;
    b=len1_1;
    c=len2_1;
    p=(a+b+c)/2;
    area=sqrt(p*(p-a)*(p-b)*(p-c));
    
    cos_ba=(b^2+a^2-c^2)/(2*a*b);
    cos_ca=(c^2+a^2-b^2)/(2*a*c);
    
    if(cos_ba>=0 && cos_ca>=0)
        result(3)=2*area/a;
    else
        result(3)=Inf;
    end
    
    %第四种情况
    a=length1;
    b=len1_2;
    c=len2_2;
    p=(a+b+c)/2;
    area=sqrt(p*(p-a)*(p-b)*(p-c));
    
    cos_ba=(b^2+a^2-c^2)/(2*a*b);
    cos_ca=(c^2+a^2-b^2)/(2*a*c);
    
    if(cos_ba>=0 && cos_ca>=0)
        result(4)=2*area/a;
    else
        result(4)=Inf;
    end
    
    min_length=min(result);
end

