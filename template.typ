#let titlepage(
  title: none,
  subtitle: none,
  authors: (),
  handledare: (none,false),
  kurs: none,
  kurskod: none,
  body
) = [
#counter(page).update(0)
#page(columns: 1, header: [], numbering: none,margin: (bottom:2.5cm),

[  
#box[
#align(left+top)[
    #image("_res/lth_logo.png",width: 5cm)
]
]
#align(center)[
  #v(1cm)
  #text(size: 24pt,font: "New Computer Modern")[
  #title]\
  
  #text(size: 16pt,font: "New Computer Modern")[#subtitle]

  #text(size: 14pt,
    for author in authors [
      #author.name\
    ]
  )
]

#align(left+bottom,
[
  #text(size:12pt, font: "New Computer Modern")[
    #grid(
      columns: 2,
      column-gutter: 12pt,
      row-gutter: 5pt,
        (
        if handledare.at(1) {
          [Handledare:] 
        } ),(
        if handledare.at(1) {
          [#handledare.at(0)] 
        }),
        [Kurs:], [#kurs],
        [Kurskod:], [#kurskod]
      
    )
  ]
]
)
]
)

]



//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MAIN
#let conf(
  title: "Placeholder",
  subtitle: none,
  authors: (),
  handledare: (none,true),
  

  firstpage: true,
  abstract: none,
  abstract_style: none,
  bibliography: none,
  kurs: none,
  kurskod: none,
  toc: false,
  indent: false,
  lang: "sv",
  ncols: 2,
  doc
) = {

set document(title: title, author: authors.map(author => author.name), date: none)

//let page_lang = if lang == "sv" {("Sida "," av ")} else {("Page "," av ")}

set page(
  paper: "a4",
  margin: (top:19mm,left: 13mm,right: 13mm,bottom: 47mm),
  header: [
    #text(size: 10pt)[
    #title
    #h(1fr)
    #kurs, #kurskod
    #line(length: 100%, stroke: 0.2pt)]
  ],
  numbering: (..i)=> "Sida " + str(i.at(0)) +" av " + str(i.at(-1)),
  columns: ncols
)

set columns(gutter: 16pt)

set table(stroke: 0.3pt)


let spacing = if indent { 0.65em } else { 1.2em }
let indent = if indent {1.5em} else {0em}
set par(
  justify: true,
  first-line-indent: indent,
  spacing: spacing
)

set heading(numbering: "1.1.1")

show figure.where(kind: table): set figure.caption(position: top)

set ref(supplement: none)


set text(
  font: "New Computer Modern",
  size: 12pt,
  lang: lang

)



// Titlepage
if firstpage {
titlepage(
    title: title,
    subtitle: subtitle,
    authors: authors,
    handledare: handledare,
    kurs: kurs,
    kurskod: kurskod,
    []
  )
} else {
// code from ieee
  place(
    top,
    float: true,
    scope: "parent",
    clearance: 30pt,
    {
      v(3pt, weak: true)
      align(center, par(leading: 0.5em, text(size: 24pt, title)))
      v(8.35mm, weak: true)

      // Display the authors list.
      set par(leading: 0.6em)
      for i in range(calc.ceil(authors.len() / 3)) {
        let end = calc.min((i + 1) * 3, authors.len())
        let is-last = authors.len() == end
        let slice = authors.slice(i * 3, end)
        grid(
          columns: slice.len() * (1fr,),
          gutter: 12pt,
          ..slice.map(author => align(center, {
            text(size: 11pt, author.name)
            if "department" in author [
              \ #emph(author.department)
            ]
            if "organization" in author [
              \ #emph(author.organization)
            ]
            if "location" in author [
              \ #author.location
            ]
            if "email" in author {
              if type(author.email) == str [
                \ #link("mailto:" + author.email)
              ] else [
                \ #author.email
              ]
            }
          }))
        )

        if not is-last {
          v(16pt, weak: true)
        }
      }
    }
  )
}

set math.equation(numbering: "(1)")

if abstract_style  == "runin" [
  *_Abstract_---#abstract*
]
if abstract_style == "page" and firstpage [
  #page(columns: 1)[
  #align(center)[
    #box(width: 80%)[
    #text(size: 14pt)[
      *Abstract*
    ]
    \
    
    #abstract
  ]
]
]
]

// TOC-page
if toc and firstpage {
page(columns: 1, [
  #align(center)[
    #box(width: 80%)[
      #outline(indent: auto)
    ]
  ]
])
}



doc
}