clc;
clear all;
close all;
%求株高

pathname='./images/test.JPG';
points = lsd(pathname);

im = imread(pathname);
imshow(im);
hold on;

n=size(points,2);

for i=1:n
    points(5,i)=(points(4,i)-points(3,i))/(points(2,i)-points(1,i));%表示斜率
    points(6,i)=sqrt( (points(1,i)-points(2,i))^2 + ( points(3,i)- points(4,i))^2);%表示直线长度
end

%%points以上已经处理完毕,以下筛选

threshold=15;
len=0;
% k=0;
for i=n:-1:1
    len=sqrt(  (points(1,i)-points(2,i))^2+ (points(3,i)-points(4,i))^2 );

    if((points(1,i)==points(2,i))|| (len<threshold))
        points(:,i)=[];
    end
end
new_points=points;
[m,n]=size(new_points);

%以下是画直线
maxx=1000000;
max_i=0;
for i = 1:size(new_points, 2)
    if( new_points(1,i)<maxx||new_points(2,i)<maxx )
        max_i=i;
        if(new_points(1,i)<new_points(2,i))
            maxx=new_points(1,i);
        else
            maxx=new_points(2,i);
        end
    end
%     plot(new_points(1:2, i), new_points(3:4, i), 'LineWidth', 2, 'Color', [1, 0, 0]);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

angle_thres=10;     %角度阈值为15度
dis_thres=20;       %两条直线距离阈值

%15
%20
%10

i=1;
j=1;
count=n;%count=1761
flag=zeros(1,n*3);%表示是否已经画过了
% a=0;

while(true)%外层循环
    while(true)%内层循环
%         a=a+1;
         if(i<j && flag(i)==0 && flag(j)==0&&  get_angle(i,j,new_points)<angle_thres &&issuit(i,j,new_points)==1 &&  solve_min_length(i,j,new_points)<dis_thres   )%&& suit(i,j)==1 
                flag(i)=1;
                flag(j)=1;
                [min_length,max_length,minn,maxx,len] = minimum_range(new_points(1:4,i),new_points(1:4,j));
                count=count+1;%计数器加1
                if maxx==1
                      new_points(1,count)=new_points(1,i);%x1
                      new_points(2,count)=new_points(1,j);%x2
                      new_points(3,count)=new_points(3,i);%y1
                      new_points(4,count)=new_points(3,j);%y2
                      new_points(5,count)=(new_points(4,count)-new_points(3,count))/(new_points(2,count)-new_points(1,count));
                      new_points(6,count)=sqrt( (new_points(1,count)-new_points(2,count))^2 + ( new_points(3,count)- new_points(4,count))^2);%表示直线长度
                elseif maxx==2
                      new_points(1,count)=new_points(1,i);
                      new_points(2,count)=new_points(2,j);
                      new_points(3,count)=new_points(3,i);
                      new_points(4,count)=new_points(4,j);
                      new_points(5,count)=(new_points(4,count)-new_points(3,count))/(new_points(2,count)-new_points(1,count));
                      new_points(6,count)=sqrt( (new_points(1,count)-new_points(2,count))^2 + ( new_points(3,count)- new_points(4,count))^2);%表示直线长度
                elseif maxx==3
                      new_points(1,count)=new_points(2,i);
                      new_points(2,count)=new_points(1,j);
                      new_points(3,count)=new_points(4,i);
                      new_points(4,count)=new_points(3,j);
                      new_points(5,count)=(new_points(4,count)-new_points(3,count))/(new_points(2,count)-new_points(1,count));
                      new_points(6,count)=sqrt( (new_points(1,count)-new_points(2,count))^2 + ( new_points(3,count)- new_points(4,count))^2);%表示直线长度
                elseif maxx==4
                      new_points(1,count)=new_points(2,i);
                      new_points(2,count)=new_points(2,j);
                      new_points(3,count)=new_points(4,i);
                      new_points(4,count)=new_points(4,j);
                      new_points(5,count)=(new_points(4,count)-new_points(3,count))/(new_points(2,count)-new_points(1,count));
                      new_points(6,count)=sqrt( (new_points(1,count)-new_points(2,count))^2 + ( new_points(3,count)- new_points(4,count))^2);%表示直线长度
                end
                
         end
        if(j==count)
            j=1;
            break;
        end
        j=j+1;
    end
    
    if(i==count)
        break;
    end
    i=i+1;
