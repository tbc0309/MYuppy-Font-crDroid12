# MYuppy-Font-crDroid12

面向 Android 16 的 KernelSU Next 系统字体模块。模块通过 Hybrid Mount（OverlayFS）替换 Android、CJK 回退、Google Sans 和 Google Sans Text 字体，不直接写入物理系统分区。

> [!IMPORTANT]
> 安装脚本仅校验 Android 版本，要求 Android 16（SDK 36）。下列环境已完成实机验证，其他 Android 16 设备及 ROM 请自行测试兼容性。

## 已验证环境

| 项目 | 版本 / 配置 |
| --- | --- |
| 机型 | Xiaomi Mi 9 |
| 设备代号 | `cepheus` |
| 系统 | crDroid `v12.12-20260912` |
| Android | Android 16 / SDK 36 |
| 内核 | `4.14.355-openela-InfiniR_cepheus_v2.02_A16_KSUN` |
| KernelSU Next | Legacy 核心 `v3.2.0` / 管理器 `v3.2.0 (33129)` |
| 挂载模块 | Hybrid Mount `6.2.2` / OverlayFS |

## Root 与挂载组件

### KernelSU Next

- 当前内核核心：`v3.2.0-legacy-susfs-v2 (33136)`，`BUILT-IN (LEGACY)`。
- 当前 `ksud`：`3.2.0`。
- 当前管理器：`v3.2.0 (33129)`。
- 官方发布页：[KernelSU Next v3.2.0](https://github.com/KernelSU-Next/KernelSU-Next/releases/tag/v3.2.0)。
- 管理器 APK：[KernelSU_Next_v3.2.0_33129-release.apk](https://github.com/KernelSU-Next/KernelSU-Next/releases/download/v3.2.0/KernelSU_Next_v3.2.0_33129-release.apk)。
- APK SHA-256：`96c2bbbf1b973461fe82dd1ed17f89deb86a6a5a9d7c4cf079bd32091131ef57`。

KernelSU Next 核心已集成在当前 ROM 的 4.14 Legacy 内核中。管理器 APK 与内核核心是两部分；安装新版管理器并不会把内核核心一并升级，也不要向本机刷入面向 5.10 或更高版本内核的模块或 boot 镜像。

### Hybrid Mount（OverlayFS）

- 当前版本：`6.2.2 (602002999)`。
- 当前挂载实现：`OverlayFS`。
- 官方发布页：[Hybrid Mount v6.2.2](https://github.com/Hybrid-Mount/meta-hybrid_mount/releases/tag/v6.2.2)。
- 模块 ZIP：[Hybrid-Mount-6.2.2-2053.zip](https://github.com/Hybrid-Mount/meta-hybrid_mount/releases/download/v6.2.2/Hybrid-Mount-6.2.2-2053.zip)。
- ZIP SHA-256：`52f067cfea4fafc2bde333bf717bf5338e244faca156caaf557a0288ce1b963c`。

### KernelSU Next 3.4.0 兼容性

更新到 `v12.12-20260912` 后，本机仍使用 `4.14.355` Legacy 内核和 KernelSU Next `3.2.0` Legacy 核心。KernelSU Next [v3.4.0 官方发布](https://github.com/KernelSU-Next/KernelSU-Next/releases/tag/v3.4.0)提供的内核模块从 5.10 起步，没有适用于 4.14 Legacy 内核的官方成品，因此当前系统不能通过官方 v3.4.0 包把内核核心升级到 3.4.0。

不建议只把管理器 APK 更新到 3.4.0：这不会升级内核中的 3.2.0 核心，而且当前 `legacy-susfs-v2` 组合没有经过该管理器版本的实机配对验证。现阶段应继续使用管理器 `v3.2.0 (33129)`。只有 ROM 或内核维护者提供并验证了适配本机 4.14 Legacy 内核的新构建后，才考虑整体升级。

## 字体接管范围

- 默认 `sans-serif` 与 `sans-serif-condensed`。
- 简体中文与繁体中文回退字体。
- 系统界面使用的静态 Google Sans 与 Google Sans Text 字体族及粗细变体。
- 保留时钟和 Material 可变字体族，避免静态字体破坏可变轴配置。

当前实机字体服务已确认 `sans-serif`、`google-sans`、`google-sans-text` 以及中文回退链均加载 MYuppy 字体文件。

## 安全机制

- 安装时仅校验 Android 版本；非 Android 16 系统将停止安装。
- 安装前检查模块自身所需文件是否完整。
- 检测其他已启用的字体模块，发现配置冲突时停止安装。
- 通过 KernelSU metamodule 系统无损挂载，不直接写入物理系统分区。
- 出现显示异常时，可在 KernelSU Next 中停用或删除 `MYuppy Font` 后重启恢复。

## 安装

1. 安装并启用 [Hybrid Mount 6.2.2](https://github.com/Hybrid-Mount/meta-hybrid_mount/releases/tag/v6.2.2)。
2. 在 KernelSU Next 中安装 Release 提供的 `MYuppy-Font-v1.0.0.zip`。
3. 重启设备。

本机建议保持 KernelSU Next 管理器 `v3.2.0 (33129)`，与 ROM 内置的 3.2.0 Legacy 核心配套使用。

## 字体来源与许可

- 字体来源：[jyxdd/MYuppy-dospy](https://github.com/jyxdd/MYuppy-dospy)。
- `MYuppy-Regular.ttf` 取自上游 `MYuppydospytw-Regular.ttf`，文件内容保持一致，仅为模块内引用而重命名。
- `MYuppy-Bold.ttf` 是为本模块生成的衍生粗体文件。
- 原始 MYuppy 字体由 Monotype Imaging Inc. 提供，原始说明声明采用 [Eclipse Public License 1.0](https://www.eclipse.org/legal/epl-v10.html)，且 MYuppy 名称涉及 Monotype Imaging Inc. 的商标限制。字体文件及其衍生文件继续受原字体许可与相关权利约束，不因本项目采用 MIT License 而变更许可。
- 上游对字体进行过调整；具体来源说明请参阅其 [README](https://github.com/jyxdd/MYuppy-dospy) 和 [原始字体说明](https://github.com/jyxdd/MYuppy-dospy/blob/master/MYuppyGB-Medium_README.TXT)。

## 项目许可

除字体文件及其衍生文件外，本项目的脚本、配置和文档采用 [MIT License](LICENSE)。第三方字体的版权与许可信息见 [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)。
