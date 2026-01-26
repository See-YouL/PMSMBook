function test_ElecTorqueCalculation()
% TEST_ELECTORQUECALCULATION
% 对 ElecTorqueCalculation 进行常数输入测试（id, iq -> Te）
%
% 模型要求：
%   1) 顶层 Inport 名称为：id, iq
%   2) 输出端使用 To Workspace（保存到 SimulationOutput）
%      变量名为：Te_out
%
% ElecTorqueCalculation 模型的参数为
%   极对数 p = 4
%   磁链常数 0.5 
%   Ld-Lq = 0
% 本测试使用常数输入：
%   id = 1
%   iq = 1
%
% 期望输出 Te = 3.0

    %% 1. 模型名称（按你的 slx 文件名改）
    model = 'ElecTorqueCalculation_Test';   % 如果你的模型叫别的名字，这里改成对应 slx 的名字（不带 .slx）

    % 先加载库
    load_system('MyPMSMLibrary');

    %% 2. 加载模型（不需要打开界面）
    load_system(model);

    %% 3. 仿真时间设置（常数测试用很短即可）
    Ts    = 1e-4;     % 采样时间/步长
    Tstop = 1e-3;     % 结束时间
    t = (0:Ts:Tstop)'; % 时间向量（列向量）

    %% 4. 构造常数输入（长度必须与 t 一致）
    id   =  1.0 * ones(size(t)); % id 输入值
    iq   =  1.0 * ones(size(t)); % iq 输入值

    %% 5. 构造仿真输入对象 + 外部输入 Dataset
    in = Simulink.SimulationInput(model);
    in = in.setModelParameter('StopTime', num2str(Tstop));

    % 外部输入使用 Dataset：元素名必须与 Inport 名称一致
    ds = Simulink.SimulationData.Dataset;
    ds = ds.addElement(timeseries(id,   t), 'id');
    ds = ds.addElement(timeseries(iq,   t), 'iq');

    in = in.setExternalInput(ds);

    %% 6. 运行仿真
    out = sim(in);

    %% 7. 读取输出（To Workspace 保存为 SimulationOutput 时，变量在 out.xxx 里）
    Te_out = out.Te_out;

    % 如果你 To Workspace 的保存格式是 timeseries，需要取 Data
    % （若你保存格式是"数组"，Te_out就是数值向量，不需要这一步）
    if isa(Te_out, 'timeseries'); Te_out = Te_out.Data; end
    Te_end = Te_out(end); % 获取仿真结束时的电磁转矩值

    %% 8. 打印结果
    fprintf('ElecTorqueCalculation 常数输出结果:\n');
    fprintf(' 输入: id=1, iq=1\n');
    fprintf(' 电磁转矩 Te = %.6f\n', Te_end);

    %% 9. 断言结果是否正确（允许一定误差）
    % 这里根据您期望的计算公式验证 Te 结果是否符合预期
    tol = 1e-6; % 允许的误差范围

    % 请根据您的实际公式填入期望值
    expected_Te = 3.0; % 这是您期望的 Te 值（根据实际公式计算）

    assert(abs(Te_end - expected_Te) < tol, '电磁转矩 Te 计算结果错误');

    fprintf('ElecTorqueCalculation 测试通过！\n');
end
