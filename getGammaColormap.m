function gammaColorMap = getGammaColormap(gamma_max)

% We want a continues span of colors from 0 to 1, an abrupt change at 1,
% and then a continues span to gamma_max.

m = 25;

color_at_0 = [ 0 0 1 ];
color_at_1_below = [ .8 .8 1 ];
color_at_1_above = [ 1 1 1 ];
color_at_gamma_max = [ 1 0 0 ];

gammaColorMap = zeros(gamma_max*m+1,3);
[r, c] = size(gammaColorMap);

gammaColorMap(1:(m+1),:) =  ones((m+1),1)*color_at_0 + (((1:(m+1))-1)/m)'*(color_at_1_below - color_at_0);

gammaColorMap((m+2):r,:) =  ones(r-(m+1),1)*color_at_1_above + (((1:(r-(m+1)))-1)/(r-(m+1)-1))'*(color_at_gamma_max - color_at_1_above);

