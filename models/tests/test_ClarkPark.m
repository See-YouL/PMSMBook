function test_ClarkPark()
% TEST_CLARKPARK
% 对 ClarkPark_Test.slx 进行常数输入测试（ABC + The -> dq）
%
% 模型要求：
%   1) 顶层 Inport 名称为：A, B, C, The
%   2) 输出端使用 To Workspace（保存到 SimulationOutput）
%      变量名分别为：d_out, q_out
%
% 本测试使用对称三相常数 + 固定角度：
%   A = 1
%   B = -0.5
%   C = -0.5
%   The = 0 (rad)
%
% 对于 2/3 幅值不变 ClarkePark(ABC->dq)：
%   The=0 时：d = 1, q = 0

    %% 1. 模型名称（按你的 slx 文件名改）
    model = 'ClarkPark_Test';   % 如果你的模型叫别的名字，这里改成对应 slx 的名字（不带 .slx）

    % 先加载库）
    load_system('MyPMSMLibrary');
    %% 2. 加载模型（不需要打开界面）
    load_system(model);

    %% 3. 仿真时间设置（常数测试用很短即可）
    Ts    = 1e-4;     % 采样时间/步长
    Tstop = 1e-3;     % 结束时间
    t = (0:Ts:Tstop)'; % 时间向量（列向量）

    %% 4. 构造常数输入（长度必须与 t 一致）
    A   =  1.0 * ones(size(t));
    B   = -0.5 * ones(size(t));
    C   = -0.5 * ones(size(t));
    The =  0.0 * ones(size(t)); % 角度：弧度制

    %% 5. 构造仿真输入对象 + 外部输入 Dataset
    in = Simulink.SimulationInput(model);
    in = in.setModelParameter('StopTime', num2str(Tstop));

    % 外部输入使用 Dataset：元素名必须与 Inport 名称一致
    ds = Simulink.SimulationData.Dataset;
    ds = ds.addElement(timeseries(A,   t), 'A');
    ds = ds.addElement(timeseries(B,   t), 'B');
    ds = ds.addElement(timeseries(C,   t), 'C');
    ds = ds.addElement(timeseries(The, t), 'The');

    in = in.setExternalInput(ds);

    %% 6. 运行仿真
    out = sim(in);

    %% 7. 读取输出（To Workspace 保存为 SimulationOutput 时，变量在 out.xxx 里）
    d = out.d_out;
    q = out.q_out;

    % 如果你 To Workspace 的保存格式是 timeseries，需要取 Data
    % （若你保存格式是"数组"，dq就是数值向量，不需要这一步）
    if isa(d, 'timeseries'); d = d.Data; end
    if isa(q,  'timeseries'); q  = q.Data;  end
    d_end = d(end);
    q_end  = q(end);

    %% 8. 打印结果
    fprintf('ClarkPark 常数输入测试结果：\n');
    fprintf('  输入：A=1, B=-0.5, C=-0.5, The=0(rad)\n');
    fprintf('  d = %.6f\n', d_end);
    fprintf('  q = %.6f\n', q_end);

    %% 9. 断言判定（允许微小数值误差）
    tol = 1e-6;
    assert(abs(d_end - 1) < tol, 'd 结果错误');
    assert(abs(q_end - 0) < tol, 'q 结果错误');

    fprintf('ClarkPark 常数输入测试通过 ✅\n');
end
