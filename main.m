clear all; close all; clc;

files = dir('data/*.jpg');

P_Mat = load( fullfile( 'data', 'dino_Ps.mat') );
P_Mat = P_Mat.P;
% projections -> camera positions and camera coordinates

res = 50;

xAxis = linspace(-180,90,res);
yAxis = linspace(-80,70,res);
zAxis = linspace(-20,460,res);

box = ones(res,res,res); % carving element

% Sets exterior voxels to 0
box(1,:,:) = 0;
box(:,1,:) = 0;
box(:,:,1) = 0;
box(res,:,:) = 0;
box(:,res,:) = 0;
box(:,:,res) = 0;

start = cputime;
figure
%iterate through voxels
for k=1:36
    %% Get new mask
    filename = sprintf("data/dino%02d.jpg",(k-1));
    img = imread(filename);
    mask = silhouette(img);
    for i=1:res % xAxis
        a = xAxis(i);
        for j=1:res % yAxis
            b = yAxis(j);
            for l=1:res % zAxis
                c = zAxis(l);
                % Convert 3D coordinates to 2D
                vi = [a b c 1];
                %pr = P_Mat{1,k}(:,:)*vi';
                pr = projection_matrices(k)*vi';
    
                x = floor(pr(1)/pr(3));
                y = floor(pr(2)/pr(3));
                
                if y<576 && x<=720 && x>=1 && y>=1
                    if mask(y,x) == 0
                        box(i,j,l) = 0;
                    end
                end                
            end
        end
    end
    
    clf
    
    [f,v] = isosurface(xAxis,yAxis,fliplr(zAxis),box,0.5);
    p = patch('Faces',f,'Vertices',v);
    isonormals(xAxis,yAxis,fliplr(zAxis),box,p);
    p.FaceColor = 'yellow';
    p.EdgeColor = 'red';
    view(3)
    daspect([1 1 1]);
    rotate3d on
    pause(1)
end
xlabel('X Axis');
ylabel('Y Axis');
zlabel('Z Axis');

figure
[f,v] = isosurface(xAxis,yAxis,fliplr(zAxis),box,0.5);
    
p = patch('Faces',f,'Vertices',v);
p.BackFaceLighting = 'lit';
p.FaceColor = 'yellow';
p.EdgeColor = 'none';

isonormals(xAxis,yAxis,fliplr(zAxis),box,p);

camlight
lighting gouraud
rotate3d on
daspect([1 1 1]);
duration = cputime - start;
fprintf('Computation Time: %d\n',duration);

%% Save 4 new viewpoints
%view(45,0);
%saveas(gca,'45.png');

%view(135,0);
%saveas(gca,'135.png');

%view(225,0);
%saveas(gca,'225.png');

%view(315,0);
%saveas(gca,'315.png');