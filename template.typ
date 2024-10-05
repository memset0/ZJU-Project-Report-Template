#import "@preview/tablex:0.0.8": tablex, colspanx, rowspanx, hlinex, vlinex, cellx
#import "@preview/showybox:2.0.1": showybox

#let state_course = state("course", none)
#let state_author = state("author", none)
#let state_school_id = state("school_id", none)
#let state_date = state("date", none)
#let state_theme = state("theme", none)
#let state_block_theme = state("block_theme", none)

#let _underlined_cell(content, color: black) = {
  tablex(
    align: center + horizon,
    stroke: 0pt,
    inset: 0.75em,
    map-hlines: h => {
      if (h.y > 0) {
        (..h, stroke: 0.5pt + color)
      } else {
        h
      }
    },
    columns: (1fr),
    content,
  )
}

#let fakebold(content) = {
  set text(stroke: 0.02857em) // https://gist.github.com/csimide/09b3f41e838d5c9fc688cc28d613229f
  content
}

#let project(
  theme: "project",
  block_theme: "default",
  course: "<course>",
  title: "<title>",
  title_size: 3em,
  cover_image_padding: 1em,
  cover_image_size: none,
  semester: "<semester>",
  name: none,
  author: none,
  school_id: none,
  date: none,
  college: none,
  place: none,
  teacher: none,
  major: none,
  cover_comments: none,
  cover_comments_size: 1.25em,
  language: none,
  table_of_contents: none,
  font_serif: (
    "New Computer Modern",
    "Georgia",
    "Nimbus Roman No9 L",
    "Songti SC",
    "Noto Serif CJK SC",
    "Source Han Serif SC",
    "Source Han Serif CN",
    "STSong",
    "AR PL New Sung",
    "AR PL SungtiL GB",
    "NSimSun",
    "SimSun",
    "TW\-Sung",
    "WenQuanYi Bitmap Song",
    "AR PL UMing CN",
    "AR PL UMing HK",
    "AR PL UMing TW",
    "AR PL UMing TW MBE",
    "PMingLiU",
    "MingLiU",
  ),
  font_sans_serif: (
    "Noto Sans",
    "Helvetica Neue",
    "Helvetica",
    "Nimbus Sans L",
    "Arial",
    "Liberation Sans",
    "PingFang SC",
    "Hiragino Sans GB",
    "Noto Sans CJK SC",
    "Source Han Sans SC",
    "Source Han Sans CN",
    "Microsoft YaHei",
    "Wenquanyi Micro Hei",
    "WenQuanYi Zen Hei",
    "ST Heiti",
    "SimHei",
    "WenQuanYi Zen Hei Sharp",
  ),
  font_mono: ("Consolas", "Monaco"),
  body,
) = {
  font_mono = (..font_mono, ..font_sans_serif)
  if (theme == "lab") {
    if (cover_image_size == none) {
      cover_image_size = 48%
    }
  } else if (theme == "project") {
    if (cover_image_size == none) {
      cover_image_size = 50%
    }
    if (language == none) {
      language = "en"
    }
    if (table_of_contents == none) {
      table_of_contents = true
    }
  }
  // fallback
  if (language == none) {
    language = "cn"
  }
  if (table_of_contents == none) {
    table_of_contents = false
  }

  set document(author: (author), title: title)

  set page(numbering: "1", number-align: center)

  set text(font: font_serif, lang: language, size: 12pt)
  show raw: set text(font: font_mono)
  show math.equation: set text(weight: 400)

  show par: set block(above: 1.2em, below: 1.2em)

  set par(leading: 0.75em)

  // Update global state
  state_course.update(course)
  state_author.update(author)
  state_school_id.update(school_id)
  state_date.update(date)
  state_theme.update(theme)
  state_block_theme.update(block_theme)

  // Cover Page
  if (theme == "lab") {
    v(1fr)
    align(center, image("./images/ZJU-Banner.png", width: cover_image_size))
    align(center)[
      #set text(size: 26pt)
      #fakebold[本科实验报告]
    ]
    v(2fr)
    let rows = ()
    if (course != none) {
      rows.push("课程名称")
      rows.push(course)
    }
    if (name != none) {
      rows.push("实验名称")
      rows.push(name)
    }
    if (author != none) {
      rows.push([姓$space.quad space.quad$名])
      rows.push(author)
    }
    if (school_id != none) {
      rows.push([学$space.quad space.quad$号])
      rows.push(school_id)
    }
    if (college != none) {
      rows.push([学$space.quad space.quad$院])
      rows.push(college)
    }
    if (major != none) {
      rows.push([专$space.quad space.quad$业])
      rows.push(major)
    }
    if (place != none) {
      rows.push([实验地点])
      rows.push(place)
    }
    if (teacher != none) {
      rows.push([指导教师])
      rows.push(teacher)
    }
    if (date != none) {
      rows.push([报告日期])
      rows.push(date)
    }
    align(
      center,
      box(width: 75%)[
        #set text(size: 1.2em)
        #tablex(
        columns: (6.5em + 5pt, 1fr),
        align: center + horizon,
        stroke: 0pt,
        // stroke: 0.5pt + red, // this line is just for testing
        inset: 1pt,
        map-cells: cell => {
          if (cell.x == 0) {
            _underlined_cell([#cell.content#"："], color: white)
          } else {
            _underlined_cell(cell.content, color: black)
          }
        },
        ..rows,
      )
      ],
    )
    v(2fr)
    pagebreak()

  } else if (theme == "project") {
    v(1fr)
    box(
      width: 100%,
      align(center)[
        #text(2em, weight: 900)[
          #course
        ]

        #text(title_size, weight: 700)[
          #title
        ]

        #v(cover_image_padding)
        #image("./images/ZJU-Logo.png", width: cover_image_size)
        #v(cover_image_padding)

        #if (cover_comments == none) [
          #text(cover_comments_size)[
            #v(1em)
            #if (author != none) [
              Author: #author
            ]

            Date: #date

            #semester Semester
          ]
        ] else [
          // If cover_comments is assigned, it will be used as the cover's original comments
          #cover_comments
        ]
      ],
    )
    v(4fr)
    pagebreak()

  } else if (theme == "nocover") {
    // no cover page

  } else {
    set text(fill: red, size: 3em, weight: 900)
    align(center)[Theme not found!]
    pagebreak()
  }

  if (table_of_contents) {
    outline(title: text(1.1em, "Table of Contents"), depth: 3, indent: 1.2em)
    pagebreak()
  }

  set par(justify: true)
  set table(align: center + horizon, stroke: 0.5pt)

  if (theme == "lab") {
    set heading(numbering: (..args) => {
      let nums = args.pos()
      if nums.len() == 1 {
        return none
      } else if nums.len() == 2 {
        return numbering("一、", ..nums.slice(1))
      } else {
        return numbering("1.1)", ..nums.slice(1))
      }
    })

    body
  } else {
    set heading(numbering: (..args) => {
      let nums = args.pos()
      if nums.len() == 1 {
        return none
      } else {
        return numbering("1.1)", ..nums)
      }
    })

    body
  }
}

