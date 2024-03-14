// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#let project(
  course: "Fundamentals of Data Structures",
  title: "",
  title_size: 3em,
  cover_image_padding: 1em,
  cover_image_size: 50%,
  semester: "2023-2024 Spring & Summer",
  author: none,
  date: none,
  cover_comments: none,
  cover_comments_size: 1.35em,
  body
) = {
  // Set the document's basic properties.
  set document(author: (author), title: title)
  set page(numbering: "1", number-align: center)
  set text(font: "New Computer Modern", lang: "en", size: 12pt)
  show math.equation: set text(weight: 400)

  show par: set block(above: 1.2em, below: 1.2em)

  set par(leading: 0.75em)

  // Cover Page
  v(0.6fr)

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
        #cover_comments
      ]
    ]
  )

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