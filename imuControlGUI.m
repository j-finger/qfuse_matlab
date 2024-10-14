% imuControlGUI.m

function imuControlGUI
    % Create UI Figure
    fig = uifigure('Name', 'IMU Control', 'Position', [100 100 300 200]);

    % Gyroscope FS_SEL Dropdown
    uilabel(fig, 'Position', [20 150 150 22], 'Text', 'Gyroscope FS_SEL');
    gyro_dd = uidropdown(fig, 'Position', [180 150 100 22], ...
        'Items', {'0','1','2','3','4','5','6','7'}, 'Value', '2');

    % Accelerometer FS_SEL Dropdown
    uilabel(fig, 'Position', [20 110 150 22], 'Text', 'Accelerometer FS_SEL');
    accel_dd = uidropdown(fig, 'Position', [180 110 100 22], ...
        'Items', {'0','1','2','3'}, 'Value', '2');

    % Run Simulation Button
    btn = uibutton(fig, 'push', 'Position', [100 50 100 30], 'Text', 'Run Simulation', ...
        'ButtonPushedFcn', @(btn,event) runSimulation(str2double(gyro_dd.Value), str2double(accel_dd.Value)));
end

function runSimulation(gyro_FS_SEL, accel_FS_SEL)
    % Assign FS_SEL variables to base workspace
    assignin('base', 'GYRO_FS_SEL', gyro_FS_SEL);
    assignin('base', 'ACCEL_FS_SEL', accel_FS_SEL);

    % Run the simulationAssignment script
    simulationAssignment(gyro_FS_SEL, accel_FS_SEL);

    % Run the Simulink model
    simOut = sim('doublePendulumIMU.slx');

    % Optional: Display confirmation
    % uialert(gcf, 'Simulation completed and graphs updated.', 'Success');
end





