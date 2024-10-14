
function setIMUparameters(PATH, GYRO_FS_SEL, ACCEL_FS_SEL)
    % % Set default values if not provided
    % if nargin < 1 || isempty(GYRO_FS_SEL)
    %     GYRO_FS_SEL = 2; % Default Gyroscope FS_SEL
    %     print("no value set for gyro");
    % end
    % if nargin < 2 || isempty(ACCEL_FS_SEL)
    %     ACCEL_FS_SEL = 2; % Default Accelerometer FS_SEL
    %     print("no value set for accel");
    % end


    %% Set Parameters
        % Gyro Parameters
            %% Datasheet Gyro Parameters Set %%
               % GYRO_FS_SEL = 2;
                GYRO_FS_SEL_ARRAY = [ ...
                  % fullscale, sensitivity; ... %
                    2000, 16.4; ...     % GYRO_FS_SEL=0
                    1000, 32.8; ...     % GYRO_FS_SEL=1
                    500, 65.5; ...      % GYRO_FS_SEL=2
                    250, 131; ...       % GYRO_FS_SEL=3
                    125, 262; ...       % GYRO_FS_SEL=4
                    62.5, 524.3; ...    % GYRO_FS_SEL=5
                    31.25, 1048.6; ...  % GYRO_FS_SEL=6
                    15.625, 2097.2;     % GYRO_FS_SEL=7
                ];
    
                gyroDS.name = "Datasheet Gyroscope Parameters";
                gyroDS.fullScaleRange.value = GYRO_FS_SEL_ARRAY(GYRO_FS_SEL+1, 1); % (º/s)
                gyroDS.fullScaleRange.units = "º/s";
                gyroDS.fullScaleRange.name = "Full Scale Range"; 
    
                gyroDS.adcWordLength.value = 16; % (bits)
                gyroDS.adcWordLength.units = "bits";
                gyroDS.adcWordLength.name = "ADC Word Length";
    
                gyroDS.sensitivityScaleFactor.value = GYRO_FS_SEL_ARRAY(GYRO_FS_SEL+1, 2); % (LSB/(°/s))
                gyroDS.sensitivityScaleFactor.units = "LSB/(º/s)";
                gyroDS.sensitivityScaleFactor.name = "Sensitivity Scale Factor";
    
                gyroDS.sensitivityScaleFactorInitialTolerance.value = 0.5; % (%)
                gyroDS.sensitivityScaleFactorInitialTolerance.units = "%";
                gyroDS.sensitivityScaleFactorInitialTolerance.name = "Sensitivity Scale Factor Initial Tolerance";
    
                gyroDS.sensitivityScaleFactorVariationTemp.value = 0.005; % (%/ºC)
                gyroDS.sensitivityScaleFactorVariationTemp.units = "%/ºC";
                gyroDS.sensitivityScaleFactorVariationTemp.name = "Sensitivity Scale Factor Variation with Temperature";
    
                gyroDS.nonlinearity.value = 0.1; % (%)
                gyroDS.nonlinearity.units = "%";
                gyroDS.nonlinearity.name = "Nonlinearity";
    
                gyroDS.crossAxisSensitivity.value = 1.25; % (%)
                gyroDS.crossAxisSensitivity.units = "%";
                gyroDS.crossAxisSensitivity.name = "Cross-Axis Sensitivity";
    
                gyroDS.initialZROTolerance.value = 0.5; % (º/s)
                gyroDS.initialZROTolerance.units = "º/s";
                gyroDS.initialZROTolerance.name = "Initial Zero Rate Output Tolerance";
    
                gyroDS.zroVariationTemp.value = 0.005; % (º/s/ºC)
                gyroDS.zroVariationTemp.units = "º/s/ºC";
                gyroDS.zroVariationTemp.name = "Zero Rate Output Variation with Temperature";
                
                gyroDS.rateNoiseSpectralDensity.value = 0.0028; % (º/s/√Hz)
                gyroDS.rateNoiseSpectralDensity.units = "º/s/√Hz";
                gyroDS.rateNoiseSpectralDensity.name = "Rate Noise Spectral Density";
                
                gyroDS.totalRMSNoise.value = 0.028; % (º/s-rms)
                gyroDS.totalRMSNoise.units = "º/s-rms";
                gyroDS.totalRMSNoise.name = "Total RMS Noise";
                
            %% MATLAB Gyro Parameters Set %%
                gyro.name = "MATLAB Gyroscope Parameters";
    
                gyro.TemperatureScaleFactor.value = gyroDS.sensitivityScaleFactorVariationTemp.value; % (%/ºC)
                gyro.TemperatureScaleFactor.units = "%/ºC";
                gyro.TemperatureScaleFactor.name = "Temperature Scale Factor";
                gyro.TemperatureScaleFactor.use = true;
                gyro.TemperatureScaleFactor.source = {gyroDS.sensitivityScaleFactorVariationTemp};
            
                gyro.MaximumReadings.value = deg2rad(gyroDS.fullScaleRange.value); % (rad/s)
                gyro.MaximumReadings.units = "rad/s";
                gyro.MaximumReadings.name = "Maximum Readings";
                gyro.MaximumReadings.use = true;
                gyro.MaximumReadings.source = {gyroDS.fullScaleRange}; % (º/s)
                
                gyro.Resolution.value = 1/(deg2rad(gyroDS.sensitivityScaleFactor.value)); % ((rad/s)/LSB)
                gyro.Resolution.units = "rad/s/LSB";
                gyro.Resolution.name = "Resolution";
                gyro.Resolution.use = true;
                gyro.Resolution.source = {gyroDS.sensitivityScaleFactor}; % (LSB/(º/s))
    
                gyro.ConstantOffsetBias.value = deg2rad(gyroDS.initialZROTolerance.value); % (rad/s)
                gyro.ConstantOffsetBias.units = "rad/s";
                gyro.ConstantOffsetBias.name = "Constant Offset Bias";
                gyro.ConstantOffsetBias.use = true;
                gyro.ConstantOffsetBias.source = {gyroDS.initialZROTolerance};
    
                gyro.AngleRandomWalk.value = deg2rad(gyroDS.totalRMSNoise.value); % (rad/s/√Hz)
                gyro.AngleRandomWalk.units = "rad/s/√Hz";
                gyro.AngleRandomWalk.name = "Angle Random Walk";
                gyro.AngleRandomWalk.use = true;
                gyro.AngleRandomWalk.source = {gyroDS.rateNoiseSpectralDensity}; % (º/s/√Hz)
    
                gyro.BiasFromTemperature.value = deg2rad(gyroDS.zroVariationTemp.value); % (rad/s/ºC)
                gyro.BiasFromTemperature.units = "rad/s/ºC";
                gyro.BiasFromTemperature.name = "Bias from Temperature";
                gyro.BiasFromTemperature.use = true;
                gyro.BiasFromTemperature.source = {gyroDS.zroVariationTemp}; % (º/s/ºC)
                
                gyro.AxisSkew.value = gyroDS.crossAxisSensitivity.value; % (%)
                gyro.AxisSkew.units = "%";
                gyro.AxisSkew.name = "Axis Skew";
                gyro.AxisSkew.use = true;
                gyro.AxisSkew.source = {gyroDS.crossAxisSensitivity};
                
                gyro.BiasInstability.value = gyroDS.nonlinearity.value * deg2rad(gyroDS.fullScaleRange.value) / 100; % (rad/s)
                gyro.BiasInstability.units = "rad/s";
                gyro.BiasInstability.name = "Bias Instability";
                gyro.BiasInstability.use = true;
                gyro.BiasInstability.source = {gyroDS.nonlinearity, gyroDS.fullScaleRange};
    
    
                % Unsure Transformations - DONE
                gyro.RateRandomWalk.value = deg2rad(gyroDS.rateNoiseSpectralDensity.value); % (rad/s/√Hz)
                gyro.RateRandomWalk.units = "rad/s/√Hz";
                gyro.RateRandomWalk.name = "Rate Random Walk";
                gyro.RateRandomWalk.use = false;
                gyro.RateRandomWalk.source = {gyroDS.rateNoiseSpectralDensity};
    
    
    
        %% Accelerometer Parameters %%
            % Datasheet Accelerometer Parameters Set 
                % ACCEL_FS_SEL = 2;
                ACCEL_FS_SEL_ARRAY = [ ...
                    % fullscale, sensitivity; ... %
                        16, 2048; ...   % ACCEL_FS_SEL=0
                        8, 4096; ...    % ACCEL_FS_SEL=1
                        4, 8192; ...    % ACCEL_FS_SEL=2
                        2, 16384; ...   % ACCEL_FS_SEL=3
                    ];
    
                accelDS.name = "Datasheet Accelerometer Parameters";
    
                accelDS.fullScaleRange.value = ACCEL_FS_SEL_ARRAY(ACCEL_FS_SEL+1, 1); % (g)
                accelDS.fullScaleRange.units = "g";
                accelDS.fullScaleRange.name = "Full-Scale Range";
    
                accelDS.adcWordLength.value = 16; % (bits)
                accelDS.adcWordLength.units = "bits";
                accelDS.adcWordLength.name = "ADC Word Length";
    
                accelDS.sensitivityScaleFactor.value = ACCEL_FS_SEL_ARRAY(ACCEL_FS_SEL+1, 2); % (LSB/g)
                accelDS.sensitivityScaleFactor.units = "LSB/g";
                accelDS.sensitivityScaleFactor.name = "Sensitivity Scale Factor";
    
                accelDS.sensitivityChangeVsTemperature.value = 0.005; % (%/ºC)
                accelDS.sensitivityChangeVsTemperature.units = "%/ºC";
                accelDS.sensitivityChangeVsTemperature.name = "Sensitivity Change vs. Temperature";
    
                accelDS.crossAxisSensitivity.value = 1; % (%)
                accelDS.crossAxisSensitivity.units = "%";
                accelDS.crossAxisSensitivity.name = "Cross-Axis Sensitivity";
    
                accelDS.initialTolerance.value = 20; % (mg)
                accelDS.initialTolerance.units = "mg";
                accelDS.initialTolerance.name = "Initial Tolerance";
    
                accelDS.zeroGLevelChangeVsTemperature.value = 0.15; % (mg/ºC)
                accelDS.zeroGLevelChangeVsTemperature.units = "mg/ºC";
                accelDS.zeroGLevelChangeVsTemperature.name = "Zero-G Level Change vs. Temperature";
    
                accelDS.powerSpectralDensity.value = 65; % (µg/√Hz)
                accelDS.powerSpectralDensity.units = "µg/√Hz";
                accelDS.powerSpectralDensity.name = "Power Spectral Density";
    
                accelDS.nonLinearity.value = 0.1;
                accelDS.nonLinearity.units = "%";
                accelDS.nonLinearity.name = "Non-Linearity";
                
    
    
            %% MATLAB Accelerometer Parameters Set %%
                accel.name = "MATLAB Accelerometer Parameters";
    
                accel.MaximumReadings.value = convacc(accelDS.fullScaleRange.value, 'G''s', 'm/s^2'); % (m/s^2)
                accel.MaximumReadings.units = "m/s^2";
                accel.MaximumReadings.name = "Maximum Readings";
                accel.MaximumReadings.use = true;
                accel.MaximumReadings.source = {accelDS.fullScaleRange}; % (g)
    
                % Resolution
                accel.Resolution.value = 1 / convacc(accelDS.sensitivityScaleFactor.value, 'G''s', 'm/s^2'); % ((m/s^2)/LSB)
                accel.Resolution.units = "(m/s^2)/LSB";
                accel.Resolution.name = "Resolution";
                accel.Resolution.use = true;
                accel.Resolution.source = {accelDS.sensitivityScaleFactor}; % (LSB/g)
    
                % Constant Offset Bias
                accel.ConstantOffsetBias.value = convacc(accelDS.initialTolerance.value * 1e-3, 'G''s', 'm/s^2'); % (m/s^2)
                accel.ConstantOffsetBias.units = "m/s^2";
                accel.ConstantOffsetBias.name = "Constant Offset Bias";
                accel.ConstantOffsetBias.use = true;
                accel.ConstantOffsetBias.source = {accelDS.initialTolerance}; % (mg)
    
                % Temperature Scale Factor
                accel.TemperatureScaleFactor.value = accelDS.sensitivityChangeVsTemperature.value; % (%/ºC)
                accel.TemperatureScaleFactor.units = "%/ºC";
                accel.TemperatureScaleFactor.name = "Temperature Scale Factor";
                accel.TemperatureScaleFactor.use = true;
                accel.TemperatureScaleFactor.source = {accelDS.sensitivityChangeVsTemperature}; % (%/ºC)
    
                % Axes Misalignment
                accel.AxisSkew.value = accelDS.crossAxisSensitivity.value; % (%)
                accel.AxisSkew.units = "%";
                accel.AxisSkew.name = "Axis Skew";
                accel.AxisSkew.use = true;
                accel.AxisSkew.source = {accelDS.crossAxisSensitivity}; % (%)
    
                % Noise Density
                accel.AccelerationRandomWalk.value = convacc(accelDS.powerSpectralDensity.value * 1e-6, 'G''s', 'm/s^2'); % (m/s^2)(√Hz)
                accel.AccelerationRandomWalk.units = "(m/s^2)/√Hz";
                accel.AccelerationRandomWalk.name = "Acceleration Random Walk";
                accel.AccelerationRandomWalk.use = true;
                accel.AccelerationRandomWalk.source = {accelDS.powerSpectralDensity}; % (µg/√Hz)
                
    
                % Bias from Temperature
                accel.BiasFromTemperature.value = convacc(accelDS.zeroGLevelChangeVsTemperature.value * 1e-3, 'G''s', 'm/s^2'); % (m/s^2)/ºC)
                accel.BiasFromTemperature.units = "(m/s^2)/ºC";
                accel.BiasFromTemperature.name = "Bias from Temperature";
                accel.BiasFromTemperature.use = true;
                accel.BiasFromTemperature.source = {accelDS.zeroGLevelChangeVsTemperature}; % (mg/ºC)
    
                % Bias Instability (Using Nonlinearity) -  Nonlinearity percentage of full-scale range converted to m/s^2
                accel.BiasInstability.value = (0.1 / 100) * accel.MaximumReadings.value;
                accel.BiasInstability.units = "m/s^2";
                accel.BiasInstability.name = "Bias Instability";
                accel.BiasInstability.use = true;
                accel.BiasInstability.source = {accelDS.nonLinearity}; % (%)
    
    
    
    
    
    %% Assign accel & gyroscope parameters
       
    
        % Assign gyro parameters to IMU 1
        set_param(PATH, 'GyroParamsMeasurementRange', num2str(gyro.MaximumReadings.value));
        set_param(PATH, 'GyroParamsResolution', num2str(gyro.Resolution.value));
        set_param(PATH, 'GyroParamsConstantBias', mat2str(gyro.ConstantOffsetBias.value));
        set_param(PATH, 'GyroParamsAxesMisalignment', mat2str(gyro.AxisSkew.value));
        set_param(PATH, 'GyroParamsNoiseDensity', mat2str(gyro.AngleRandomWalk.value));
        set_param(PATH, 'GyroParamsBiasInstability', num2str(gyro.BiasInstability.value));
        set_param(PATH, 'GyroParamsTemperatureBias', mat2str(gyro.BiasFromTemperature.value));
        set_param(PATH, 'GyroParamsTemperatureScaleFactor', mat2str(gyro.TemperatureScaleFactor.value));
        
        % Assign accelerometer parameters to IMU 1
        set_param(PATH, 'AccelParamsMeasurementRange', num2str(accel.MaximumReadings.value));
        set_param(PATH, 'AccelParamsResolution', num2str(accel.Resolution.value));
        set_param(PATH, 'AccelParamsConstantBias', mat2str(accel.ConstantOffsetBias.value));
        set_param(PATH, 'AccelParamsAxesMisalignment', mat2str(accel.AxisSkew.value));
        set_param(PATH, 'AccelParamsNoiseDensity', mat2str(accel.AccelerationRandomWalk.value));
        set_param(PATH, 'AccelParamsBiasInstability', num2str(accel.BiasInstability.value));
        set_param(PATH, 'AccelParamsTemperatureBias', mat2str(accel.BiasFromTemperature.value));
        set_param(PATH, 'AccelParamsTemperatureScaleFactor', mat2str(accel.TemperatureScaleFactor.value));
        
        % % Assign gyro parameters to IMU 2
        % set_param('doublePendulumIMU/IMU attached to link 2/IMU 2', 'GyroParamsMeasurementRange', num2str(gyro.MaximumReadings.value));
        % set_param('doublePendulumIMU/IMU attached to link 2/IMU 2', 'GyroParamsResolution', num2str(gyro.Resolution.value));
        % set_param('doublePendulumIMU/IMU attached to link 2/IMU 2', 'GyroParamsConstantBias', mat2str(gyro.ConstantOffsetBias.value));
        % set_param('doublePendulumIMU/IMU attached to link 2/IMU 2', 'GyroParamsAxesMisalignment', mat2str(gyro.AxisSkew.value));
        % set_param('doublePendulumIMU/IMU attached to link 2/IMU 2', 'GyroParamsNoiseDensity', mat2str(gyro.AngleRandomWalk.value));
        % set_param('doublePendulumIMU/IMU attached to link 2/IMU 2', 'GyroParamsBiasInstability', num2str(gyro.BiasInstability.value));
        % set_param('doublePendulumIMU/IMU attached to link 2/IMU 2', 'GyroParamsTemperatureBias', mat2str(gyro.BiasFromTemperature.value));
        % set_param('doublePendulumIMU/IMU attached to link 2/IMU 2', 'GyroParamsTemperatureScaleFactor', mat2str(gyro.TemperatureScaleFactor.value));
        % 
        % % Assign accelerometer parameters to IMU 2
        % set_param('doublePendulumIMU/IMU attached to link 2/IMU 2', 'AccelParamsMeasurementRange', num2str(accel.MaximumReadings.value));
        % set_param('doublePendulumIMU/IMU attached to link 2/IMU 2', 'AccelParamsResolution', num2str(accel.Resolution.value));
        % set_param('doublePendulumIMU/IMU attached to link 2/IMU 2', 'AccelParamsConstantBias', mat2str(accel.ConstantOffsetBias.value));
        % set_param('doublePendulumIMU/IMU attached to link 2/IMU 2', 'AccelParamsAxesMisalignment', mat2str(accel.AxisSkew.value));
        % set_param('doublePendulumIMU/IMU attached to link 2/IMU 2', 'AccelParamsNoiseDensity', mat2str(accel.AccelerationRandomWalk.value));
        % set_param('doublePendulumIMU/IMU attached to link 2/IMU 2', 'AccelParamsBiasInstability', num2str(accel.BiasInstability.value));
        % set_param('doublePendulumIMU/IMU attached to link 2/IMU 2', 'AccelParamsTemperatureBias', mat2str(accel.BiasFromTemperature.value));
        % set_param('doublePendulumIMU/IMU attached to link 2/IMU 2', 'AccelParamsTemperatureScaleFactor', mat2str(accel.TemperatureScaleFactor.value));

    
    %% Print Parameters
        printGyro = false;
        printAccel = true;
        % Gyro Parameters
        if printGyro
            printConverted(gyro);
            printSetValues(gyroDS);
            printSetValues(gyro);
        end
    
        % Accelerometer Parameters
        if printAccel
            printConverted(accel);
            printSetValues(accelDS);
            printSetValues(accel);
        end
    

    %% Functions 
        % Datasheet to Gyro Conversions Printout
        function printConverted(imuParameters)
            fields = fieldnames(imuParameters);
            fprintf('\n>> %s <<\n', imuParameters.name);
            if fields{1} == "name"
                fields = fields(2:end);
            end
            for i = 1:numel(fields)
                name = imuParameters.(fields{i}).name;
                value = imuParameters.(fields{i}).value;
                units = imuParameters.(fields{i}).units;
                fprintf('%s: %.3g %s\n', name, value, units); 
    
                % Print the source of the data structure correctly
                sources = imuParameters.(fields{i}).source;
                for j = 1:numel(sources)
                    sourceName = sources{j}.name;
                    sourceValue = sources{j}.value;
                    sourceUnits = sources{j}.units;
                    fprintf("    from %-17s: %.3g %s\n", sourceName, sourceValue, sourceUnits);
                end
                fprintf("\n");
            end
        end
    
    
        % Dataset Values Printout
        function printSetValues(imuParameters)
            fprintf('\n>> %s <<\n', imuParameters.name);
            fields = fieldnames(imuParameters);
            maxValueLength = 0;
            maxUnitLength = 0;
            if fields{1} == "name"
                fields = fields(2:end);
            end
            % First pass: Determine the maximum lengths
            for i = 1:numel(fields)
                indexValue = imuParameters.(fields{i}).value;
                indexUnits = imuParameters.(fields{i}).units;        
                maxValueLength = max(maxValueLength, strlength(sprintf('%.4g', indexValue)));
                maxUnitLength = max([maxUnitLength, strlength(indexUnits)]);
            end
    
            % Second pass: Print with proper formatting
            for i = 1:numel(fields)
                indexName = imuParameters.(fields{i}).name;
                indexValue = imuParameters.(fields{i}).value;
                indexUnits = imuParameters.(fields{i}).units;
                fprintf(['%-' num2str(maxValueLength) '.4g %- ' num2str(maxUnitLength) 's  %s\n'], indexValue, indexUnits, indexName);
            end
        end

    % get_param('doublePendulumIMU/IMU attached to link 1/IMU 1', 'AccelParamsMeasurementRange');
    % get_param('doublePendulumIMU/IMU attached to link 1/IMU 1', 'AccelParamsResolution');
    % get_param('doublePendulumIMU/IMU attached to link 1/IMU 1', 'AccelParamsConstantBias');
    % get_param('doublePendulumIMU/IMU attached to link 1/IMU 1', 'AccelParamsAxesMisalignment');
    % get_param('doublePendulumIMU/IMU attached to link 1/IMU 1', 'AccelParamsNoiseDensity');
    % get_param('doublePendulumIMU/IMU attached to link 1/IMU 1', 'AccelParamsBiasInstability');
    % get_param('doublePendulumIMU/IMU attached to link 1/IMU 1', 'AccelParamsBiasInstabilityNumerator');
    % get_param('doublePendulumIMU/IMU attached to link 1/IMU 1', 'AccelParamsBiasInstabilityDenominator');
    % get_param('doublePendulumIMU/IMU attached to link 1/IMU 1', 'AccelParamsRandomWalk');
    % get_param('doublePendulumIMU/IMU attached to link 1/IMU 1', 'AccelParamsNoiseType');
    % get_param('doublePendulumIMU/IMU attached to link 1/IMU 1', 'AccelParamsTemperatureBias');
    % get_param('doublePendulumIMU/IMU attached to link 1/IMU 1', 'AccelParamsTemperatureScaleFactor');
    % 
    % get_param('doublePendulumIMU/IMU attached to link 1/IMU 1', 'GyroParamsMeasurementRange');
    % get_param('doublePendulumIMU/IMU attached to link 1/IMU 1', 'GyroParamsResolution');
    % get_param('doublePendulumIMU/IMU attached to link 1/IMU 1', 'GyroParamsConstantBias');
    % get_param('doublePendulumIMU/IMU attached to link 1/IMU 1', 'GyroParamsAxesMisalignment');
    % get_param('doublePendulumIMU/IMU attached to link 1/IMU 1', 'GyroParamsAccelerationBias');
    % get_param('doublePendulumIMU/IMU attached to link 1/IMU 1', 'GyroParamsNoiseDensity');
    % get_param('doublePendulumIMU/IMU attached to link 1/IMU 1', 'GyroParamsBiasInstabilityNumerator');
    % get_param('doublePendulumIMU/IMU attached to link 1/IMU 1', 'GyroParamsBiasInstability');
    % get_param('doublePendulumIMU/IMU attached to link 1/IMU 1', 'GyroParamsBiasInstabilityDenominator');
    % get_param('doublePendulumIMU/IMU attached to link 1/IMU 1', 'GyroParamsNoiseType');
    % get_param('doublePendulumIMU/IMU attached to link 1/IMU 1', 'GyroParamsRandomWalk');
    % get_param('doublePendulumIMU/IMU attached to link 1/IMU 1', 'GyroParamsTemperatureBias');
    % get_param('doublePendulumIMU/IMU attached to link 1/IMU 1', 'GyroParamsTemperatureScaleFactor');
    % 

end