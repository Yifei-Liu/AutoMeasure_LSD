function [min_length, max_length ,minn,maxx ,len] = minimum_range(X,Y)
%minimum_range Summary of this function goes here
%   Detailed explanation goes here
    len=zeros(1,4);
    len(1)=sqrt( (X(1)-Y(1))^2 + (X(3)-Y(3))^2);%��ʾֱ�߳���1
    len(2)=sqrt( (X(1)-Y(2))^2 + (X(3)-Y(4))^2);%��ʾֱ�߳���2
   
    len(3)=sqrt( (X(2)-Y(1))^2 + (X(4)-Y(3))^2);%��ʾֱ�߳���3
    len(4)=sqrt( (X(2)-Y(2))^2 + (X(4)-Y(4))^2);%��ʾֱ�߳���4

    [min_length,minn]=min(len);%%��С����
    [max_length,maxx]=max(len);%%��󳤶�

end

