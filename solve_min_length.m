function [ zuixiao ] = solve_min_length( i,j,points )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
     [min_length, max_length ,minn,maxx ,len] = minimum_range(points(1:4,i),points(1:4,j));
     zuixiao=min_length;
end

