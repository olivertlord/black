[cal_l_int,cal_left_w] = sifreader('\\mac\dropbox\Work\Data\LabData\4color\CALIBRATIONS\Thermal\separate\Spectroradiometry\iDuS\190325\W_cal_L_190325.sif');
[unk_l_int,unk_left_w] = sifreader('\\mac\dropbox\Work\Data\LabData\4color\CALIBRATIONS\Thermal\separate\Spectroradiometry\iDuS\190325\steel_test_2.sif');


system_response = unk_l_int ./ cal_l_int;


% imagesc(system_response(1:1024,1:120)')

plot(cal_l_int(:,60))
hold on
plot(unk_l_int(:,60))
hold off
plot(system_response(:,60))