#let codex(code, lang: none, size: 1em, border: true) = {
  if code.len() > 0 {
    if code.ends-with("\n") {
      code = code.slice(0, code.len() - 1)
    }
  } else {
    code = "// no code"
  }
  set text(size: size)
  align(left)[
    #if border == true {
      block(width: 100%, stroke: 0.5pt + luma(150), radius: 4pt, inset: 8pt)[
        #raw(lang: lang, block: true, code)
      ]
    } else {
      raw(lang: lang, block: true, code)
    }
  ]
}

#let importCode(file, namespace: none, lang: "cpp") = {
  let source_code = read(file)
  let code = ""
  let note = ""
  let flag = false
  let firstlines = true

  for line in source_code.split("\n") {
    if namespace != none and line == ("} // namespace " + namespace) {
      flag = false
    }
    if namespace == none or flag {
      if firstlines and line.starts-with("// ") {
        note += line.slice(3) + "\n"
      } else {
        code += line + "\n"
        firstlines = false
      }
    }
    if namespace != none and line == ("namespace " + namespace + " {") {
      flag = true
    }
  }

  if note.len() > 0 {
    block(note)
  }

  codex(code, lang: lang, size: 1.05em)
}

#let lab_header(
  course: none,
  type: "综合",
  name: "<name>",
  author: none,
  school_id: none,
  place: "<place>",
  date: none,
) = {
  pagebreak(weak: true)
  align(center)[
    #set text(size: 1.5em)
    #fakebold[浙江大学实验报告]
  ]
  tablex(
    columns: (1fr, 0.32fr, 1.68fr, 1fr, 1fr, 1fr),
    align: center + horizon,
    stroke: 0pt,
    inset: 1pt,
    _underlined_cell("课程名称：", color: white),
    colspanx(
      2,
      _underlined_cell(if course == none {
        state_course.display()
      } else {
        course
      }),
    ),
    (),
    _underlined_cell("实验类型：", color: white),
    colspanx(2, _underlined_cell(type)),
    (),
    colspanx(2, _underlined_cell("实验项目名称：", color: white)),
    (),
    colspanx(4, _underlined_cell(name)),
    (),
    (),
    (),
    _underlined_cell("学生姓名：", color: white),
    colspanx(
      2,
      _underlined_cell(if author == none {
        state_author.display()
      } else {
        author
      }),
    ),
    (),
    _underlined_cell("学号：", color: white),
    colspanx(
      2,
      _underlined_cell(if school_id == none {
        state_school_id.display()
      } else {
        school_id
      }),
    ),
    (),
    _underlined_cell("实验地点：", color: white),
    colspanx(2, _underlined_cell(place)),
    (),
    _underlined_cell("实验日期：", color: white),
    colspanx(
      2,
      _underlined_cell(if date == none {
        state_date.display()
      } else {
        date
      }),
    ),
    (),
  )
}

