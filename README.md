c3
================

[![DOI](https://zenodo.org/badge/60614778.svg)](https://zenodo.org/badge/latestdoi/60614778) [![Build Status](https://travis-ci.org/mrjoh3/c3.svg?branch=master)](https://travis-ci.org/mrjoh3/c3) [![codecov](https://codecov.io/gh/mrjoh3/c3/branch/master/graph/badge.svg)](https://codecov.io/gh/mrjoh3/c3) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/c3)](http://cran.r-project.org/package=c3/) [![](http://cranlogs.r-pkg.org/badges/c3)](http://cran.r-project.org/package=c3)![CRAN Downloads](http://cranlogs.r-pkg.org/badges/grand-total/c3)

The `c3` package is a wrapper, or [htmlwidget](http://www.htmlwidgets.org/), for the [C3](http://c3js.org/) javascript charting library by [Masayuki Tanaka](https://github.com/masayuki0812). You will find this package useful if you are wanting create a chart using [R](https://www.r-project.org/) for embedding in a Rmarkdown document or Shiny App.

The `C3` library is very versatile and includes a lot of options. Currently this package wraps most of the `C3` [options object](http://c3js.org/reference.html). Even with this current limitation a wide range of options are available.

Warning
-------

This package is under active development and will definitely change. All attempts will be made to maintain the functionality and methods demonstrated in this document. Documentation is currently a work in progress.

Any suggestions, advice or requests are welcome. For any bugs (there will be bugs) please submit an [issue](https://github.com/mrjoh3/c3/issues).

Installation
------------

You probably already guessed this bit.

``` r
devtools::install_github("mrjoh3/c3")
```

Usage
-----

Please note that this package is under active development and may change at any time. The plots that currently work are line (and varieties), bar and scatter plots. Where possible the package tries to emulate the [Grammer of Graphics](https://books.google.com.au/books?id=ZiwLCAAAQBAJ&lpg=PR3&dq=inauthor%3A%22Leland%20Wilkinson%22&pg=PR3#v=onepage&q&f=false) used in Hadley Wickham's [ggplot2](http://ggplot2.org/).

The `c3` package is intended to be as simple and lightweight as possible. As a starting point the data input must be a `data.frame` with several options.

-   If a `data.frame` without any options is passed all of the numeric columns will be plotted. This can be used in line and bar plots. Each column is a line or bar.
-   For more complex plots only 3 columns are used, those defined as `x`, `y` and `group`. This requires a `data.frame` with a vertical structure.

### The Basics

Where no options are supplied a simple line plot is produced by default. Where no x-axis is defined the plots are sequential. `Date` x-axis can be parsed with not additional setting if in the format `%Y-%m-%d` (ie '2014-01-01')

``` r
library(c3)

data <- data.frame(a = abs(rnorm(20) * 10),
                   b = abs(rnorm(20) * 10),
                   date = seq(as.Date("2014-01-01"), by = "month", length.out = 20))

c3(data)
```

<img src="README_files/figure-markdown_github/data-1.png" style="display: block; margin: auto;" />

### Piping

The package also imports the [magrittr](https://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html) piping function (`%>%`) to simplify syntax.

``` r
data %>% c3() 
```

<img src="README_files/figure-markdown_github/pipe-1.png" style="display: block; margin: auto;" />

Other Line Plots
----------------

There are 5 different line plots available:

-   line
-   spline
-   step
-   area
-   area-step

#### Spline

``` r
data %>%
  c3() %>%
  c3_line('spline')
```

<img src="README_files/figure-markdown_github/spline-1.png" style="display: block; margin: auto;" />

#### Step

``` r
data %>%
  c3(x = 'date') %>%
  c3_line('area-step')
```

<img src="README_files/figure-markdown_github/step-1.png" style="display: block; margin: auto;" />

Bar Plots
---------

``` r
data[1:10, ] %>%
  c3() %>%
  c3_bar(stacked = TRUE, 
         rotate = TRUE)
```

<img src="README_files/figure-markdown_github/bar-1.png" style="display: block; margin: auto;" />

Mixed Geometry Plots
--------------------

Mixed geometry currently only works with a horizontal `data.frame` where each numeric column is plotted.

``` r
data$c <- abs(rnorm(20) *10)
data$d <- abs(rnorm(20) *10)

data %>%
  c3() %>%
  c3_mixedGeom(type = 'bar', 
               stacked = c('b','d'),
               types = list(a='area',
                            c='spline')
               )
```

<img src="README_files/figure-markdown_github/mixed-1.png" style="display: block; margin: auto;" />

Secondary Y Axis
----------------

To use a secondary Y axis columns must first be matched to an axis and then the secondary axis made visible.

``` r
data %>% 
  select(date, a, b) %>%
  c3(x = 'date',
     axes = list(a = 'y',
                 b = 'y2')) %>% 
  c3_mixedGeom(types = list(a = 'line',
                            b = 'area')) %>% 
  y2Axis()
```

<img src="README_files/figure-markdown_github/y2-1.png" style="display: block; margin: auto;" />

Scatter Plot
------------

``` r
iris %>%
  c3(x = 'Sepal_Length', 
     y = 'Sepal_Width', 
     group = 'Species') %>% 
  c3_scatter()
```

<img src="README_files/figure-markdown_github/scatter-1.png" style="display: block; margin: auto;" />

Pie Charts
----------

``` r
data.frame(sugar = 20,
           fat = 45,
           salt = 10) %>% 
  c3() %>% 
  c3_pie()
```

<img src="README_files/figure-markdown_github/pie-1.png" style="display: block; margin: auto;" />

Donut Charts
------------

``` r
data.frame(red = 82, green = 33, blue = 93) %>% 
  c3(colors = list(red = 'red',
                   green = 'green',
                   blue = 'blue')) %>% 
  c3_donut(title = '#d053ee')
```

<img src="README_files/figure-markdown_github/donut-1.png" style="display: block; margin: auto;" />

Gauge Charts
------------

``` r
data.frame(data = 80) %>% 
  c3() %>% 
  c3_gauge()
```

<img src="README_files/figure-markdown_github/gauge-1.png" style="display: block; margin: auto;" />

Grid Lines & Annotation
-----------------------

``` r
data %>%
  c3() %>%
  grid('y') %>%
  grid('x', 
       show = F, 
       lines = data.frame(value = c(3, 10), 
                          text = c('Line 1','Line 2')))
```

<img src="README_files/figure-markdown_github/grid-1.png" style="display: block; margin: auto;" />

Region Highlighting
-------------------

To highlight regions pass a single `data.frame` with columns `axis`, `start`, `end` and `class`. Multiple regions can be defined within the one `data.frame` for any axis (`x`, `y`, `y2`). Each row in the `data.frame` defines a separate region to be highlighted

``` r
data %>%
  c3() %>%
  region(data.frame(axis = 'x',
                    start = 5,
                    end = 6))
```

<img src="README_files/figure-markdown_github/region-1.png" style="display: block; margin: auto;" />

Sub-chart
---------

``` r
data %>%
  c3(x = 'date') %>%
  subchart()
```

<img src="README_files/figure-markdown_github/subchart-1.png" style="display: block; margin: auto;" />

Color Palette
-------------

Plot color palettes can be changed to either `RColorBrewer` or `viridis` palettes using either `RColorBrewer` (S3 method) or `c3_viridus`.

``` r
data.frame(sugar = 20, 
           fat = 45, 
           salt = 10, 
           vegetables = 60) %>% 
  c3() %>% 
  c3_pie() %>%
  RColorBrewer()
```

<img src="README_files/figure-markdown_github/brewer-1.png" style="display: block; margin: auto;" />

``` r
data.frame(sugar = 20, 
           fat = 45, 
           salt = 10, 
           vegetables = 60) %>% 
  c3() %>% 
  c3_pie() %>%
  c3_viridis()
```

<img src="README_files/figure-markdown_github/viridis-1.png" style="display: block; margin: auto;" />

Point Size
----------

``` r
data %>%
  c3(x = 'date') %>%
  point_options(r = 6, 
                expand.r = 2)
```

<img src="README_files/figure-markdown_github/point-1.png" style="display: block; margin: auto;" />

On Click
--------

Onclick, onmouseover and onmouseout are all available via the `c3` function. To use wrap a js function as a character string to `htmlwidgets::JS()`. Please see the [C3.js documentation](http://c3js.org/reference.html#data-onclick) and [examples](http://c3js.org/samples/chart_pie.html). The example below should be enough to get you started.

``` r
data %>% 
    c3(onclick = htmlwidgets::JS('function(d, element){console.log(d)}'))
```

Tooltips
--------

`C3` tooltips are readily modified with the use of javascript functions. For further detail see the `C3.js` [documentation](http://c3js.org/reference.html#tooltip-format-title). Or for more advanced usage see the `C3.js` [examples](http://c3js.org/samples/tooltip_format.html) page.

``` r
library(htmlwidgets)

data %>%
  c3() %>%
  tooltip(format = list(title = JS("function (x) { return 'Data ' + x; }"),
                        name = JS('function (name, ratio, id, index) { return name; }'),
                        value = JS('function (value, ratio, id, index) { return ratio; }')))
```

<img src="README_files/figure-markdown_github/tooltip-1.png" style="display: block; margin: auto;" />
