#import "../../template.typ": *

#set page(height: 100em)
#show: project.with(
  theme: "nocover",
  author: "memset0",
)

= Blocks

```typst
#state-block-theme.update("theme_name")
#note(name: [Lagrange Inversion Theorem])[
  Given a power serie $F(x)$ and another power series $G(x)$ related by $F(G(x))=G(F(x))=x$, then the nth coefficient of $F(x)$ is
  $ [x^n] F(x) = 1 / n [x^(-1)] 1 / (G^n (x)). $
]
```

#let render(theme_name) = {
  return (
    theme_name,
    {
      state-block-theme.update(theme_name)
      note(name: [Lagrange Inversion Theorem])[
        Given a power serie $F(x)$ and another power series $G(x)$ related by $F(G(x))=G(F(x))=x$, then the nth coefficient of $F(x)$ is
        $ [x^n] F(x) = 1 / n [x^(-1)] 1 / (G^n (x)). $
      ]
    },
  )
}
#table(
  columns: (5em, 1fr),
  inset: 1em,
  table.header(
    [*Theme*],
    [*Preview*],
  ),
  ..render("default"),
  ..render("boxed"),
  ..render("float"),
  ..render("thickness"),
  ..render("dashed"),
  ..render("-"),
)
