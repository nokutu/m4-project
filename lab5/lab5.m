%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Lab 5: Reconstruction from uncalibrated viewas
close all
clc
clear all

addpath('../lab2/sift'); % ToDo: change 'sift' to the correct path where you have the sift functions


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 0. Create synthetic data

% 3D points
X = [];
Xi = [0 0 10]'; % middle facade
X = [X Xi];
Xi = [0 20 10]';
X = [X Xi];
Xi = [0 20 0]';
X = [X Xi];
Xi = [0 0 0]';
X = [X Xi];
Xi = [10 20 10]'; % right facade
X = [X Xi];
Xi = [10 20 0]';
X = [X Xi];
Xi = [30 0 10]';  % left facade
X = [X Xi];
Xi = [30 0 0]'; 
X = [X Xi];
Xi = [0 5 8]';   % middle squared window
X = [X Xi];
Xi = [0 8 8]';
X = [X Xi];
Xi = [0 5 5]';
X = [X Xi];
Xi = [0 8 5]';
X = [X Xi];
Xi = [0 12 5]';  % middle rectangular window
X = [X Xi];
Xi = [0 18 5]';
X = [X Xi];
Xi = [0 12 2]';
X = [X Xi];
Xi = [0 18 2]';
X = [X Xi];
Xi = [3 20 7]';   % left squared window
X = [X Xi];
Xi = [7 20 7]';
X = [X Xi];
Xi = [3 20 3]';
X = [X Xi];
Xi = [7 20 3]';
X = [X Xi];
Xi = [5 0 7]';   % right rectangular window
X = [X Xi];
Xi = [25 0 7]';
X = [X Xi];
Xi = [5 0 3]';
X = [X Xi];
Xi = [25 0 3]';
X = [X Xi];


% cameras

K = [709 0 450; 0 709 300; 0 0 1];
Rz = [cos(0.88*pi/2) -sin(0.88*pi/2) 0; sin(0.88*pi/2) cos(0.88*pi/2) 0; 0 0 1];
Ry = [cos(0.88*pi/2) 0 sin(0.88*pi/2); 0 1 0; -sin(0.88*pi/2) 0 cos(0.88*pi/2)];
R1 = Rz*Ry;
t1 = -R1*[42; 5; 10];

Rz = [cos(0.8*pi/2) -sin(0.8*pi/2) 0; sin(0.8*pi/2) cos(0.8*pi/2) 0; 0 0 1];
Ry = [cos(0.88*pi/2) 0 sin(0.88*pi/2); 0 1 0; -sin(0.88*pi/2) 0 cos(0.88*pi/2)];
Rx = [1 0 0; 0 cos(-0.15) -sin(-0.15); 0 sin(-0.15) cos(-0.15)];
R2 = Rx*Rz*Ry;
t2 = -R2*[45; 15; 5];

P1 = zeros(3,4);
P1(1:3,1:3) = R1;
P1(:,4) = t1;
P1 = K*P1;

P2 = zeros(3,4);
P2(1:3,1:3) = R2;
P2(:,4) = t2;
P2 = K*P2;

w = 900;
h = 600;

% visualize as point cloud
figure; hold on;
plot_camera2(P1,w,h);
plot_camera2(P2,w,h);
for i = 1:length(X)
    scatter3(X(1,i), X(2,i), X(3,i), 5^2, [0.5 0.5 0.5], 'filled');
end
axis equal;
axis vis3d;

%% visualize as lines
figure;
hold on;
X1 = X(:,1); X2 = X(:,2); X3 = X(:,3); X4 = X(:,4);
plot3([X1(1) X2(1)], [X1(2) X2(2)], [X1(3) X2(3)]);
plot3([X3(1) X4(1)], [X3(2) X4(2)], [X3(3) X4(3)]);
X5 = X(:,5); X6 = X(:,6); X7 = X2; X8 = X3;
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
X5 = X(:,7); X6 = X(:,8); X7 = X1; X8 = X4;
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
X5 = X(:,9); X6 = X(:,10); X7 = X(:,11); X8 = X(:,12);
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
X5 = X(:,13); X6 = X(:,14); X7 = X(:,15); X8 = X(:,16);
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
X5 = X(:,17); X6 = X(:,18); X7 = X(:,19); X8 = X(:,20);
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
X5 = X(:,21); X6 = X(:,22); X7 = X(:,23); X8 = X(:,24);
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
axis vis3d
axis equal
plot_camera2(P1,w,h);
plot_camera2(P2,w,h);

%% Create homogeneous coordinates

% homogeneous 3D coordinates
Xh=[X; ones(1,length(X))];

% homogeneous 2D coordinates
x1 = P1*Xh;
x1(1,:) = x1(1,:)./x1(3,:);
x1(2,:) = x1(2,:)./x1(3,:);
x1(3,:) = x1(3,:)./x1(3,:);
x2 = P2*Xh;
x2(1,:) = x2(1,:)./x2(3,:);
x2(2,:) = x2(2,:)./x2(3,:);
x2(3,:) = x2(3,:)./x2(3,:);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1. Projective reconstruction (synthetic data)

