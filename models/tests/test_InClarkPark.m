function test_InClarkPark()
% TEST_INCLARKPARK
% 对 InClarkPark_Test.slx 进行常数输入测试（dq + The -> ABC）
%
% 模型要求：
%   1) 顶层 Inport 名称为：D, Q, The
%   2) 输出端使用 To Workspace（保存到 SimulationOutput）
%      变量名分别为：a_out, b_out, c_out
%
% 本测试使用常数输入 + 固定角度：
%   D = 1
%   Q = 0
%   The = 0 (rad)
%
% 对于 2/3 幅值不变 InClarkePark(dq->ABC)：
%   The=0 时：A = 1, B = -0.5, C = -0.5

    %% 1. 模型名称（按你的 slx 文件名改）
    model = 'InClarkPark_Test';   % 如果你的模型叫别的名字，这里改成对应 slx 的名字（不带 .slx）

    % 先加载库
    load_system('MyPMSMLibrary');

    %% 2. 加载模型（不需要打开界面）
    load_system(model);

    %% 3. 仿真时间设置（常数测试用很短即可）
    Ts    = 1e-4;     % 采样时间/步长
    Tstop = 1e-3;     % 结束时间
    t = (0:Ts:Tstop)'; % 时间向量（列向量）

    %% 4. 构造常数输入（长度必须与 t 一致）
    D   =  1.0 * ones(size(t));
    Q   =  0.0 * ones(size(t));
    The =  0.0 * ones(size(t)); % 角度：弧度制

    %% 5. 构造仿真输入对象 + 外部输入 Dataset
    in = Simulink.SimulationInput(model);
    in = in.setModelParameter('StopTime', num2str(Tstop));

    % 外部输入使用 Dataset：元素名必须与 Inport 名称一致
    ds = Simulink.SimulationData.Dataset;
    ds = ds.addElement(timeseries(D,   t), 'D');
    ds = ds.addElement(timeseries(Q,   t), 'Q');
    ds = ds.addElement(timeseries(The, t), 'The');

    in = in.setExternalInput(ds);

    %% 6. 运行仿真
    out = sim(in);

    %% 7. 读取输出（To Workspace 保存为 SimulationOutput 时，变量在 out.xxx 里）
    a = out.a_out;
    b = out.b_out;
    c = out.c_out;

    % 如果你 To Workspace 的保存格式是 timeseries，需要取 Data
    % （若你保存格式是"数组"，abc就是数值向量，不需要这一步）
    if isa(a, 'timeseries'); a = a.Data; end
    if isa(b, 'timeseries'); b = b.Data; end
    if isa(c, 'timeseries'); c = c.Data; end
    a_end = a(end);
    b_end = b(end);
    c_end = c(end);

    %% 8. 打印结果
    fprintf('InClarkPark 常数输出结果:\n');
    fprintf(' 输入: D=1, Q=0, The=0(rad)\n');
    fprintf(' A = %.6f\n', a_end);
    fprintf(' B = %.6f\n', b_end);
    fprintf(' C = %.6f\n', c_end);

    %% 9. 断言结果是否正确（允许一定误差）
    tol = 1e-6; % 允许的误差范围
    assert(abs(a_end - 1) < tol, 'A 结果错误');
    assert(abs(b_end + 0.5) < tol, 'B 结果错误');
    assert(abs(c_end + 0.5) < tol, 'C 结果错误');

    fprintf('InClarkPark 测试通过！\n');
end