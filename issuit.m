function [flag]=issuit(i,j,points)
    flag=1;
    [min_length, max_length ,minn,maxx,len ] = minimum_range(points(1:4,i),points(1:4,j));
    bz=zeros(1,4);
    bz(minn)=1;%最小的置为1
    
    for i=1:4
        if(bz(i)==0&&len(i)<min_length*2)
            flag=0;%表示的是其他的直线有小于最小的两倍的，那么不能连接
        end
    end
    
end
