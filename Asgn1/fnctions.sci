function [x, y] = polar2rect(r,theta)

x = r*cos(theta*%pi/180)

y = r*sin(theta*%pi/180)

endfunction 
