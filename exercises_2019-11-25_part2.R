library(shiny)
library(tidyverse)

shinyApp(
  ui = fluidPage(
    titlePanel("Beta-Binomial App"),
    sidebarLayout(
      sidebarPanel = sidebarPanel(
        h4("ABC:"),
        numericInput("m", "Enter # of simulations:", value = 1e4, min=1, max=1e7),
        h4("Prior:"),
        sliderInput("alpha", "Enter alpha:", value = 1, min=0, max=100, step=0.1),
        sliderInput("beta", "Enter beta:", min=0, max=100, value=1, step=0.1),
        h4("Likelihood:"),
        sliderInput("n", "Enter n:", min=1, max=100, value=10),
        sliderInput("x", "Enter x:", min=1, max=100, value=6)
      ),
      mainPanel = mainPanel(
        plotOutput("plot")
      )
    )
  ),
  server = function(input, output, session) {

    observeEvent(input$n, {
      updateSliderInput(session, "x", max = input$n)
    })

    output$plot = renderPlot({

      marg_lik = integrate(dbinom, 0, 1, x = input$x, size = input$n)$value

      d = tibble(p = seq(0, 1, length.out = 101)) %>%
        mutate(
          prior = dbeta(p, input$alpha, input$beta),
          likelihood = dbinom(input$x, size = input$n, prob = p) / marg_lik,
          posterior = dbeta(p, input$alpha + input$x, input$beta + input$n - input$x)
        )

      prior = rbeta(input$m, input$alpha, input$beta)
      x_sim = rbinom(input$m, input$n, prior)
      post_abc = prior[x_sim == input$x]

      dens_abc = density(post_abc)


      d %>%
        pivot_longer(-p, names_to = "distribution", values_to = "density") %>%
        bind_rows(
          tibble(
            p = dens_abc$x,
            distribution = "posterior (ABC)",
            density = dens_abc$y
          )
        ) %>%
        ggplot(aes(x=p, y=density, color=distribution)) +
          geom_line(size = 1) +
          theme_bw()
    })
  }
)