end

chang=150;
sum=0;
%创建final_points,记录最后的直线，并做最后的处理
final_points=zeros(6,n);

for i = 1:size(new_points, 2)
    if(flag(i)==0&&new_points(6,i)>chang)
%         plot(new_points(1:2, i), new_points(3:4, i), 'LineWidth', 2, 'Color', [1, 0, 0]);
        sum=sum+1;
        final_points(:,sum)=new_points(:,i);
    end
end
final_points=final_points(:,1:sum);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n=size(final_points,2);

i=1;
j=1;
count=n;%count=28
flag=zeros(1,n*3);%表示是否已经画过了

angle_thres1=15;%这个要设置一个值 原来是15
segment_dis_thres=25;%线段之间的距离
dis_thres=150;%两条直线距离阈值150
while(true)%外层循环
    while(true)%内层循环
%         a=a+1;
         if(i<j && flag(i)==0 && flag(j)==0 &&  get_angle(i,j,final_points)<angle_thres1 &&(dis_bet_segment( i,j,final_points )< segment_dis_thres || solve_min_length(i,j,final_points)<dis_thres  ))
                flag(i)=1;
                flag(j)=1;
                [min_length,max_length,minn,maxx,len] = minimum_range(final_points(1:4,i),final_points(1:4,j));
                count=count+1;%计数器加1
                if maxx==1
                      final_points(1,count)=final_points(1,i);%x1
                      final_points(2,count)=final_points(1,j);%x2
                      final_points(3,count)=final_points(3,i);%y1
                      final_points(4,count)=final_points(3,j);%y2
                      final_points(5,count)=(final_points(4,count)-final_points(3,count))/(final_points(2,count)-final_points(1,count));
                      final_points(6,count)=sqrt( (final_points(1,count)-final_points(2,count))^2 + ( final_points(3,count)- final_points(4,count))^2);%表示直线长度
                elseif maxx==2            
                      final_points(1,count)=final_points(1,i);
                      final_points(2,count)=final_points(2,j);
                      final_points(3,count)=final_points(3,i);
                      final_points(4,count)=final_points(4,j);
                      final_points(5,count)=(final_points(4,count)-final_points(3,count))/(final_points(2,count)-final_points(1,count));
                      final_points(6,count)=sqrt( (final_points(1,count)-final_points(2,count))^2 + ( final_points(3,count)- final_points(4,count))^2);%表示直线长度
                elseif maxx==3
                      final_points(1,count)=final_points(2,i);
                      final_points(2,count)=final_points(1,j);
                      final_points(3,count)=final_points(4,i);
                      final_points(4,count)=final_points(3,j);
                      final_points(5,count)=(final_points(4,count)-final_points(3,count))/(final_points(2,count)-final_points(1,count));
                      final_points(6,count)=sqrt( (final_points(1,count)-final_points(2,count))^2 + ( final_points(3,count)- final_points(4,count))^2);%表示直线长度
                elseif maxx==4
                      final_points(1,count)=final_points(2,i);
                      final_points(2,count)=final_points(2,j);
                      final_points(3,count)=final_points(4,i);
                      final_points(4,count)=final_points(4,j);
                      final_points(5,count)=(final_points(4,count)-final_points(3,count))/(final_points(2,count)-final_points(1,count));
                      final_points(6,count)=sqrt( (final_points(1,count)-final_points(2,count))^2 + ( final_points(3,count)- final_points(4,count))^2);%表示直线长度
                end
                
         end
        if(j==count)
            j=1;
            break;
        end
        j=j+1;
    end
    
    if(i==count)
        break;
    end
    i=i+1;
end

chang1=500;
sum=0;

end_points=zeros(6,n);

for i = 1:size(final_points, 2)
    if(flag(i)==0&&final_points(6,i)>chang1)
%          plot(final_points(1:2, i), final_points(3:4, i), 'LineWidth', 2, 'Color', [1, 0, 0]);
         sum=sum+1;
         end_points(:,sum)=final_points(:,i);
    end
end
end_points=end_points(:,1:sum);


%end_points表示最终的直线
a=[3.070256554013944e+03;1.233727641615688e+03;];
b=[55.922371476967946;1.142760077347316e+03;];


 plot([a(1) b(1)], [a(2) b(2)], 'LineWidth', 2, 'Color', [1, 0, 0]);