% ToDo: create the function 'factorization_method' that computes a
% projective reconstruction with the factorization method of Sturm and
% Triggs '1996
% This function returns an estimate of:
%       Pproj: 3*Ncam x 4 matrix containing the camera matrices
%       Xproj: 4 x Npoints matrix of homogeneous coordinates of 3D points
% 
% As a convergence criterion you may compute the Euclidean
% distance (d) between data points and projected points in both images 
% and stop when (abs(d - d_old)/d) < 0.1 where d_old is the distance
% in the previous iteration.


%% Check projected points (estimated and data points)
[Pproj, Xproj] = factorization_method([x1; x2], false);

Pproj_1 = Pproj(1:3, :);
Pproj_2 = Pproj(4:6, :);

x_proj = cell(1, 2);
x_d = cell(1, 2);

x_proj{1} = euclid(Pproj_1*Xproj);
x_proj{2} = euclid(Pproj_2*Xproj);

x_d{1} = euclid(P1*Xh);
x_d{2} = euclid(P2*Xh);

% image 1
figure;
hold on
plot(x_d{1}(1,:),x_d{1}(2,:),'r*');
plot(x_proj{1}(1,:),x_proj{1}(2,:),'bo');
axis equal

% image 2
figure;
hold on
plot(x_d{2}(1,:),x_d{2}(2,:),'r*');
plot(x_proj{2}(1,:),x_proj{2}(2,:),'bo');


%% Compute reprojection error.

% compute the reprojection errors, plot the mean reprojection err

reproj_error = reprojection_error(Pproj_1, Pproj_2, Xproj, x1, x2);

disp(['Mean projection error: ', num2str(mean(reproj_error))]);

%% Visualize projective reconstruction
Xaux(1,:) = Xproj(1,:)./Xproj(4,:);
Xaux(2,:) = Xproj(2,:)./Xproj(4,:);
Xaux(3,:) = Xproj(3,:)./Xproj(4,:);
X=Xaux;

figure;
hold on;
X1 = X(:,1); X2 = X(:,2); X3 = X(:,3); X4 = X(:,4);
plot3([X1(1) X2(1)], [X1(2) X2(2)], [X1(3) X2(3)]);
plot3([X3(1) X4(1)], [X3(2) X4(2)], [X3(3) X4(3)]);
X5 = X(:,5); X6 = X(:,6); X7 = X2; X8 = X3;
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
X5 = X(:,7); X6 = X(:,8); X7 = X1; X8 = X4;
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
X5 = X(:,9); X6 = X(:,10); X7 = X(:,11); X8 = X(:,12);
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
X5 = X(:,13); X6 = X(:,14); X7 = X(:,15); X8 = X(:,16);
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
X5 = X(:,17); X6 = X(:,18); X7 = X(:,19); X8 = X(:,20);
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
X5 = X(:,21); X6 = X(:,22); X7 = X(:,23); X8 = X(:,24);
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
axis vis3d
axis equal

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2. Affine reconstruction (synthetic data)

% ToDo: create the function 'vanishing_point' that computes the vanishing
% point formed by the line that joins points xo1 and xf1 and the line 
% that joins points x02 and xf2
%
% [v1] = vanishing_point(xo1, xf1, xo2, xf2)

% Compute the vanishing points in each image
v1 = vanishing_point(x1(:,21),x1(:,22),x1(:,23),x1(:,24));
v2 = vanishing_point(x1(:,21),x1(:,23),x1(:,22),x1(:,24));
v3 = vanishing_point(x1(:,1),x1(:,2),x1(:,4),x1(:,3));
v3(end) = 3.3881e-21;

v1p = vanishing_point(x2(:,21),x2(:,22),x2(:,23),x2(:,24));
v2p = vanishing_point(x2(:,21),x2(:,23),x2(:,22),x2(:,24));
v3p = vanishing_point(x2(:,1),x2(:,2),x2(:,4),x2(:,3));

% ToDo: use the vanishing points to compute the matrix Hp that 
%       upgrades the projective reconstruction to an affine reconstruction
V1 = triangulate(euclid(v1), euclid(v1p), Pproj(1:3,:), Pproj(4:6,:), [w h]); 
V2 = triangulate(euclid(v2), euclid(v2p), Pproj(1:3,:), Pproj(4:6,:), [w h]); 
V3 = triangulate(euclid(v3), euclid(v3p), Pproj(1:3,:), Pproj(4:6,:), [w h]);

V1 = V1 ./ (V1(4));
V2 = V2 ./ (V2(4));
V3 = V3 ./ (V3(4));

