// ===================================================
// Случай 3: Осциллятор с затуханием и внешней силой
// Уравнение: x'' + 0.4x' + 5.5x = 8·sin(3t)
// Начальные условия: x0 = -0.7, v0 = 0.8
// Интервал: t ∈ [0; 54], шаг 0.05
// ===================================================

funcprot(0);
clear; clf; clc;

// Создаём директории
mkdir("../results");
mkdir("../plots");

// Параметры
omega_sq = 5.5;     // ω₀²
gamma = 0.2;        // коэффициент затухания (2γ = 0.4 → γ = 0.2)
amplitude = 8;      // амплитуда внешней силы
drive_freq = 3;     // частота внешней силы
t0 = 0;
x0 = -0.7;
v0 = 0.8;
t = 0:0.05:54;

// Внешняя сила
function f_val = f(t)
    f_val = amplitude * sin(drive_freq * t);
endfunction

// Система дифференциальных уравнений
function dx = ode_system(t, x_vec)
    dx(1) = x_vec(2);
    dx(2) = -omega_sq * x_vec(1) - gamma * x_vec(2) + f(t); // + f(t), так как в уравнении она справа
endfunction

// Решение системы ОДУ
sol = ode([x0; v0], t0, t, ode_system);

// Извлечение результатов
x = sol(1, :);
v = sol(2, :);

// Сохранение данных
csv_data = [t' x' v'];
write_csv(csv_data, "../results/case3_data.csv");

// ==================== Построение графиков ====================

scf(3);
subplot(2,1,1);
plot(t, x, 'b-', 'LineWidth', 1.5);
xlabel('Время t, с');
ylabel('Смещение x');
title('Случай 3: Осциллятор с затуханием и внешней силой (x'' + 0.4x'' + 5.5x = 8·sin(3t))');
xgrid();
legend('x(t)');

subplot(2,1,2);
plot(x, v, 'r-', 'LineWidth', 1.5);
xlabel('Смещение x');
ylabel('Скорость v = x''');
title('Фазовый портрет (с затуханием и внешней силой)');
xgrid();
legend('Фазовая траектория');

// Сохранение графика
xs2png(gcf(), "../plots/case3_plots.png");

// ==================== Анализ установившихся колебаний ====================

// Находим установившийся режим (после 40 секунд)
idx_steady = find(t > 40);
if ~isempty(idx_steady) then
    x_steady = x(idx_steady);
    t_steady = t(idx_steady);
    
    // Находим амплитуду установившихся колебаний
    amplitude_steady = (max(x_steady) - min(x_steady)) / 2;
    amp_status = string(amplitude_steady);
else
    amp_status = "не удалось определить";
end

// Вывод информации
disp("===================================================");
disp("Случай 3: Осциллятор с затуханием и внешней силой");
disp("===================================================");
disp("Параметры:");
disp("  ω₀² = " + string(omega_sq));
disp("  γ = " + string(gamma));
disp("  Амплитуда внешней силы: " + string(amplitude));
disp("  Частота внешней силы: " + string(drive_freq));
disp("  Начальные условия: x0 = " + string(x0) + ", v0 = " + string(v0));
disp("  Количество точек: " + string(length(t)));
disp("  Максимальное смещение: " + string(max(x)));
disp("  Минимальное смещение: " + string(min(x)));
disp("  Амплитуда установившихся колебаний: " + amp_status);
disp("  Частота установившихся колебаний: " + string(drive_freq));
disp("===================================================");
disp("График сохранён: ../plots/case3_plots.png");
disp("Данные сохранены: ../results/case3_data.csv");
