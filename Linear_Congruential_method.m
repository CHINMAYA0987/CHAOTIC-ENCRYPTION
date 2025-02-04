clc;clear all; close all;
% x(1) = 0;
% y(1) = 0;
% a = 9;
% c = 1;
% m = 3.62;
% for i= 2:50
% x(i+1) = mod((x(i-1)*m)+c, a);
% end
% X = x;
% for i= 2:50
% y(i+1) = mod((y(i-1)*m)+c, a);
% end
% Y = y
% inEllipse = (5 * X .^ 2 + 21 * X .* Y + 25 * Y .^ 2) <= 9
% 
% xInEllipse = X(inEllipse)
% yInEllipse = Y(inEllipse)
% fprintf('Min x = %f, max x = %f\n', min(xInEllipse), max(xInEllipse));
% fprintf('Min y = %f, max y = %f\n', min(yInEllipse), max(yInEllipse));



% plot(xInEllipse, yInEllipse, '.', 'MarkerSize', 5)
% % Put the axes origin at the center.
% ax = gca;
% ax.XAxisLocation = 'origin';
% ax.YAxisLocation = 'origin';
% axis square;
% grid on;
% 
% % Enlarge figure to full screen.
% set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% xlabel('x', 'FontSize', fontSize);
% ylabel('y', 'FontSize', fontSize);
% title('Random Locations Within an Ellipse', 'FontSize', fontSize);

% ===================================================================
% *********ACTUAL WORKING OF LCG*************
ranNu(1) = 3.4;
a = 3;
c = 5;
m = 7;
for i = 2:20
    ranNu(i) = mod((ranNu(i-1)*a + c), m)
end
[so,in] = sort(ranNu)

% ====================================================================
% ***********WORKING OF CLCG*******************