#let table3( // 三线表
  ..args,
  inset: 0.5em,
  stroke: 0.5pt,
  align: center + horizon,
  columns: (1fr),
) = {
  tablex(
    columns: (1fr),
    inset: 0pt,
    stroke: 0pt,
    map-hlines: h => {
      if (h.y > 0) {
        (..h, stroke: (stroke * 2) + black)
      } else {
        h
      }
    },
    tablex(
      ..args,
      inset: inset,
      stroke: stroke,
      align: align,
      columns: columns,
      map-hlines: h => {
        if (h.y == 0) {
          (..h, stroke: (stroke * 2) + black)
        } else if (h.y == 1) {
          (..h, stroke: stroke + black)
        } else {
          (..h, stroke: 0pt)
        }
      },
      auto-vlines: false,
    ),
  )
}

#let figurex(img, caption) = {
  show figure.caption: it => {
    set text(size: 0.9em, fill: luma(100), weight: 700)
    it
    v(0.1em)
  }
  set figure.caption(separator: ":")
  figure(
    img,
    caption: [
      #set text(weight: 400)
      #caption
    ],
  )
}

#let blockx(it, name: "", color: red, theme: none) = {
  context {
    let _theme = theme
    if (_theme == none) {
      _theme = state_block_theme.get()
    }
    if (_theme == "default") {
      let _inset = 0.8em
      let _color = color.darken(5%)
      v(0.2em)
      block(below: 1em, stroke: 0.5pt + _color, radius: 3pt, width: 100%, inset: _inset)[
        #place(
          top + left,
          dy: -6pt - _inset, // Account for inset of block
          dx: 8pt - _inset,
          block(fill: white, inset: 2pt)[
            #set text(font: "Noto Sans", fill: _color)
            #name
          ],
        )
        #set text(fill: _color)
        #set par(first-line-indent: 0em)
        #it
      ]
    } else if (_theme == "boxed") {
      showybox(
        title: name,
        frame: (
          border-color: color,
          title-color: color.lighten(20%),
          body-color: color.lighten(95%),
          footer-color: color.lighten(80%),
        ),
        it,
      )
    } else if (_theme == "float") {
      showybox(
        title-style: (
          boxed-style: (anchor: (x: center, y: horizon), radius: (top-left: 10pt, bottom-right: 10pt, rest: 0pt)),
        ),
        frame: (
          title-color: color.darken(5%),
          body-color: color.lighten(95%),
          footer-color: color.lighten(60%),
          border-color: color.darken(20%),
          radius: (top-left: 10pt, bottom-right: 10pt, rest: 0pt),
        ),
        title: name,
        [
          #it
          #v(0.25em)
        ],
      )
    } else if (_theme == "thickness") {
      showybox(
        title-style: (color: color.darken(20%), sep-thickness: 0pt, align: center),
        frame: (title-color: color.lighten(85%), border-color: color.darken(20%), thickness: (left: 1pt), radius: 0pt),
        title: name,
        it,
      )
    } else if (_theme == "dashed") {
      showybox(
        title: name,
        frame: (
          border-color: color,
          title-color: color,
          radius: 0pt,
          thickness: 1pt,
          body-inset: 1em,
          dash: "densely-dash-dotted",
        ),
        it,
      )
    } else {
      block(
        width: 100%,
        stroke: 0.5pt + red,
        inset: 1em,
        radius: 5pt,
        align(center)[
          #set text(fill: red, size: 1.5em)
          Unknown block theme!
        ],
      )
    }
  }
}

#let example(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Example")
  },
  color: gray.darken(60%),
)
#let proof(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Proof")
  },
  color: rgb(120, 120, 120),
)
#let abstract(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Abstract")
  },
  color: rgb(0, 133, 143),
)
#let summary(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Summary")
  },
  color: rgb(0, 133, 143),
)
#let info(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Info")
  },
  color: rgb(68, 115, 218),
)
#let note(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Note")
  },
  color: rgb(68, 115, 218),
)
#let tip(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Tip")
  },
  color: rgb(0, 133, 91),
)
#let hint(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Hint")
  },
  color: rgb(0, 133, 91),
)
#let success(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Success")
  },
  color: rgb(62, 138, 0),
)
#let important(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Important")
  },
  color: rgb(62, 138, 0),
)
#let help(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Help")
  },
  color: rgb(153, 110, 36),
)
#let warning(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Warning")
  },
  color: rgb(184, 95, 0),
)
#let attention(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Attention")
  },
  color: rgb(216, 58, 49),
)
#let caution(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Caution")
  },
  color: rgb(216, 58, 49),
)
#let failure(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Failure")
  },
  color: rgb(216, 58, 49),
)
#let danger(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Danger")
  },
  color: rgb(216, 58, 49),
)
#let error(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Error")
  },
  color: rgb(216, 58, 49),
)
#let bug(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Bug")
  },
  color: rgb(204, 51, 153),
)
#let quote(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Quote")
  },
  color: rgb(132, 90, 231),
)
#let cite(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Cite")
  },
  color: rgb(132, 90, 231),
)
#let experiment(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Experiment")
  },
  color: rgb(132, 90, 231),
)
#let question(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Question")
  },
  color: rgb(132, 90, 231),
)
#let analysis(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Analysis")
  },
  color: rgb(0, 133, 91),
)
