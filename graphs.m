% MATLAB Script to Plot Accelerometer and Gyroscope Data for IMUs


%% Extract Data from Simulation Output


imu1a_measurements = out


% IMU 1
% Measurement Data
imu1_meas = out.logsout{1}.Values;
w_x_imu1 = imu1_meas.wx;
w_y_imu1 = imu1_meas.wy;
w_z_imu1 = imu1_meas.wz;
a_x_imu1 = imu1_meas.ax;
a_y_imu1 = imu1_meas.ay;
a_z_imu1 = imu1_meas.az;

% Ground Truth Data
imu1_gt = out.logsout{2}.Values;
w_x_gt_imu1 = imu1_gt.wx;
w_y_gt_imu1 = imu1_gt.wy;
w_z_gt_imu1 = imu1_gt.wz;
a_x_gt_imu1 = imu1_gt.ax;
a_y_gt_imu1 = imu1_gt.ay;
a_z_gt_imu1 = imu1_gt.az;

% IMU 2
% Measurement Data
imu2_meas = out.logsout{4}.Values;
w_x_imu2 = imu2_meas.wx;
w_y_imu2 = imu2_meas.wy;
w_z_imu2 = imu2_meas.wz;
a_x_imu2 = imu2_meas.ax;
a_y_imu2 = imu2_meas.ay;
a_z_imu2 = imu2_meas.az;

% Ground Truth Data
imu2_gt = out.logsout{3}.Values;
w_x_gt_imu2 = imu2_gt.wx;
w_y_gt_imu2 = imu2_gt.wy;
w_z_gt_imu2 = imu2_gt.wz;
a_x_gt_imu2 = imu2_gt.ax;
a_y_gt_imu2 = imu2_gt.ay;
a_z_gt_imu2 = imu2_gt.az;

%% Define Plotting Function
function plotIMUData(time, measData, gtData, axisLabel, imuNumber, sensorType)
    figure('Name', sprintf('%s %s-axis IMU%d', sensorType, axisLabel, imuNumber), 'NumberTitle', 'off');
    plot(time, measData, 'b', time, gtData, 'r--', 'LineWidth', 1.5);
    legend("Measurement Data", "Ground Truth", 'Location', 'best');
    xlabel("Time (s)");
    ylabel(sprintf("%s (%s)", sensorType, axisLabel));
    title(sprintf("%s along the %s axis for IMU%d", sensorType, axisLabel, imuNumber));
    grid on;
    pbaspect([2 1 1]); % Set aspect ratio to make plots wider
end

%% Plot Gyroscope Data for IMU 1
plotIMUData(w_x_imu1.Time, w_x_imu1.Data, w_x_gt_imu1.Data, 'rad/s', 1, 'Gyroscope');
plotIMUData(w_y_imu1.Time, w_y_imu1.Data, w_y_gt_imu1.Data, 'rad/s', 1, 'Gyroscope');
plotIMUData(w_z_imu1.Time, w_z_imu1.Data, w_z_gt_imu1.Data, 'rad/s', 1, 'Gyroscope');

%% Plot Accelerometer Data for IMU 1
plotIMUData(a_x_imu1.Time, a_x_imu1.Data, a_x_gt_imu1.Data, 'm/s^2', 1, 'Accelerometer');
plotIMUData(a_y_imu1.Time, a_y_imu1.Data, a_y_gt_imu1.Data, 'm/s^2', 1, 'Accelerometer');
plotIMUData(a_z_imu1.Time, a_z_imu1.Data, a_z_gt_imu1.Data, 'm/s^2', 1, 'Accelerometer');

%% Plot Gyroscope Data for IMU 2
plotIMUData(w_x_imu2.Time, w_x_imu2.Data, w_x_gt_imu2.Data, 'rad/s', 2, 'Gyroscope');
plotIMUData(w_y_imu2.Time, w_y_imu2.Data, w_y_gt_imu2.Data, 'rad/s', 2, 'Gyroscope');
plotIMUData(w_z_imu2.Time, w_z_imu2.Data, w_z_gt_imu2.Data, 'rad/s', 2, 'Gyroscope');

%% Plot Accelerometer Data for IMU 2
plotIMUData(a_x_imu2.Time, a_x_imu2.Data, a_x_gt_imu2.Data, 'm/s^2', 2, 'Accelerometer');
plotIMUData(a_y_imu2.Time, a_y_imu2.Data, a_y_gt_imu2.Data, 'm/s^2', 2, 'Accelerometer');
plotIMUData(a_z_imu2.Time, a_z_imu2.Data, a_z_gt_imu2.Data, 'm/s^2', 2, 'Accelerometer');

%% (Optional) Save Figures
% Uncomment the following lines to save the figures automatically
% saveas(figure(1), 'Gyroscope_IMU1_X.png');
% saveas(figure(2), 'Gyroscope_IMU1_Y.png');
% saveas(figure(3), 'Gyroscope_IMU1_Z.png');
% saveas(figure(4), 'Accelerometer_IMU1_X.png');
% saveas(figure(5), 'Accelerometer_IMU1_Y.png');
% saveas(figure(6), 'Accelerometer_IMU1_Z.png');
% saveas(figure(7), 'Gyroscope_IMU2_X.png');
% saveas(figure(8), 'Gyroscope_IMU2_Y.png');
% saveas(figure(9), 'Gyroscope_IMU2_Z.png');
% saveas(figure(10), 'Accelerometer_IMU2_X.png');
% saveas(figure(11), 'Accelerometer_IMU2_Y.png');
% saveas(figure(12), 'Accelerometer_IMU2_Z.png');

