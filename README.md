# 现代永磁同步电机控制原理及MATLAB仿真

## 基础说明

- 参考书目： 《现代永磁同步电机控制原理及MATLAB仿真》
- 测试版本： Matlab R2025b

## 工程架构

```txt
PMSMBook/                  （工程根目录）
├─ PMSM.prj                （工程文件）
├─ 现代永磁同步电机控制原理及MATLAB仿真.pdf (参考书)
├─ Notes/ (笔记目录)
│  ├─ Notes.md (笔记文件)
│  └─ ... (笔记文件中的截图)
├─ README.md               （可选）
├─ libraries/
│  └─ MyPMSMLibrary.slx     （你的库）
├─ models/
│  ├─ tests/
│  │  └─ Clark_Test.slx     （Clark 单元测试模型）
│  └─ demos/                （以后放示例模型）
├─ blocks/                  （可选：如果你想放子系统源模型）
│  └─ Clark_Source.slx
├─ scripts/
│  ├─ startup.m             （工程打开时自动跑）
│  └─ run_all_tests.m        （一键运行测试）
└─ resources/
   └─ ...                   （图片、文档等）
```
