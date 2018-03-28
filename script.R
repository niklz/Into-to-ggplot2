library(ggplot2)
library(mangoTraining)
# qplot function ----------------------------------------------------------

myPlot <- qplot(carat, price, data = diamonds)
myPlot


qplot(x = mpg, data = mtcars, binwidth = 5)


qplot(hp, mpg, data = mtcars,
      main = 'Horsepower vs MPG\nUsing \"mtcars\" Data',
      xlab = 'Miles/US Gallon',
      ylab = 'Gross Horsepower')


xRange <- c(0, 400)  # A 2-element numeric vector
yRange <- c(0, 35)
qplot(hp, mpg, data = mtcars,
      main = 'Horsepower Vs MPG\nUsing \"mtcars\" Data\n',
      xlab = 'Miles/US Gallon',
      ylab = 'Gross Horsepower',
      xlim = xRange, ylim = yRange)



# layering ----------------------------------------------------------------

qplot(hp, mpg, data = mtcars) +
  ggtitle('Horsepower Vs MPG\nUsing \"mtcars\" Data\n') +
  xlab('Miles/US Gallon') +
  ylab('Gross Horsepower') +
  xlim(xRange) +
  ylim(yRange)


qplot(factor(cyl), mpg, data = mtcars, geom = "boxplot")


grep("^geom", objects("package:ggplot2"), value = TRUE)


qplot(mpg, wt, data = mtcars) + geom_smooth(method = "loess") 
# See ?geom_smooth for details on method



# Exercise One ------------------------------------------------------------


qplot(data = demoData,
      x = factor(Sex),
      y = Height,
      geom = "boxplot")


qplot(x = rnorm(1000), geom = "density")


qplot(data = pkData,
      x = Time,
      y = Conc) + geom_smooth()


qplot(data = pkData,
      x = Time,
      y = Conc) + geom_smooth(method = "lm",
                              se = FALSE)


# Aesthetics --------------------------------------------------------------

qplot(long, lat, data = quakes, size = mag, col = -depth)



# factors -----------------------------------------------------------------

qplot(mpg, wt, data = mtcars, colour = factor(cyl))


qplot(mpg, wt, data = mtcars, colour = I("blue"))



# exercise two ------------------------------------------------------------

qplot(data = demoData,
      x = Height,
      y = Weight,
      colour = Sex,
      shape = Smokes,
      size = I(2))


qplot(data = demoData,
      x = Height,
      y = Weight,
      colour = Sex,
      shape = Smokes)



grep("^scale", objects("package:ggplot2"), value = TRUE)



# Controlling Aesthetics --------------------------------------------------

irisPlot <- qplot(Sepal.Length, Sepal.Width,
                  data = iris, shape = Species)
irisPlot 
irisPlot + scale_shape_manual(values = 1:3)



# Legend Control ----------------------------------------------------------

fiji <- qplot(long, lat, data = quakes,
              size = mag, col = -depth,
              alpha = I(0.5),
              xlab = "Logitude", ylab = "Latitude",
              main = "Locations of Earthquakes off Fiji") 

fiji + scale_colour_continuous("Depth") +
  scale_size_continuous("Magnitude", range = c(2,8))



fiji + scale_colour_continuous("Depth",
                               breaks = seq(0, -600, -100)) +
       scale_size_continuous("Magnitude", range = c(2,8),                      								   breaks = 4:6)




# Grouping ----------------------------------------------------------------

qplot(Time, Conc, data = pkData, geom = "line", group = Subject)



# Faceting ----------------------------------------------------------------

qplot(mpg, wt, data = mtcars) + facet_grid(.~cyl)



# exercise 3 --------------------------------------------------------------

qplot(data = pkData,
      x = Time,
      y = Conc,
      geom = "line",
      group = Subject,
      colour = factor(Dose))


qplot(data = pkData,
      x = Time,
      y = Conc,
      geom = "line",
      group = Subject) + facet_wrap(~Dose)


qplot(data = pkData,
      x = Time,
      y = Conc,
      geom = "line",
      linetype = factor(Dose)) + facet_wrap(~Subject)


qplot(data = demoData,
      x = Height,
      y = Weight) + facet_grid(Sex ~ Smokes)




# the aes function --------------------------------------------------------

concPlot <- ggplot(data = pkData, aes(x = Time, y = Conc,
                                      group = Subject,
                                      linetype = factor(Dose))) 
concPlot <- concPlot + geom_line(colour = "red")
concPlot



# Advanced Examples -------------------------------------------------------

library(dplyr)
mtCopy <- select(mtcars, -cyl)

# Use layers to control the colour of points
ggplot() +
  geom_point(data = mtCopy, aes(x = wt, y = mpg), 
             color = "grey65") +
             geom_point(data = mtcars, aes(x = wt, y = mpg)) +
             # Note that cyl only exists in mtcars not carCopy
             facet_grid( ~ cyl) + 
             ggtitle("MPG vs Weight Automobiles (1973–74 models)\nBy Number    of Cylinders\n") +
             xlab("Weight (lb/1000)") +
             ylab("Miles per US Gallon")
             


# Themes

thm <- qplot(Height, Weight, data = demoData)
# Create a panelled plot:
thm <- thm + facet_grid(Sex ~ Smokes) 
# Now rotate the text in the row strips
thm + theme(strip.text.y = element_text(angle = 0),
            strip.background = element_rect(fill = "orange",
                                            colour = "grey50"))


ggplot(mtcars, aes(x = factor(1), fill = factor(cyl))) +
  geom_bar(width = 1) #+ coord_polar(theta = "y")
