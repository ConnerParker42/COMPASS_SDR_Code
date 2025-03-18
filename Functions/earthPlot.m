function earthPlot(position)

% extract globe data
chart = load('world_coastline_low.txt');
chart_long = chart(:,1);
chart_lat = chart(:,2);
EarthRad = 6371e3;
n = numel(chart_long);

% pre-allocate memory
xposE = zeros(n,1);
yposE = zeros(n,1);
zposE = zeros(n,1);

% convert from spherical to cartesian
for i=1:n

    [x,y,z] = sph2cart(deg2rad(chart_long(i,1)),deg2rad(chart_lat(i,1)),EarthRad);
    xposE(i,1) = x;
    yposE(i,1) = y;
    zposE(i,1) = z;
    
end

figure()
plot3(xposE,yposE,zposE,'k','linewidth',1.5)
axis equal
grid on
hold on
scatter3(position(1),position(2),position(3),'+','red','linewidth',1.5)
xlabel('x-distance [m]')
ylabel('y-distance [m]')
zlabel('z-distance [m]')
title('Target Location on Earth')

end