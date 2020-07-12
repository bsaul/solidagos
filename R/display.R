#' Plot populations
#'
#' NOTE: this is partly hardcoded to handle \code{example_study_area}
#'
#' @importFrom ggplot2 ggplot
#' @importFrom scales seq_gradient_pal
#' @export
draw_populations <- function(x) {
  dat <- tibble::tibble(!!! x[c("x", "y", "species", "color")],
                        !!! x[["properties"]])

  cols <- dplyr::distinct(dat, species, color) %>%
    {
      x <- .
      purrr::set_names(x$color, x$species)
    }

  backgrounder <- scales::seq_gradient_pal(low = "#b2e2e2", high = "#006d2c")
  fill <- backgrounder(dat$propA[1])

  ggplot(
    data = dat,
    aes(x = x , y = y, color = species)
  ) +
    geom_rect(
      mapping = aes(xmin = 0, xmax = 1, ymin = 0, ymax = 0.25),
      fill = fill
    ) +
    geom_point(
      shape = 1
    ) +
    scale_color_manual(
      values = cols
    ) +
    scale_y_continuous(
      expand = c(0, 0),
      limits = x$window$yrange
    )+
    scale_x_continuous(
      expand = c(0, 0),
      limits = x$window$xrange
    ) +
    guides(
      fill = "none"
    ) +
    theme_void() +
    theme(
      legend.background = element_blank(),
      legend.box.background = element_blank(),
      plot.margin      = unit(c(1, 1, 1, 1), "mm"),
      panel.background = element_rect(fill = NULL, color = "black")
    )
}

#' Plot study area
#'
#' NOTE: this simply draws a list of study areas sequentially
#'
#' @export
draw_study_area <- function(x) {

  x %>%
    purrr::imap_dfr(
      .f = ~ {
        tibble::tibble(
          x    = .x$window$xrange[1] + (.y - 1),
          xend = .x$window$xrange[2] + (.y - 1),
          y    = .x$window$yrange[1],
          yend = .x$window$yrange[2],
          !!! .x$properties
        )
      }
    ) %>%
    ggplot(
      aes(x = x, y = y, fill = propA)
    ) +
    geom_raster() +
    scale_x_continuous(expand = c(0, 0)) +
    scale_y_continuous(expand = c(0, 0)) +
    scale_fill_gradient(
      guide = FALSE,
      low = "#b2e2e2", high = "#006d2c"
    ) +
    theme_void() +
    theme(
      # axis.line.x      = element_line(color = "grey50", size = 5),
      plot.margin      = unit(c(1, 1, 1, 1), "mm"),
      panel.background = element_rect(fill = NULL, color = NULL)
    )
}
