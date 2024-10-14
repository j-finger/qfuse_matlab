%% IMU Setup
% MATLAB script to setup initial IMU parameters
clc; clear; close all;

%% Simulation Parameters Setup

% Sheet and Model names
modelName = 'doublePendulumIMU';
SHEET_NAME_A = 'IMU attached to link 1';
SHEET_NAME_B = 'IMU attached to link 2';

% Accel & Gyro FS range settings
gyro_FS_low = 0;
gyro_FS_high = 3;
accel_FS_low = 0;
accel_FS_high = 3;

% Setting the sampling rate for the system
Fs = 100;
Fs_time = 1/Fs;

% I am setting up an array of IMU paraters for each IMU. There are 2 joins,
% each with 4 IMU's per joint. 2 will be set in low range/high resolution, 2 set 
% in high range/low resolution
IMUsettingsList = {
    % 'IMU name', accel_fs_range, gyro_fs_range
    {'IMU 1a', gyro_FS_low, accel_FS_low}, ...
    {'IMU 2a', gyro_FS_high, accel_FS_high}, ...
    {'IMU 3a', gyro_FS_low, accel_FS_low}, ...
    {'IMU 4a', gyro_FS_high, accel_FS_high}, ...
    {'IMU 1b', gyro_FS_low, accel_FS_low}, ...
    {'IMU 2b', gyro_FS_high, accel_FS_high}, ...
    {'IMU 3b', gyro_FS_low, accel_FS_low}, ...
    {'IMU 4b', gyro_FS_high, accel_FS_high}
};


%% Run the Simulation
% Make sure the Simulink model is loaded
if ~bdIsLoaded(modelName)
    open_system(modelName);
end

%% Set Parameters for each IMU
for k = 1:length(IMUsettingsList)
    % Declare variables for loop
    IMUname = IMUsettingsList{k}{1};
    IMUgyro_FS = IMUsettingsList{k}{2};
    IMUaccel_FS = IMUsettingsList{k}{3};
    
    % Get the sub-sheet name
    if contains(IMUname, 'a')
        SHEET_NAME = SHEET_NAME_A;
    else
        SHEET_NAME = SHEET_NAME_B;
    end

    % Build the path to the IMU block
    IMU_PATH = [ modelName '/' SHEET_NAME '/' IMUname ];

    % Calculate and set the IMU parameters
    setIMUparameters(IMU_PATH, IMUgyro_FS, IMUaccel_FS);
end

% Run the simulation
out = sim(modelName);

% % Assign IMU datasets from each logged measurement
% imu1a_measurements = out.logsout.get("Sensor1a").Values;
% imu2a_measurements = out.logsout.get("Sensor2a").Values;
% imu3a_measurements = out.logsout.get("Sensor3a").Values;
% imu4a_measurements = out.logsout.get("Sensor4a").Values;
% imu1b_measurements = out.logsout.get("Sensor1b").Values;
% imu2b_measurements = out.logsout.get("Sensor2b").Values;
% imu3b_measurements = out.logsout.get("Sensor3b").Values;
% imu4b_measurements = out.logsout.get("Sensor4b").Values;
% 
% % Assign ground truth datasets from each logged measurement
% groundTruthA = out.logsout.get("GroundTruth1").Values;
% groundTruthB = out.logsout.get("GroundTruth2").Values;
% 
% x_axis_dataset_a = [
%     groundTruthA.ax.Data, ...
%     imu1a_measurements.ax.Data, ...
%     imu2a_measurements.ax.Data, ...
%     imu3a_measurements.ax.Data, ...
%     imu4a_measurements.ax.Data, ...
% ];
% 
% z_axis_dataset_a = [
%     groundTruthA.az.Data, ...
%     imu1a_measurements.az.Data, ...
%     imu2a_measurements.az.Data, ...
%     imu3a_measurements.az.Data, ...
%     imu4a_measurements.az.Data, ...
% ];
% 
% x_axis_dataset_b = [
%     groundTruthB.ax.Data, ...    
%     imu1b_measurements.ax.Data, ...
%     imu2b_measurements.ax.Data, ...
%     imu3b_measurements.ax.Data, ...
%     imu4b_measurements.ax.Data, ...
% ];
% 
% z_axis_dataset_b = [
%     groundTruthB.az.Data, ...
%     imu1b_measurements.az.Data, ...
%     imu2b_measurements.az.Data, ...
%     imu3b_measurements.az.Data, ...
%     imu4b_measurements.az.Data, ...
% ];
% 
% plot(imu1b_measurements.az.Time, imu1b_measurements.az.Data);
% 
% 
% figure("Name", "IMU A x-Axis Accelerometer Data");
% plot(x_axis_dataset_a);
% legend("Ground Truth", "IMU 1a", "IMU 2a", "IMU 3a", "IMU 4a");
% title("IMU A x-Axis Accelerometer Data");
% xlabel("Time (s)");
% ylabel("Acceleration (m/s^2)");
% grid off;
% 
% figure("Name", "IMU A z-Axis Accelerometer Data");
% plot(z_axis_dataset_a);
% legend("Ground Truth", "IMU 1a", "IMU 2a", "IMU 3a", "IMU 4a");
% title("IMU A z-Axis Accelerometer Data");
% xlabel("Time (s)");
% ylabel("Acceleration (m/s^2)");
% grid off;
% 
% figure("Name", "IMU B x-Axis Accelerometer Data");
% plot(x_axis_dataset_b);
% legend("Ground Truth", "IMU 1b", "IMU 2b", "IMU 3b", "IMU 4b");
% title("IMU B x-Axis Accelerometer Data");
% xlabel("Time (s)");
% ylabel("Acceleration (m/s^2)");
% grid off;
% 
% figure("Name", "IMU B z-Axis Accelerometer Data");
% plot(z_axis_dataset_b);
% legend("Ground Truth", "IMU 1b", "IMU 2b", "IMU 3b", "IMU 4b");
% title("IMU B z-Axis Accelerometer Data");
% xlabel("Time (s)");
% ylabel("Acceleration (m/s^2)");
% grid off;
% 
% 

