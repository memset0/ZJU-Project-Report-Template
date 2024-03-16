# ZJU-Project-Report-Template

Typst is a new text markup language, considered the successor of LaTeX. This is yet another Zhejiang University project report template written in Typst, mainly designed for the course "Fundamentals of Data Structures (211C0020)" and "Digital Logic Design	(211C0060)".

**Reminder**: Due to requirements of some specific courses, disclosing personal information is prohibited and will be punished. So use this project at your own risk.

## Configuration

### Theme

Currently, I have provided two themes, corresponding to common lab reports and project reports in ZJU's Computer Science courses.

|          `theme: project`           |            `theme: lab`            |
| :---------------------------------: | :--------------------------------: |
| ![](./screenshots/fds_report_1.png) | ![](./screenshots/dd_report_1.png) |
| ![](./screenshots/fds_report_2.png) | ![](./screenshots/dd_report_2.png) |
| ![](./screenshots/fds_report_3.png) | ![](./screenshots/dd_report_3.png) |

### Fonts

I have configured default fallback options for serif, sans-serif, and monospace fonts, which you can modify using the `font_serif`, `font_sans_serif`, and `font_mono` arguments.

However, for better rendering experiences, Chineses font families that support arbitrary levels of font weight, such as [`Source Han Serif SC`](https://github.com/adobe-fonts/source-han-serif/releases/tag/2.002R), is recommanded.
