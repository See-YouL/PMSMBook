# 现代永磁同步电机控制原理及MATLAB仿真

## 基础说明

- 参考书目： 《现代永磁同步电机控制原理及MATLAB仿真》

## 工程架构

```txt
PMSMBook/                  （工程根目录）
├─ PMSM.prj                （工程文件）
├─ README.md               （可选）
├─ libraries/
│  └─ MyPMSMLibrary.slx     （你的库）
├─ models/
│  ├─ tests/
│  │  └─ Clarke_Test.slx     （Clarke 单元测试模型）
│  └─ demos/                （以后放示例模型）
├─ blocks/                  （可选：如果你想放子系统源模型）
│  └─ Clarke_Source.slx
├─ scripts/
│  ├─ startup.m             （工程打开时自动跑）
│  └─ run_all_tests.m        （一键运行测试）
└─ resources/
   └─ ...                   （图片、文档等）
```
