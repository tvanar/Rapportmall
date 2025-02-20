#import "template.typ": conf

#let title = "Placeholder Title"
#let subtitle = "Placeholder Subtitle"
#let kurs = "Elektromagnetisk Fältteroi"
#let kurskod = "EITF70"
#let handledare = ("Anders Andersson",false)
#let authors = (
    (
      name: "Author 1",
      email: "mail@gmail.com",
    ),
    (
      name: "Author 2",
      email: "mail@hotmail.com"
    ),

  )


#show: conf.with(
  title: [
      #title
  ],
  subtitle: subtitle,
  authors: authors,
  kurs: kurs,
  kurskod: kurskod,
  handledare: handledare,

  //Settings
  firstpage: true,
  lang: "sv",
  toc: true,
  indent: false,
  ncols: 2,

  abstract_style: "page",
  abstract: "Detta är en abstract. " + lorem(80)
)

//Text here -- USE SUBFILES
#include "chapters/introduktion.typ"

#include "chapters/metod.typ"


