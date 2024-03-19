% motor parameters
P = 7460; Tfl = 49.89;
Vs = 230; f = 50;
Rs = 0.8; Rr = 0.8;
Is = 12.21; Ir = 12.52; Im = -1.15j;
Xs = 2.85; Xr = 2.85; Xm = 200.12;
Ns = 1500; ws = Ns * (2*pi/60);
s = linspace(1, 0, 1000); sfl = 0.048;

% rotor current
Ir = Vs ./ ( (Rs+(Rr./s)).^2  +  1j*(Xs + Xr)^2 ) .^0.5;

% torque-speed
Td = (3 * Rr * abs(Ir).^2) ./ (s * ws);
Tfl = interp1(s, Td, sfl);

% stator current-speed
Is = abs(Ir + Im);
Isfl = interp1(s, Is, sfl);

% plot torque-speed
figure; hold on; grid on;
plot(s, Td, 'b'); plot(sfl, Tfl, 'o');
text(sfl + 0.3, Tfl, ['(' num2str(sfl) ', ' num2str(Tfl) ') ->'], 'Color','red');
xlabel('Slip'); ylabel('Torque (N.m)');
title('Motor Torque-Speed Characteristic');
set(gca, 'XDir', 'reverse');

% plot stator current-speed
figure; hold on; grid on;
plot(s, Is, 'b'); plot(sfl, Isfl, 'o');
text(sfl + 0.3, Isfl, ['(' num2str(sfl) ', ' num2str(Isfl) ') ->'], 'Color','red');
xlabel('Slip'); ylabel('Stator Current (A)');
title('Stator Current-Speed Characteristic');
set(gca, 'XDir', 'reverse');

disp(Td(1));
% Record starting current
starting_current = Is(1);
disp(['Starting Current: ' num2str(starting_current) ' A']);