A = [V1'; V2'; V3'];

[~, ~, V] = svd(A,0);

Ha = V(:,4)';
Ha = Ha(1:3)./Ha(4);
Hp=[eye(3), zeros(3, 1); Ha, 1];

%% check results

Xa = euclid(Hp*Xproj);
figure;
hold on;
X1 = Xa(:,1); X2 = Xa(:,2); X3 = Xa(:,3); X4 = Xa(:,4);
plot3([X1(1) X2(1)], [X1(2) X2(2)], [X1(3) X2(3)]);
plot3([X3(1) X4(1)], [X3(2) X4(2)], [X3(3) X4(3)]);
X5 = Xa(:,5); X6 = Xa(:,6); X7 = X2; X8 = X3;
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
X5 = Xa(:,7); X6 = Xa(:,8); X7 = X1; X8 = X4;
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
X5 = Xa(:,9); X6 = Xa(:,10); X7 = Xa(:,11); X8 = Xa(:,12);
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
X5 = Xa(:,13); X6 = Xa(:,14); X7 = Xa(:,15); X8 = Xa(:,16);
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
X5 = Xa(:,17); X6 = Xa(:,18); X7 = Xa(:,19); X8 = Xa(:,20);
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
X5 = Xa(:,21); X6 = Xa(:,22); X7 = Xa(:,23); X8 = Xa(:,24);
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
axis vis3d
axis equal

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3. Metric reconstruction (synthetic data)

% ToDo: compute the matrix Ha that 
%       upgrades the projective reconstruction to an affine reconstruction
% Use the following vanishing points given by three pair of orthogonal lines
% and assume that the skew factor is zero and that pixels are square

v1 = vanishing_point(x1(:,2),x1(:,5),x1(:,3),x1(:,6));
v2 = vanishing_point(x1(:,1),x1(:,2),x1(:,3),x1(:,4));
v3 = vanishing_point(x1(:,1),x1(:,4),x1(:,2),x1(:,3));

A = [v1(1)*v2(1), v1(1)*v2(2)+v1(2)*v2(1), v1(1)*v2(3)+v1(3)*v2(1), v1(2)*v2(2), v1(2)*v2(3)+v1(3)*v2(2), v1(3)*v2(3);
     v1(1)*v3(1), v1(1)*v3(2)+v1(2)*v3(1), v1(1)*v3(3)+v1(3)*v3(1), v1(2)*v3(2), v1(2)*v3(3)+v1(3)*v3(2), v1(3)*v3(3);
     v2(1)*v3(1), v2(1)*v3(2)+v2(2)*v3(1), v2(1)*v3(3)+v2(3)*v3(1), v2(2)*v3(2), v2(2)*v3(3)+v2(3)*v3(2), v2(3)*v3(3);
     0  1   0   0   0   0;
     1  0   0   -1  0   0];

[~, ~, V] = svd(A);
 
W = V(:,end);
 
W = [W(1) W(2) W(3);
     W(2) W(4) W(5);
     W(3) W(5) W(6)];
 
P = Pproj(1:3, :)*inv(Hp);
M = P(:, 1:3);
 
A = chol(inv(M'*W*M));

Ha = eye(4,4);
Ha(1:3,1:3) = inv(A);


%% check results

Xa = euclid(Ha*Hp*Xproj);
figure;
hold on;
X1 = Xa(:,1); X2 = Xa(:,2); X3 = Xa(:,3); X4 = Xa(:,4);
plot3([X1(1) X2(1)], [X1(2) X2(2)], [X1(3) X2(3)]);
plot3([X3(1) X4(1)], [X3(2) X4(2)], [X3(3) X4(3)]);
X5 = Xa(:,5); X6 = Xa(:,6); X7 = X2; X8 = X3;
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
X5 = Xa(:,7); X6 = Xa(:,8); X7 = X1; X8 = X4;
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
X5 = Xa(:,9); X6 = Xa(:,10); X7 = Xa(:,11); X8 = Xa(:,12);
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
X5 = Xa(:,13); X6 = Xa(:,14); X7 = Xa(:,15); X8 = Xa(:,16);
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
X5 = Xa(:,17); X6 = Xa(:,18); X7 = Xa(:,19); X8 = Xa(:,20);
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
X5 = Xa(:,21); X6 = Xa(:,22); X7 = Xa(:,23); X8 = Xa(:,24);
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
axis vis3d
axis equal

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 4. Projective reconstruction (real data)

%% read images
Irgb{1} = double(imread('Data/0000_s.png'))/255;
Irgb{2} = double(imread('Data/0001_s.png'))/255;

I{1} = sum(Irgb{1}, 3) / 3; 
I{2} = sum(Irgb{2}, 3) / 3;

[h, w] = size(I{1});

Ncam = length(I);

%% Compute SIFT keypoints

% (make sure that the sift folder provided in lab2 is on the path)

[points_1, desc_1] = sift(I{1}, 'Threshold', 0.01);
[points_2, desc_2] = sift(I{2}, 'Threshold', 0.01);

%% Match SIFT keypoints between a and b
matches = siftmatch(desc_1, desc_2);
figure;
plotmatches(I{1}, I{2}, points_1(1:2,:), points_2(1:2,:), matches, 'Stacking', 'v');

% p1 and p2 contain the homogeneous coordinates of the matches
p1 = [points_1(1:2, matches(1,:)); ones(1, length(matches))];
p2 = [points_2(1:2, matches(2,:)); ones(1, length(matches))];

[~, inliers] = ransac_fundamental_matrix(p1, p2, 1); 

% show inliers
figure;
plotmatches(I{1}, I{2}, points_1(1:2,:), points_2(1:2,:), matches(:,inliers), 'Stacking', 'v');
title('Inliers');

x1 = p1(:,inliers);
x2 = p2(:,inliers);

%% ToDo: compute a projective reconstruction using the factorization method

% ToDo: show the data points (image correspondences) and the projected
% points (of the reconstructed 3D points) in images 1 and 2. Reuse the code
% in section 'Check projected points' (synthetic experiment).

[Pproj, Xproj] = factorization_method([x1; x2], false);

x_proj = cell(1, 2);
x_d = cell(1, 2);

for i=1:2
    x_proj{i} = euclid(Pproj(3*i-2:3*i, :)*Xproj);
end
x_d{1} = x1;
x_d{2} = x2;

% image 1
figure;
hold on
plot(x_d{1}(1,:),x_d{1}(2,:),'r*');
plot(x_proj{1}(1,:),x_proj{1}(2,:),'bo');
axis equal

% image 2
figure;
hold on
plot(x_d{2}(1,:),x_d{2}(2,:),'r*');
plot(x_proj{2}(1,:),x_proj{2}(2,:),'bo');

%% Compute reprojection error.

% compute the reprojection errors, plot the mean reprojection err

reproj_error = reprojection_error(Pproj(3-2:3, :), Pproj(3*2-2:3*2, :), Xproj, x1, x2);

disp(['Mean projection error: ', num2str(mean(reproj_error))]);

%% Visualize projective reconstruction
Xaux = zeros(3, length(Xproj));
Xaux(1,:) = Xproj(1,:)./Xproj(4,:);
Xaux(2,:) = Xproj(2,:)./Xproj(4,:);
Xaux(3,:) = Xproj(3,:)./Xproj(4,:);
X=Xaux;

figure;
hold on;
X1 = X(:,1); X2 = X(:,2); X3 = X(:,3); X4 = X(:,4);
plot3([X1(1) X2(1)], [X1(2) X2(2)], [X1(3) X2(3)]);
plot3([X3(1) X4(1)], [X3(2) X4(2)], [X3(3) X4(3)]);
X5 = X(:,5); X6 = X(:,6); X7 = X2; X8 = X3;
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
X5 = X(:,7); X6 = X(:,8); X7 = X1; X8 = X4;
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
X5 = X(:,9); X6 = X(:,10); X7 = X(:,11); X8 = X(:,12);
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
X5 = X(:,13); X6 = X(:,14); X7 = X(:,15); X8 = X(:,16);
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
X5 = X(:,17); X6 = X(:,18); X7 = X(:,19); X8 = X(:,20);
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
X5 = X(:,21); X6 = X(:,22); X7 = X(:,23); X8 = X(:,24);
plot3([X5(1) X6(1)], [X5(2) X6(2)], [X5(3) X6(3)]);
plot3([X7(1) X8(1)], [X7(2) X8(2)], [X7(3) X8(3)]);
plot3([X5(1) X7(1)], [X5(2) X7(2)], [X5(3) X7(3)]);
plot3([X6(1) X8(1)], [X6(2) X8(2)], [X6(3) X8(3)]);
axis vis3d
axis equal


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 5. Affine reconstruction (real data)

% ToDo: compute the matrix Hp that updates the projective reconstruction
% to an affine one
%
% You may use the vanishing points given by function 'detect_vps' that 
% implements the method presented in Lezama et al. CVPR 2014
% (http://dev.ipol.im/~jlezama/vanishing_points/)

% This is an example on how to obtain the vanishing points (VPs) from three
% orthogonal lines in image 1

% img_in =  'Data/0000_s.png'; % input image
% folder_out = '.'; % output folder
% manhattan = 1;
% acceleration = 0;
% focal_ratio = 1;
% params.PRINT = 1;
% params.PLOT = 1;
% [horizon, VPs] = detect_vps(img_in, folder_out, manhattan, acceleration, focal_ratio, params);
[h w] = size(I{1})

VPs = load('VPs.mat');

v = VPs.VPs_0;
vp = VPs.VPs_1;


% ToDo: use the vanishing points to compute the matrix Hp that 
%       upgrades the projective reconstruction to an affine reconstruction
V1 = triangulate(v(1:2, 1), vp(1:2, 1), Pproj(1:3,:), Pproj(4:6,:), [w h]); 
V2 = triangulate(v(1:2, 2), vp(1:2, 2), Pproj(1:3,:), Pproj(4:6,:), [w h]); 
V3 = triangulate(v(1:2, 3), vp(1:2, 3), Pproj(1:3,:), Pproj(4:6,:), [w h]);

V1 = V1 ./ (V1(4));
V2 = V2 ./ (V2(4));
V3 = V3 ./ (V3(4));

A = [V1'; V2'; V3'];

[~, ~, V] = svd(A,0);

Ha = V(:,4)';
Ha = Ha(1:3)./Ha(4);
Hp=[eye(3), zeros(3, 1); Ha, 1];

%% Visualize the result

% x1m are the data points in image 1
% Xm are the reconstructed 3D points (projective reconstruction)

x1m = x_proj{1};
Xm = Xproj;

r = interp2(double(Irgb{1}(:,:,1)), x1m(1,:), x1m(2,:));
g = interp2(double(Irgb{1}(:,:,2)), x1m(1,:), x1m(2,:));
b = interp2(double(Irgb{1}(:,:,3)), x1m(1,:), x1m(2,:));
Xe = -euclid(Hp*Xm);
figure; hold on;
scatter3(Xe(1, :), Xe(2, :), Xe(3, :), 2^2, [r' g' b'], 'filled');
axis equal;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 6. Metric reconstruction (real data)

% ToDo: compute the matrix Ha that updates the affine reconstruction
% to a metric one and visualize the result in 3D as in the previous section

v1 = homog(v(:, 1));
v2 = homog(v(:, 2));
v3 = homog(v(:, 3));

A = [v1(1)*v2(1), v1(1)*v2(2)+v1(2)*v2(1), v1(1)*v2(3)+v1(3)*v2(1), v1(2)*v2(2), v1(2)*v2(3)+v1(3)*v2(2), v1(3)*v2(3);
     v1(1)*v3(1), v1(1)*v3(2)+v1(2)*v3(1), v1(1)*v3(3)+v1(3)*v3(1), v1(2)*v3(2), v1(2)*v3(3)+v1(3)*v3(2), v1(3)*v3(3);
     v2(1)*v3(1), v2(1)*v3(2)+v2(2)*v3(1), v2(1)*v3(3)+v2(3)*v3(1), v2(2)*v3(2), v2(2)*v3(3)+v2(3)*v3(2), v2(3)*v3(3);
     0  1   0   0   0   0;
     1  0   0   -1  0   0];

[~, ~, V] = svd(A);
 
W = V(:,end);
 
W = [W(1) W(2) W(3);
     W(2) W(4) W(5);
     W(3) W(5) W(6)];
 
P = Pproj(1:3, :)*inv(Hp);
M = P(:, 1:3);
 
A = chol(inv(M'*W*M));

Ha = eye(4,4);
Ha(1:3,1:3) = inv(A);
  
%% check results

x1m = x_proj{1};
Xm = Xproj;

r = interp2(double(Irgb{1}(:,:,1)), x1m(1,:), x1m(2,:));
g = interp2(double(Irgb{1}(:,:,2)), x1m(1,:), x1m(2,:));
b = interp2(double(Irgb{1}(:,:,3)), x1m(1,:), x1m(2,:));
Xe = -euclid(Ha*Hp*Xm);
figure; hold on;
scatter3(Xe(1, :), Xe(2, :), Xe(3, :), 2^2, [r' g' b'], 'filled');
axis equal;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 7. OPTIONAL: Projective reconstruction from two views

% ToDo: compute a projective reconstruction from the same two views 
% by computing two possible projection matrices from the fundamental matrix
% and one of the epipoles.
% Then update the reconstruction to affine and metric as before (reuse the code).


%% read images
Irgb{1} = double(imread('Data/0000_s.png'))/255;
Irgb{2} = double(imread('Data/0001_s.png'))/255;

I = cell(1, 2);
I{1} = sum(Irgb{1}, 3) / 3; 
I{2} = sum(Irgb{2}, 3) / 3;

[h, w] = size(I{1});
Ncam = 2;

%% Compute SIFT keypoints

% (make sure that the sift folder provided in lab2 is on the path)

[points_1, desc_1] = sift(I{1}, 'Threshold', 0.01);
[points_2, desc_2] = sift(I{2}, 'Threshold', 0.01);

%% Match SIFT keypoints between a and b
matches = siftmatch(desc_1, desc_2);
figure;
plotmatches(I{1}, I{2}, points_1(1:2,:), points_2(1:2,:), matches, 'Stacking', 'v');

% p1 and p2 contain the homogeneous coordinates of the matches
p1 = [points_1(1:2, matches(1,:)); ones(1, length(matches))];
p2 = [points_2(1:2, matches(2,:)); ones(1, length(matches))];

% If using @algebraic_error, choose 0.005 as threshold
[F, inliers] = ransac_fundamental_matrix(p1, p2, 1); 

% show inliers
figure;
plotmatches(I{1}, I{2}, points_1(1:2,:), points_2(1:2,:), matches(:,inliers), 'Stacking', 'v');
title('Inliers');

x1 = p1(:,inliers);
x2 = p2(:,inliers);

[~, ~, V] = svd(F',0);
e = V(:,3);

ex = [0 -e(3) e(2) ; e(3) 0 -e(1) ; -e(2) e(1) 0];

P1 = [eye(3), zeros(3,1)];
P2 = [ex*F, e];

Xproj = zeros(4, length(x1));
for i=1:length(x1)
    Xproj(:, i) = triangulate(euclid(x1(:, i)), euclid(x2(:, i)), P1, P2, [w h]);
end

%% Affine

VPs = load('VPs.mat');
v = VPs.VPs_0;
vp = VPs.VPs_1;

V1 = triangulate(v(1:2, 1), vp(1:2, 1), P1, P2, [w h]); 
V2 = triangulate(v(1:2, 2), vp(1:2, 2), P1, P2, [w h]); 
V3 = triangulate(v(1:2, 3), vp(1:2, 3), P1, P2, [w h]);

V1 = V1 ./ (V1(4));
V2 = V2 ./ (V2(4));
V3 = V3 ./ (V3(4));

A = [V1'; V2'; V3'];

[~, ~, V] = svd(A,0);

Ha = V(:,4)';
Ha = Ha(1:3)./Ha(4);
Hp=[eye(3), zeros(3, 1); Ha, 1];

%% Metric

v1 = homog(v(:, 1));
v2 = homog(v(:, 2));
v3 = homog(v(:, 3));

A = [v1(1)*v2(1), v1(1)*v2(2)+v1(2)*v2(1), v1(1)*v2(3)+v1(3)*v2(1), v1(2)*v2(2), v1(2)*v2(3)+v1(3)*v2(2), v1(3)*v2(3);
     v1(1)*v3(1), v1(1)*v3(2)+v1(2)*v3(1), v1(1)*v3(3)+v1(3)*v3(1), v1(2)*v3(2), v1(2)*v3(3)+v1(3)*v3(2), v1(3)*v3(3);
     v2(1)*v3(1), v2(1)*v3(2)+v2(2)*v3(1), v2(1)*v3(3)+v2(3)*v3(1), v2(2)*v3(2), v2(2)*v3(3)+v2(3)*v3(2), v2(3)*v3(3);
     0  1   0   0   0   0;
     1  0   0   -1  0   0];

[~, ~, V] = svd(A);
 
W = V(:,end);
 
W = [W(1) W(2) W(3);
     W(2) W(4) W(5);
     W(3) W(5) W(6)];
 
P = P1*inv(Hp);
M = P(:, 1:3);
 
A = chol(inv(M'*W*M));

Ha = eye(4,4);
Ha(1:3,1:3) = inv(A);
  
%% check results

x1m = x1;
Xm = Xproj;

r = interp2(double(Irgb{1}(:,:,1)), x1m(1,:), x1m(2,:));
g = interp2(double(Irgb{1}(:,:,2)), x1m(1,:), x1m(2,:));
b = interp2(double(Irgb{1}(:,:,3)), x1m(1,:), x1m(2,:));
Xe = -euclid(Ha*Hp*Xm);
figure; hold on;
scatter3(Xe(1, :), Xe(2, :), Xe(3, :), 2^2, [r' g' b'], 'filled');
axis equal;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 8. OPTIONAL: Projective reconstruction from more than two views

% ToDo: extend the function that computes the projective reconstruction 
% with the factorization method to the case of three views. You may use 
% the additional image '0002_s.png'
% Then update the reconstruction to affine and metric.

%% read images
Irgb{1} = double(imread('Data/0000_s.png'))/255;
Irgb{2} = double(imread('Data/0001_s.png'))/255;
Irgb{3} = double(imread('Data/0002_s.png'))/255;

I = cell(1, 3);
I{1} = sum(Irgb{1}, 3) / 3; 
I{2} = sum(Irgb{2}, 3) / 3;
I{3} = sum(Irgb{3}, 3) / 3;

[h, w] = size(I{1});
Ncam = length(I);

%% Compute SIFT keypoints

% (make sure that the sift folder provided in lab2 is on the path)

[points_1, desc_1] = sift(I{1}, 'Threshold', 0.01);
[points_2, desc_2] = sift(I{2}, 'Threshold', 0.01);
[points_3, desc_3] = sift(I{3}, 'Threshold', 0.01);

points_1 = points_1(1:2, :);
points_2 = points_2(1:2, :);
points_3 = points_3(1:2, :);

%% Match SIFT keypoints between a and b
matches_1_2 = siftmatch(desc_1, desc_2);
matches_1_3 = siftmatch(desc_1, desc_3);

P = zeros(3, length(points_1));
P(1, matches_1_2(1, :)) = matches_1_2(1, :);
P(2, matches_1_2(1, :)) = matches_1_2(2, :);
P(3, matches_1_3(1, :)) = matches_1_3(2, :);

P = P(:, min(P) > 0);

p1 = homog(points_1(:, P(1, :)));
p2 = homog(points_2(:, P(2, :)));
p3 = homog(points_3(:, P(3, :)));

% If using @algebraic_error, choose 0.005 as threshold
[~, inliers1] = ransac_fundamental_matrix(p1, p2, 2); 
[~, inliers2] = ransac_fundamental_matrix(p1, p3, 2);

inliers = intersect(inliers1, inliers2);

x1 = p1(:,inliers);
x2 = p2(:,inliers);
x3 = p3(:,inliers);

%% ToDo: compute a projective reconstruction using the factorization method

% ToDo: show the data points (image correspondences) and the projected
% points (of the reconstructed 3D points) in images 1 and 2. Reuse the code
% in section 'Check projected points' (synthetic experiment).

[Pproj, Xproj] = factorization_method([x1; x2; x3], false);

x_proj = cell(1, Ncam);
x_d = cell(1, Ncam);

for i=1:Ncam
    x_proj{i} = euclid(Pproj(3*i-2:3*i, :)*Xproj);
end

x_d{1} = x1;
x_d{2} = x2;
x_d{3} = x3;

% image 1
figure;
hold on
plot(x_d{1}(1,:),x_d{1}(2,:),'r*');
plot(x_proj{1}(1,:),x_proj{1}(2,:),'bo');
axis equal

% image 2
figure;
hold on
plot(x_d{2}(1,:),x_d{2}(2,:),'r*');
plot(x_proj{2}(1,:),x_proj{2}(2,:),'bo');

% image 3
figure;
hold on
plot(x_d{3}(1,:),x_d{3}(2,:),'r*');
plot(x_proj{3}(1,:),x_proj{3}(2,:),'bo');

%% Affine

VPs = load('VPs.mat');
v = VPs.VPs_0;
vp = VPs.VPs_1;

V1 = triangulate(v(1:2, 1), vp(1:2, 1), Pproj(1:3,:), Pproj(4:6,:), [w h]); 
V2 = triangulate(v(1:2, 2), vp(1:2, 2), Pproj(1:3,:), Pproj(4:6,:), [w h]); 
V3 = triangulate(v(1:2, 3), vp(1:2, 3), Pproj(1:3,:), Pproj(4:6,:), [w h]);

V1 = V1 ./ (V1(4));
V2 = V2 ./ (V2(4));
V3 = V3 ./ (V3(4));

A = [V1'; V2'; V3'];

[~, ~, V] = svd(A,0);

Ha = V(:,4)';
Ha = Ha(1:3)./Ha(4);
Hp=[eye(3), zeros(3, 1); Ha, 1];
%% Metric

v1 = homog(v(:, 1));
v2 = homog(v(:, 2));
v3 = homog(v(:, 3));

A = [v1(1)*v2(1), v1(1)*v2(2)+v1(2)*v2(1), v1(1)*v2(3)+v1(3)*v2(1), v1(2)*v2(2), v1(2)*v2(3)+v1(3)*v2(2), v1(3)*v2(3);
     v1(1)*v3(1), v1(1)*v3(2)+v1(2)*v3(1), v1(1)*v3(3)+v1(3)*v3(1), v1(2)*v3(2), v1(2)*v3(3)+v1(3)*v3(2), v1(3)*v3(3);
     v2(1)*v3(1), v2(1)*v3(2)+v2(2)*v3(1), v2(1)*v3(3)+v2(3)*v3(1), v2(2)*v3(2), v2(2)*v3(3)+v2(3)*v3(2), v2(3)*v3(3);
     0  1   0   0   0   0;
     1  0   0   -1  0   0];

[~, ~, V] = svd(A);
 
W = V(:,end);
 
W = [W(1) W(2) W(3);
     W(2) W(4) W(5);
     W(3) W(5) W(6)];
 
P = Pproj(1:3, :)*inv(Hp);
M = P(:, 1:3);
 
A = chol(inv(M'*W*M));

Ha = eye(4,4);
Ha(1:3,1:3) = inv(A);
  
%% check results

x1m = x1;
Xm = Xproj;

r = interp2(double(Irgb{1}(:,:,1)), x1m(1,:), x1m(2,:));
g = interp2(double(Irgb{1}(:,:,2)), x1m(1,:), x1m(2,:));
b = interp2(double(Irgb{1}(:,:,3)), x1m(1,:), x1m(2,:));
Xe = -euclid(Ha*Hp*Xm);
figure; hold on;
scatter3(Xe(1, :), Xe(2, :), Xe(3, :), 2^2, [r' g' b'], 'filled');
axis equal;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 9. OPTIONAL: Any other improvement you may incorporate 

% Add a 4th view, incorporate new 3D points by triangulation, 
% incorporate new views by resectioning, 
% apply any kind of processing on the point cloud, ...)

%% The factorization method works with any number of views

Irgb{1} = double(imread('Data/0000_s.png'))/255;
Irgb{2} = double(imread('Data/0001_s.png'))/255;
Irgb{3} = double(imread('Data/0002_s.png'))/255;
Irgb{4} = double(imread('Data/0003_s.png'))/255;

I{1} = sum(Irgb{1}, 3) / 3; 
I{2} = sum(Irgb{2}, 3) / 3;
I{3} = sum(Irgb{3}, 3) / 3;
I{4} = sum(Irgb{4}, 3) / 3;

[h, w] = size(I{1});
Ncam = 4;

[points_1, desc_1] = sift(I{1}, 'Threshold', 0.01);
[points_2, desc_2] = sift(I{2}, 'Threshold', 0.01);
[points_3, desc_3] = sift(I{3}, 'Threshold', 0.01);
[points_4, desc_4] = sift(I{4}, 'Threshold', 0.01);

points_1 = points_1(1:2, :);
points_2 = points_2(1:2, :);
points_3 = points_3(1:2, :);
points_4 = points_4(1:2, :);

matches_1_2 = siftmatch(desc_1, desc_2);
matches_1_3 = siftmatch(desc_1, desc_3);
matches_1_4 = siftmatch(desc_1, desc_4);

P = zeros(Ncam, length(points_1));
P(1, matches_1_2(1, :)) = matches_1_2(1, :);
P(2, matches_1_2(1, :)) = matches_1_2(2, :);
P(3, matches_1_3(1, :)) = matches_1_3(2, :);
P(4, matches_1_4(1, :)) = matches_1_4(2, :);

P = P(:, min(P) > 0);

p1 = homog(points_1(:, P(1, :)));
p2 = homog(points_2(:, P(2, :)));
p3 = homog(points_3(:, P(3, :)));
p4 = homog(points_4(:, P(4, :)));

[~, inliers1] = ransac_fundamental_matrix(p1, p2, 2); 
[~, inliers2] = ransac_fundamental_matrix(p1, p3, 2);
[~, inliers3] = ransac_fundamental_matrix(p1, p4, 2);

inliers = intersect(inliers1, intersect(inliers2, inliers3));

x1 = p1(:,inliers);
x2 = p2(:,inliers);
x3 = p3(:,inliers);
x4 = p4(:,inliers);

[Pproj, Xproj] = factorization_method([x1; x2; x3; x4], false);

x_proj = cell(1, Ncam);
x_d = cell(1, Ncam);

for i=1:Ncam
    x_proj{i} = euclid(Pproj(3*i-2:3*i, :)*Xproj);
end

x_d{1} = x1;
x_d{2} = x2;
x_d{3} = x3;
x_d{4} = x4;

% image 1
figure;
hold on
plot(x_d{1}(1,:),x_d{1}(2,:),'r*');
plot(x_proj{1}(1,:),x_proj{1}(2,:),'bo');
axis equal

% image 2
figure;
hold on
plot(x_d{2}(1,:),x_d{2}(2,:),'r*');
plot(x_proj{2}(1,:),x_proj{2}(2,:),'bo');

% image 3
figure;
hold on
plot(x_d{3}(1,:),x_d{3}(2,:),'r*');
plot(x_proj{3}(1,:),x_proj{3}(2,:),'bo');

% image 4
figure;
hold on
plot(x_d{4}(1,:),x_d{4}(2,:),'r*');
plot(x_proj{4}(1,:),x_proj{4}(2,:),'bo');

%% Affine

VPs = load('VPs.mat');
v = VPs.VPs_0;
vp = VPs.VPs_1;

V1 = triangulate(v(1:2, 1), vp(1:2, 1), Pproj(1:3,:), Pproj(4:6,:), [w h]); 
V2 = triangulate(v(1:2, 2), vp(1:2, 2), Pproj(1:3,:), Pproj(4:6,:), [w h]); 
V3 = triangulate(v(1:2, 3), vp(1:2, 3), Pproj(1:3,:), Pproj(4:6,:), [w h]);

V1 = V1 ./ (V1(4));
V2 = V2 ./ (V2(4));
V3 = V3 ./ (V3(4));

A = [V1'; V2'; V3'];

[~, ~, V] = svd(A,0);

Ha = V(:,4)';
Ha = Ha(1:3)./Ha(4);
Hp=[eye(3), zeros(3, 1); Ha, 1];
%% Metric

v1 = homog(v(:, 1));
v2 = homog(v(:, 2));
v3 = homog(v(:, 3));

A = [v1(1)*v2(1), v1(1)*v2(2)+v1(2)*v2(1), v1(1)*v2(3)+v1(3)*v2(1), v1(2)*v2(2), v1(2)*v2(3)+v1(3)*v2(2), v1(3)*v2(3);
     v1(1)*v3(1), v1(1)*v3(2)+v1(2)*v3(1), v1(1)*v3(3)+v1(3)*v3(1), v1(2)*v3(2), v1(2)*v3(3)+v1(3)*v3(2), v1(3)*v3(3);
     v2(1)*v3(1), v2(1)*v3(2)+v2(2)*v3(1), v2(1)*v3(3)+v2(3)*v3(1), v2(2)*v3(2), v2(2)*v3(3)+v2(3)*v3(2), v2(3)*v3(3);
     0  1   0   0   0   0;
     1  0   0   -1  0   0];

[~, ~, V] = svd(A);
 
W = V(:,end);
 
W = [W(1) W(2) W(3);
     W(2) W(4) W(5);
     W(3) W(5) W(6)];
 
P = Pproj(1:3, :)*inv(Hp);
M = P(:, 1:3);
 
A = chol(inv(M'*W*M));

Ha = eye(4,4);
Ha(1:3,1:3) = inv(A);
  
%% check results

x1m = x1;
Xm = Xproj;

r = interp2(double(Irgb{1}(:,:,1)), x1m(1,:), x1m(2,:));
g = interp2(double(Irgb{1}(:,:,2)), x1m(1,:), x1m(2,:));
b = interp2(double(Irgb{1}(:,:,3)), x1m(1,:), x1m(2,:));
Xe = -euclid(Ha*Hp*Xm);
figure; hold on;
scatter3(Xe(1, :), Xe(2, :), Xe(3, :), 2^2, [r' g' b'], 'filled');
axis equal;

