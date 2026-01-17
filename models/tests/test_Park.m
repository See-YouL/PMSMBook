function test_Park()
% TEST_PARK
% 使用 Inport Alpha/Beta/The 对 Park_Test.slx 进行常数输入测试
%
% 模型要求：
%   1) 顶层 Inport 名称为：Alpha, Beta, The
%   2) 输出使用 To Workspace（保存到 SimulationOutput）
%      变量名分别为：d_out, q_out
%
% 测试思想：
%   Park 变换：
%       d =  alpha*cos(theta) + beta*sin(theta)
%       q = -alpha*sin(theta) + beta*cos(theta)
%
% 选取易验证的常数输入：
%   alpha = 1
%   beta  = 0
%   theta = 0
%
% 理论结果：
%   d = 1
%   q = 0

    %% 1. 模型名称（不带 .slx）
    model = 'Park_Test';

    % 先加载库（如果 Park_Test 引用了 MyPMSMLibrary，建议加载）
    load_system('MyPMSMLibrary');

    % 加载模型（不打开界面也可以）
    load_system(model);

    %% 2. 构造常数输入信号（用 timeseries 作为外部输入）
    Ts = 1e-4;          % 采样时间
    Tstop = 1e-3;       % 仿真结束时间（常数测试很短即可）
    t = (0:Ts:Tstop)';  % 时间向量

    Alpha = 1.0 * ones(size(t));   % alpha = 1
    Beta  = 0.0 * ones(size(t));   % beta  = 0
    The   = 0.0 * ones(size(t));   % theta = 0（弧度）

    %% 3. 构造仿真输入对象，并设置外部输入
    in = Simulink.SimulationInput(model);
    in = in.setModelParameter('StopTime', num2str(Tstop));

    % 外部输入使用 Dataset，元素名必须与 Inport 名称完全一致
    ds = Simulink.SimulationData.Dataset;
    ds = ds.addElement(timeseries(Alpha, t), 'Alpha');
    ds = ds.addElement(timeseries(Beta,  t), 'Beta');
    ds = ds.addElement(timeseries(The,   t), 'The');

    % 将 Dataset 作为模型外部输入
    in = in.setExternalInput(ds);

    %% 4. 运行仿真
    out = sim(in);

    %% 5. 读取输出结果（来自 To Workspace，保存在 SimulationOutput out 中）
    d_sig = out.d_out;
    q_sig = out.q_out;

    % 取最后一个采样点作为稳态结果
    d_end = d_sig(end);
    q_end = q_sig(end);

    %% 6. 打印结果
    fprintf('Park 常数输入测试结果：\n');
    fprintf('  输入信号： Alpha=1, Beta=0, The=0(rad)\n');
    fprintf('  D = %.6f\n', d_end);
    fprintf('  Q = %.6f\n', q_end);

    %% 7. 自动判定是否通过（断言）
    tol = 1e-6;  % 允许误差
    assert(abs(d_end - 1) < tol, 'D 结果错误');
    assert(abs(q_end - 0) < tol, 'Q 结果错误');

    fprintf('Park 常数输入测试通过\n');
end
