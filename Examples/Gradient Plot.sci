// simple plot using z=f(x,y) 
t=[0:0.1:6*%pi]';
z=sin(t)*cos(t');

[xx,yy,zz]=genfac3d(t,t,z); 
sz = size(zz);
plot3d([xx],[yy],list([zz],[5*ones(1,sz(2))]));
h=gce(); 				//get handle on current entity (here the surface)
k=gcf();				//get the handle of the parent figure    

k.color_map=bonecolormap(512);
h.color_flag=1; 		//color according to z
h.color_mode=-2;  		//remove the facets boundary by setting color_mode to white color
sleep(1000);
