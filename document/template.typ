// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!

#import "@preview/lovelace:0.2.0": *

#let project(title: "", authors: (), logo: none, date: none, body) = {
  // Set the document's basic properties.
  set document(author: authors, title: title)
  set page(numbering: "1", number-align: center)
  set text(font: "New Computer Modern", lang: "en", size: 12pt)
  show math.equation: set text(weight: 400)

  // Set paragraph spacing.
  show par: set block(above: 1.2em, below: 1.2em)

  set par(leading: 0.75em)

  // Title page.
  // The page can contain a logo if you pass one with `logo: "logo.png"`.
  v(0.6fr)
  if logo != none {
    align(right, image(logo, width: 26%))
  }
  v(9.6fr)

  box(
    width: 100%,
    align(center)[
      #text(2em, weight: 900)[
        Fundamentals of Data Structures
      ]

      #text(3em, weight: 700)[
        #title
      ]

      #v(1em)
      #image("./images/ZJU-Logo.png", width: 50%)
      #v(2em)

      #text(1.35em)[
        Date: #date

        2023-2024 Spring & Summer Semester
      ]

      #v(12em)
    ]
  )

  // Author information.
  // pad(
  //   top: 0.7em,
  //   right: 20%,
  //   grid(
  //     columns: (1fr,) * calc.min(3, authors.len()),
  //     gutter: 1em,
  //     ..authors.map(author => align(start, strong(author))),
  //   ),
  // )

  v(2.4fr)
  pagebreak()


  // Table of contents.
  outline(
    title: text(1.1em, "Table of Contents"),
    depth: 3,
    indent: 1.2em,
  )
  pagebreak()


  // Main body.
  set par(justify: true)
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

  if code.len() > 0 {
    code = code.slice(0, code.len() - 1)
  } else {
    code = "// no code"
  }
  set text(size: 13pt)
  raw(lang: lang, block: true, code)
}