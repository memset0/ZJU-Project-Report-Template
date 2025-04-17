# ZJU-Project-Report-Template ![License](https://img.shields.io/badge/license-MIT-blue)

[简体中文](./README.md) | [English](./README.en.md)

Typst 是一种新兴的文本标记语言，被认为是 LaTeX 的继任者。本项目是一个基于 Typst 的浙江大学课程实验报告模板，主要面向“数据结构基础（211C0020）”和“数字逻辑设计（211C0060）”等课程。

**要求**：Typst 版本需大于等于 0.13。推荐在 VS Code 中安装最新版的 [tinymist](https://github.com/Myriad-Dreamin/tinymist) 插件实现编辑与预览的一体化。

## 配置

### 主题

目前我提供了两种主题，分别对应浙大计算机类课程中常见的实验报告和项目报告。

|                `theme: project`                 |                 `theme: lab`                  |
| :---------------------------------------------: | :-------------------------------------------: |
| ![fds_report_1](./screenshots/fds_report_1.png) | ![dd_report_1](./screenshots/dd_report_1.png) |
| ![fds_report_2](./screenshots/fds_report_2.png) | ![dd_report_2](./screenshots/dd_report_2.png) |
| ![fds_report_3](./screenshots/fds_report_3.png) | ![dd_report_3](./screenshots/dd_report_3.png) |

### 字体

我已为衬线、无衬线和等宽字体配置了默认的回退选项，你可以通过修改 `font_serif`、`font_sans_serif` 和 `font_mono` 参数进行设置。

不过，为了获得更好的渲染体验，推荐使用支持任意字重的中文字体，如 [思源宋体 SC](https://github.com/adobe-fonts/source-han-serif/releases/tag/2.002R)。

## 特性

### 块（Blocks）

我们提供了一系列块函数，带来类似 Obsidian 中 callout 的体验。你可以通过修改 `block_theme` 参数设置主题。

```typst
#note(name: [拉格朗日反演定理])[
  给定幂级数 $F(x)$ 和 $G(x)$，满足 $F(G(x))=G(F(x))=x$，则 $F(x)$ 的第 n 项系数为
  $ [x^n] F(x) = 1/n [x^(-1)] 1/(G^n (x)). $
]
```

我们还提供了如下别名：`example`、`proof`、`abstract`、`summary`、`info`、`note`、`tip`、`hint`、`success`、`important`、`help`、`warning`、`attention`、`caution`、`failure`、`danger`、`error`、`bug`、`quote`、`cite`、`experiment`、`question`、`analysis`。

![themed blocks](./screenshots/themed_blocks.png)

## 贡献

如果你想为本项目提交代码，请先使用推荐的格式化工具 [typstyle](https://github.com/Enter-tainer/typstyle) 进行格式化。请不要提交未经格式化的代码。
