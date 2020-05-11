% x = (v,r)
% fun: (v,r) --> (dr/dt, dv/dt)
format long g;
close all;
clc;
clear all;

h = 1e-2;
time = 2;
steps = time / h;
initial = [0, 0, 1, 1]';

%Amb RK4 pur
solution = RK4(initial, h, @gravFunctionV, steps);
figure;
plot(solution(1, :), solution(2, :));

%Amb AB4
solution1 = AB4(solution(:, 1:4), h, @gravFunctionV, steps);
figure;
plot(solution1(1, :), solution1(2, :));

% Calculem el que considerem la solucio "exacte"
hext = 1e-4;
points = time / hext +1;
exactSolution = RK4(initial, hext, @gravFunctionV, points);
%exactSolution = AB4(solution(:, 1:4), hext, @gravFunctionV, steps);
rext = exactSolution(:, end);

rr=[];
errors=[];
ns = -4:0.01:-1;
haches = 10.^ns;
%haches = 1e-4:0.001:0.1;
for h = haches
    points = time/h +1;
    solution1 = RK4(initial, h, @gravFunctionV, points);
    r=solution1(:,end);
    rr=[rr r];
    disp(r-rext)
    errors=[errors norm(r-rext)];
end

figure;
loglog(haches,errors)