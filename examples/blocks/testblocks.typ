#import "../../template.typ": *

#set page(height: 85em)
#show: project.with(
  theme: "nocover",
  author: "memset0",
)

#let render(theme_name) = [
  #state_block_theme.update(theme_name)
  = theme: #theme_name

  #note(name: [Lagrange Inversion Theorem])[
    Given a power serie $F(x)$ and another power series $G(x)$ related by $F(G(x))=G(F(x))=x$, then the nth coefficient of $F(x)$ is
    $ [x^n] F(x) = 1/n [x^(-1)] 1/(G^n (x)). $
  ]

  #v(1em)
]

#render("default")
#render("boxed")
#render("float")
#render("thickness")
#render("dashed")


#state_block_theme.update("rounded")

= Otherwise, you will get an error block!

#state_block_theme.update("xxx")

#note[Hello, World!]
