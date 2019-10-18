function [min_length, max_length ,minn,maxx ,len] = minimum_range(X,Y)
%minimum_range Summary of this function goes here
%   Detailed explanation goes here
    len=zeros(1,4);
    len(1)=sqrt( (X(1)-Y(1))^2 + (X(3)-Y(3))^2);%表示直线长度1
    len(2)=sqrt( (X(1)-Y(2))^2 + (X(3)-Y(4))^2);%表示直线长度2
   
    len(3)=sqrt( (X(2)-Y(1))^2 + (X(4)-Y(3))^2);%表示直线长度3
    len(4)=sqrt( (X(2)-Y(2))^2 + (X(4)-Y(4))^2);%表示直线长度4

    [min_length,minn]=min(len);%%最小长度
    [max_length,maxx]=max(len);%%最大长度

end

