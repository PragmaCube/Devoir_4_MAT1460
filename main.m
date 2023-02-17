%%%%%%%%%%%%%
% Codé par 20244742
% Équipe : 
%%%%%%%%%%%%%

%%%%%%%%%%%%%
% Données récoltées depuis le document (référence 1)
altitude_ft = [130000, 125000, 120000, 115000, 110000, 105000, 100000, 95000, 90000, 85000, 80000];
g_coef = [0.9876, 0.9881, 0.9886, 0.9891, 0.9895, 0.99, 0.9905, 0.9910, 0.9914, 0.9919, 0.9924];
air_density = [0.004213, 0.0052871, 0.006487, 0.0083956, 0.01647, 0.013547, 0.017102, 0.021187, 0.027391, 0.034754, 0.044173];
%%%%%%%%%%%%%

%%%%%%%%%%%%%
% On adapte les mesures et on applique les coefficients sur g
altitude_m = altitude_ft.* 0.3048;
g_measures = g_coef.* 9.81;
%%%%%%%%%%%%%

%%%%%%%%%%%%%
% On calcule les prédictions pour en faire des graphes
density_prediction = 2 * 1.8214 * exp(-1.8 * altitude_m / 10000);
g_prediction = altitude_m * -0.000003 + 9.8086;
%%%%%%%%%%%%%

%%%%%%%%%%%%%
% Permet d'afficher les courbes pour l'accélération gravitationnelle
plot(altitude_m, g_measures, altitude_m, g_prediction);
title("Accélération gravitationnelle en fonction de l'altitude");
legend("Mesures", "Prédiction")
xlabel('Altitude (m)');
ylabel('Accélération (m.s^{-2})');
%%%%%%%%%%%%%

%%%%%%%%%%%%%
% Permet d'afficher les courbes pour la masse volumique
plot(altitude_m, air_density, altitude_m, density_prediction);
title("Masse volumique de l'air en fonction de l'altitude");
legend("Mesures", "Prédiction")
xlabel('Altitude (m)');
ylabel('Masse volumique (kg.m^{-3})');
%%%%%%%%%%%%%

%%%%%%%%%%%%%
% Conditions initiales et autres valeurs à initialiser
t0 = 0;
tfinal = 100;
y0 = [38969.3; 0];
x_ = linspace(15143.9, 38980, 73);
t_ = linspace(0, 100, 73);
%%%%%%%%%%%%%

%%%%%%%%%%%%%
% On calcule les vitesses pour la méthode dans le but d'afficher
% la courbe.
speed_second_method = - sqrt(0.99 * 9.81 / 0.5 / 0.0135 * 100) * tanh(-acosh(exp(- 0.02 * 0.0135 * (x_ - 38969.3))));
%%%%%%%%%%%%%


[t,x] = ode45(@f,[t0 tfinal], y0);
min = [0, 0];

pos = 1:73;
vit = 1:73;

%%%%%%%%%%%%%
% Recherche de la vitesse terminale (on cherche la valeur la plus
% faible puisque les données sont négatives).
for i = 1:73
    pos(i) = x(i, 1);
    vit(i) = x(i, 2);
    if x(i, 2) < min(2)
        min(1) = x(i, 1);
        min(2) = x(i, 2);
    end
end
%%%%%%%%%%%%%

%%%%%%%%%%%%%
% Affichage des vitesse en fonction de l'altitude
disp("Vitesse : " + min(2) + "Altitude : " +  min(1));
plot(pos, - vit, x_, speed_second_method, x_, linspace(372.32, 372.32, 73));
title("Vitesse en fonction de l'altitude");
legend("Méthode la plus difficile", "Méthode intermédiaire", "Méthode la plus simple");
xlabel('Altitude (m)');
ylabel('Vitesse (m.s^{-1})');
%%%%%%%%%%%%%

%%%%%%%%%%%%%
% Fonction codant le système
function dxdt = f(t,x)
    % Substitutions effectuées pour résoudre le système :
    % x1 = x(t)
    % x2 = v(t)
    % dxdt1 = v(t) = x2
    % dxdt2 = v'(t) = x2'
    
    dxdt = [x(2); (0.000003 * x(1) - 9.8086) + 2 / 100 * x(2)^2 * 0.5 * 1.8214 * exp(1.8 * x(1) / -10000)];
end
%%%%%%%%%%%%%
