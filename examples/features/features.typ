#import "../../template.typ": *

#set page(height: 100em)
#show: project.with(
  theme: "nocover",
  author: "memset0",
)

#show raw.where(block: true): it => block(
  width: 100%,
  stroke: luma(160) + 0.5pt, 
  radius: 0.25em,
  inset: 1em,
  it
)

= Blocks

我们提供了一系列块函数，以为你带来类似 Obsidian 中 callout 功能的体验。你可以通过修改 `state-block-theme` 状态来使用不同的预设主题，并通过 `blockx` 函数来使用预设块。

为了方便调用，我们还提供了以下别名，他们将通过预设的主题色调用 `blockx` 函数进行渲染：`example`、`proof`、`abstract`、`summary`、`info`、`note`、`tip`、`hint`、`success`、`important`、`help`、`warning`、`attention`、`caution`、`failure`、`danger`、`error`、`bug`、`quote`、`cite`、`experiment`、`question`、`analysis`。

```typst
#state-block-theme.update("theme_name")
#note(name: [Lagrange Inversion Theorem])[
  Given a power serie $F(x)$ and another power series $G(x)$ related by $F(G(x)) = G(F(x)) = x$, then the n-th coefficient of $F(x)$ is
  $ [x^n] F(x) = 1 / n [x^(-1)] 1 / (G^n (x)). $
]
```

#let render(theme_name) = {
  return (
    theme_name,
    {
      state-block-theme.update(theme_name)
      note(name: [Lagrange Inversion Theorem])[
        Given a power serie $F(x)$ and another power series $G(x)$ related by $F(G(x)) = G(F(x)) = x$, then the n-th coefficient of $F(x)$ is
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