%% Retrieve IMU Measurements and Plot Graphs

% Assuming 'out' is the simulation output from your model
% and that 'out.logsout' contains all the logged signals

% List of IMU sensor names for link 1 ('a') and link 2 ('b')
% imu_sensors_a = {'Sensor1a', 'Sensor2a', 'Sensor3a', 'Sensor4a'};
% imu_sensors_b = {'Sensor1b', 'Sensor2b', 'Sensor3b', 'Sensor4b'};
imu_sensors_a = {'Sensor1a', 'Sensor2a'};
imu_sensors_b = {'Sensor1b', 'Sensor2b'};

% Ground truth signal names
groundTruthNames = {'GroundTruth1', 'GroundTruth2'};

% Initialize structures to hold IMU measurements
imu_measurements = struct();
groundTruth_measurements = struct();

% Retrieve Ground Truth data
for k = 1:length(groundTruthNames)
    gt_name = groundTruthNames{k};
    groundTruth_measurements.(gt_name) = out.logsout.get(gt_name).Values;
end

% Retrieve IMU measurements for link 1 ('a')
for k = 1:length(imu_sensors_a)
    imu_name = imu_sensors_a{k};
    imu_measurements.(imu_name) = out.logsout.get(imu_name).Values;
end

% Retrieve IMU measurements for link 2 ('b')
for k = 1:length(imu_sensors_b)
    imu_name = imu_sensors_b{k};
    imu_measurements.(imu_name) = out.logsout.get(imu_name).Values;
end

%% Plotting IMU A (Link 1) Data

% Plot x-Axis Accelerometer Data for IMU A
figure('Name', 'IMU A x-Axis Accelerometer Data');
hold on;
% Plot Ground Truth
plot(groundTruth_measurements.GroundTruth1.ax, 'DisplayName', 'Ground Truth');
% Plot each IMU sensor data
for k = 1:length(imu_sensors_a)
    imu_name = imu_sensors_a{k};
    plot(imu_measurements.(imu_name).ax, 'DisplayName', imu_name);
end
hold off;
legend;
title('IMU A x-Axis Accelerometer Data');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
grid on;

% Plot y-Axis Accelerometer Data for IMU A
figure('Name', 'IMU A y-Axis Accelerometer Data');
hold on;
% Plot Ground Truth
plot(groundTruth_measurements.GroundTruth1.ay, 'DisplayName', 'Ground Truth');
% Plot each IMU sensor data
for k = 1:length(imu_sensors_a)
    imu_name = imu_sensors_a{k};
    plot(imu_measurements.(imu_name).ay, 'DisplayName', imu_name);
end
hold off;
legend;
title('IMU A y-Axis Accelerometer Data');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
grid on;

%% Plotting IMU B (Link 2) Data

% Plot x-Axis Accelerometer Data for IMU B
figure('Name', 'IMU B x-Axis Accelerometer Data');
hold on;
% Plot Ground Truth
plot(groundTruth_measurements.GroundTruth2.ax, 'DisplayName', 'Ground Truth');
% Plot each IMU sensor data
for k = 1:length(imu_sensors_b)
    imu_name = imu_sensors_b{k};
    plot(imu_measurements.(imu_name).ax, 'DisplayName', imu_name);
end
hold off;
legend;
title('IMU B x-Axis Accelerometer Data');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
grid on;

% Plot z-Axis Accelerometer Data for IMU B
figure('Name', 'IMU B y-Axis Accelerometer Data');
hold on;
% Plot Ground Truth
plot(groundTruth_measurements.GroundTruth2.ay, 'DisplayName', 'Ground Truth');
% Plot each IMU sensor data
for k = 1:length(imu_sensors_b)
    imu_name = imu_sensors_b{k};
    plot(imu_measurements.(imu_name).ay, 'DisplayName', imu_name);
end
hold off;
legend;
title('IMU B y-Axis Accelerometer Data');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
grid on;
