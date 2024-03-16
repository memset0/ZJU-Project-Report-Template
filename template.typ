#import "@preview/tablex:0.0.8": tablex, colspanx, rowspanx, hlinex, vlinex, cellx

#let state_course = state("course", none)
#let state_author = state("author", none)
#let state_school_id = state("school_id", none)
#let state_date = state("date", none)

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

#let project(
  theme: "project",
  course: "<course>",
  title: "<title>",
  title_size: 3em,
  cover_image_padding: 1em,
  cover_image_size: none,
  semester: "<semester>",
  author: none,
  school_id: none,
  date: none,
  college: none,
  teacher: none,
  major: none,
  cover_comments: none,
  cover_comments_size: 1.25em,
  language: none,
  table_of_contents: none,
  font_serif: ("New Computer Modern", "Georgia", "Nimbus Roman No9 L", "Songti SC", "Noto Serif CJK SC", "Source Han Serif SC", "Source Han Serif CN", "STSong", "AR PL New Sung", "AR PL SungtiL GB", "NSimSun", "SimSun", "TW\-Sung", "WenQuanYi Bitmap Song", "AR PL UMing CN", "AR PL UMing HK", "AR PL UMing TW", "AR PL UMing TW MBE", "PMingLiU", "MingLiU"),
  font_sans_serif: ("Noto Sans", "Helvetica Neue", "Helvetica", "Nimbus Sans L", "Arial", "Liberation Sans", "PingFang SC", "Hiragino Sans GB", "Noto Sans CJK SC", "Source Han Sans SC", "Source Han Sans CN", "Microsoft YaHei", "Wenquanyi Micro Hei", "WenQuanYi Zen Hei", "ST Heiti", "SimHei", "WenQuanYi Zen Hei Sharp"),
  font_mono: ("Consolas", "Monaco"),
  body
) = {
  font_mono = (..font_mono, ..font_sans_serif)
  if (theme == "lab") {
    if (cover_image_size == none) {
      cover_image_size = 48%
    }
    if (language == none) {
      language = "cn"
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

  // Cover Page
  if (theme == "lab") {
    v(1fr)
    align(center, image("./images/ZJU-Banner.png", width: cover_image_size))
    align(center)[
      #set text(size: 26pt, weight: 700)
      本科实验报告
    ]
    v(2fr)
    align(center, box(width: 75%)[
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
        [课程名称], course,
        [姓　　名], author,
        [学　　号], school_id,
        [学　　院], college,
        [专　　业], major,
        [指导教师], teacher,
        [报告日期], date,
      )
    ])
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
      ]
    )
    v(4fr)
    pagebreak()
  } else {
    set text(fill: red, size: 3em, weight: 900)
    align(center)[Theme not found!]
    pagebreak()
  }


  if (table_of_contents) {
    outline(
      title: text(1.1em, "Table of Contents"),
      depth: 3,
      indent: 1.2em,
    )
    pagebreak()
  }


  set par(justify: true)
  set heading(numbering: (..args) => {
    let nums = args.pos()
    if nums.len() == 1 {
      return none
    } else {
      return numbering("1.1)", ..nums)
    }
  })
  set table(align: center + horizon, stroke: 0.5pt)

  body
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
      block(
        width: 100%,
        stroke: 0.5pt + luma(150),
        radius: 4pt,
        inset: 8pt,
      )[
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
    #set text(size: 1.5em, weight: 700)
    浙江大学实验报告
  ]
  tablex(
    columns: (1fr, 0.3fr, 1.7fr, 1fr, 1fr, 1fr),
    align: center + horizon,
    stroke: 0pt,
    inset: 1pt,
    _underlined_cell("课程名称：", color: white),
    colspanx(2, _underlined_cell(
      if course == none {
        state_course.display()
      } else {
        course
      }
    )), (),
    _underlined_cell("实验类型：", color: white),
    colspanx(2, _underlined_cell(
      type
    )), (),
    colspanx(2, _underlined_cell("实验项目名称：", color: white)), (),
    colspanx(4, _underlined_cell(
      name
    )), (), (), (),
    _underlined_cell("学生姓名：", color: white),
    colspanx(2, _underlined_cell(
      if author == none {
        state_author.display()
      } else {
        author
      }
    )), (),
    _underlined_cell("学号：", color: white),
    colspanx(2, _underlined_cell(
      if school_id == none {
        state_school_id.display()
      } else {
        school_id
      }
    )), (),
    _underlined_cell("实验地点：", color: white),
    colspanx(2, _underlined_cell(
      place
    )), (),
    _underlined_cell("实验日期：", color: white),
    colspanx(2, _underlined_cell(
      if date == none {
        state_date.display()
      } else {
        date
      }
    )), (),
  )
}

#let figurex(
  img,
  caption,
) = {
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
    ]
  )
}

#let blockx(it, name: "", color: red, inset: 11pt) = block(
  below: 1em, stroke: 0.5pt + color, radius: 3pt,
  width: 100%, inset: inset
)[
  #place(
    top + left,
    dy: -6pt - inset, // Account for inset of block
    dx: 8pt - inset,
    block(fill: white, inset: 2pt)[
			#set text(font: "Noto Sans", fill: color)
			#strong[#name]
		]
  )
  #set text(fill: color)
  #set par(first-line-indent: 0em)
  #it
]

#let example(it) = blockx(it, name: "Example", color: gray.darken(60%))
#let proof(it) = blockx(it, name: "Proof", color: rgb(120, 120, 120))
#let abstract(it) = blockx(it, name: "Abstract", color: rgb(0, 133, 143))
#let summary(it) = blockx(it, name: "Summary", color: rgb(0, 133, 143))
#let info(it) = blockx(it, name: "Info", color: rgb(68, 115, 218))
#let note(it) = blockx(it, name: "Note", color: rgb(68, 115, 218))
#let tip(it) = blockx(it, name: "Tip", color: rgb(0, 133, 91))
#let hint(it) = blockx(it, name: "Hint", color: rgb(0, 133, 91))
#let success(it) = blockx(it, name: "Success", color: rgb(62, 138, 0))
#let important(it) = blockx(it, name: "Important", color: rgb(62, 138, 0))
#let help(it) = blockx(it, name: "Help", color: rgb(153, 110, 36))
#let warning(it) = blockx(it, name: "Warning", color: rgb(184, 95, 0))
#let attention(it) = blockx(it, name: "Attention", color: rgb(216, 58, 49))
#let caution(it) = blockx(it, name: "Caution", color: rgb(216, 58, 49))
#let failure(it) = blockx(it, name: "Failure", color: rgb(216, 58, 49))
#let danger(it) = blockx(it, name: "Danger", color: rgb(216, 58, 49))
#let error(it) = blockx(it, name: "Error", color: rgb(216, 58, 49))
#let bug(it) = blockx(it, name: "Bug", color: rgb(204, 51, 153))
#let quote(it) = blockx(it, name: "Quote", color: rgb(132, 90, 231))
#let cite(it) = blockx(it, name: "Cite", color: rgb(132, 90, 231))
#let experiment(it) = blockx(it, name: "Experiment", color: rgb(132, 90, 231))
#let question(it) = blockx(it, name: "Question", color: rgb(132, 90, 231))
#let analysis(it) = blockx(it, name: "Analysis", color: rgb(0, 133, 91))
