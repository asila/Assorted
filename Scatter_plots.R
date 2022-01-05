# Ensure the following packages are installed in your computer:
# 1. ggside
# 2. ggstatsplot
# 3. ggpubr
# 4. xlsx
# 5. grid
# 6. gridExtra

# To install use: install.packages(c(,,,,)) syntax

library(ggstatsplot)

library(ggpubr)

library(xlsx)

library(tidyverse)

library(grid)

library(gridExtra)

setwd('~/Towett/Data')

artax <- read.xlsx2('1639712705061_hav phase 2 artax phase 2 all fixed.xlsx', 2)

colnames(artax)

# Drop empty column X

artax <- select(artax, -X.)

colnames(artax)

# Get scatter plot for Ca K line and Ca wt percent but we notice two columns are labelled Ca.wt...; check these first:

with(artax, plot(Ca.wt..., Ca.wt....1))

# The 1:1 plot produced above reveals these two columns are the same, thus drop 1.

artax <- select(artax, -Ca.wt....1)


# Clean up allthe column names and drop the suffix ...
colnames(artax) <- gsub("...","", colnames(artax), fixed = TRUE)

colnames(artax)

write.csv(artax, file = 'Cleaned_data.csv', row.names = FALSE)

artax <- read.csv('Cleaned_data.csv')

# 1. Ca
ca <- ggscatterstats(
  data  = artax,
  x     = Ca.K12,
  y     = Ca.wt,
  xlab  = "Ca.K12 (photons)",
  ylab  = "Ca.wt (%)",
  title = "Artax measured Ca"
)

ca  <- ca + theme(plot.title = element_text(hjust = 0.5))

ca

ggsave(file = "~/Towett/Figs/Ca_concentration.png", height = 4, width = 4,ca)



# 2. Zn
zn <- ggscatterstats(
  data  = artax,
  x     = Zn.K12,
  y     = Zn.wt,
  xlab  = "Zn.K12 (photons)",
  ylab  = "Zn.wt (%)",
  title = "Artax measured Zn"
)

zn  <- zn + theme(plot.title = element_text(hjust = 0.5))

zn

ggsave(file = "~/Towett/Figs/Zn_concentration.png", height = 4, width = 4,zn)


# 3. Zr
zr <- ggscatterstats(
  data  = artax,
  x     = Zr.K12,
  y     = Zr.wt,
  xlab  = "Zr.K12 (photons)",
  ylab  = "Zr.wt (%)",
  title = "Artax measured Zr"
)

zr  <- zr + theme(plot.title = element_text(hjust = 0.5))

zr

ggsave(file = "~/Towett/Figs/Zr_concentration.png", height = 4, width = 4,zr)


# 4. Cr
cr <- ggscatterstats(
  data  = artax,
  x     = Cr.K12,
  y     = Cr.wt,
  xlab  = "Cr.K12 (photons)",
  ylab  = "Cr.wt (%)",
  title = "Artax measured Cr"
)

cr  <- cr + theme(plot.title = element_text(hjust = 0.5))

cr

ggsave(file = "~/Towett/Figs/Cr_concentration.png", height = 4, width = 4,cr)


# 5. Cr Exclude high Cr.wt value > 0.9

cr1 <- ggscatterstats(
  data  = filter(artax,Cr.wt < 0.5),
  x     = Cr.K12,
  y     = Cr.wt,
  xlab  = "Cr.K12 (photons)",
  ylab  = "Cr.wt (%)",
  title = "Artax measured Cr"
)

cr1  <- cr1 + theme(plot.title = element_text(hjust = 0.5))

cr1
ggsave(file = "~/Towett/Figs/Cr1_concentration.png", height = 4, width = 4,cr1)

# 6. Te
te <- ggscatterstats(
  data  = artax,
  x     = Te.K12,
  y     = Te.wt,
  xlab  = "Te.K12 (photons)",
  ylab  = "Te.wt (%)",
  title = "Artax measured Te"
)

te  <- te + theme(plot.title = element_text(hjust = 0.5))

te
ggsave(file = "~/Towett/Figs/Te_concentration.png", height = 4, width = 4,te)



# Save generated plots into figs folder

#Using grid.arrange we can combine several plots together and save:
ggsave(file = "~/Towett/Figs/Elemental.concentrations.png", height = 9, width = 9,grid.arrange(zn,ca,zr,cr, ncol=2, nrow=2,top = textGrob("Elemental Concentrations",gp=gpar(fontsize=20,font=3))))


####################################

# Get another version of scatter plots using ggpubr package

# 1. Ca
ca <-ggscatter(artax, x = "Ca.K12", y = "Ca.wt", color = "black",
          add = "reg.line",  # Add regressin line
          add.params = list(color = "blue", fill = "red"), # Customize reg. line
          conf.int = TRUE, # Add confidence interval
          cor.coef = TRUE, # Add correlation coefficient. see ?stat_cor
          xlab  = "Ca.K12 (photons)",
          ylab  = "Ca.wt (%)",
          title = "Artax measured Ca"
)

ca  <- ca + theme(plot.title = element_text(hjust = 0.5))

ca

ggsave(file = "~/Towett/Figs/ggpubr/Ca_concentration.png", height = 4, width = 4,ca)


# 2. Zn
zn <-ggscatter(artax, x = "Zn.K12", y = "Zn.wt", color = "black",
               add = "reg.line",  # Add regressin line
               add.params = list(color = "blue", fill = "grey"), # Customize reg. line
               conf.int = TRUE, # Add confidence interval
               cor.coef = TRUE, # Add correlation coefficient. see ?stat_cor
               xlab  = "Zn.K12 (photons)",
               ylab  = "Zn.wt (%)",
               title = "Artax measured Zn"
)

zn  <- zn + theme(plot.title = element_text(hjust = 0.5))

zn

ggsave(file = "~/Towett/Figs/ggpubr/Zn_concentration.png", height = 4, width = 4,zn)


# 3. Zr
zr <-ggscatter(artax, x = "Zr.K12", y = "Zr.wt", color = "black",
               add = "reg.line",  # Add regressin line
               add.params = list(color = "blue", fill = "grey"), # Customize reg. line
               conf.int = TRUE, # Add confidence interval
               cor.coef = TRUE, # Add correlation coefficient. see ?stat_cor
               xlab  = "Zr.K12 (photons)",
               ylab  = "Zr.wt (%)",
               title = "Artax measured Zr"
)

zr  <- zr + theme(plot.title = element_text(hjust = 0.5))

zr

ggsave(file = "~/Towett/Figs/ggpubr/Zr_concentration.png", height = 4, width = 4,zr)

# 4. Cr
cr <-ggscatter(artax, x = "Cr.K12", y = "Cr.wt", color = "black",
               add = "reg.line",  # Add regressin line
               add.params = list(color = "blue", fill = "grey"), # Customize reg. line
               conf.int = TRUE, # Add confidence interval
               cor.coef = TRUE, # Add correlation coefficient. see ?stat_cor
               xlab  = "Cr.K12 (photons)",
               ylab  = "Cr.wt (%)",
               title = "Artax measured Cr"
)

cr  <- cr + theme(plot.title = element_text(hjust = 0.5))

cr

ggsave(file = "~/Towett/Figs/ggpubr/Cr_concentration.png", height = 4, width = 4,cr)


# Drop the large Cr value
# 5. Cr
cr1 <-ggscatter(data  = filter(artax,Cr.wt < 0.5), x = "Cr.K12", y = "Cr.wt", color = "black",
               add = "reg.line",  # Add regressin line
               add.params = list(color = "blue", fill = "lightblue"), # Customize reg. line
               conf.int = TRUE, # Add confidence interval
               cor.coef = TRUE, # Add correlation coefficient. see ?stat_cor
               xlab  = "Cr.K12 (photons)",
               ylab  = "Cr.wt (%)",
               title = "Artax measured Cr"
)

cr1  <- cr1 + theme(plot.title = element_text(hjust = 0.5))

cr1

ggsave(file = "~/Towett/Figs/ggpubr/Cr_concentration minus high value.png", height = 4, width = 4,cr1)


# 6. Te
te <-ggscatter(artax, x = "Te.K12", y = "Te.wt", color = "black",
                add = "reg.line",  # Add regression line
                add.params = list(color = "blue", fill = "lightblue"), # Customize reg. line
                conf.int = TRUE, # Add confidence interval
                cor.coef = TRUE, # Add correlation coefficient. see ?stat_cor
                xlab  = "Te.K12 (photons)",
                ylab  = "Te.wt (%)",
                title = "Artax measured Te"
)

te  <-  + theme(plot.title = element_text(hjust = 0.5))

te

ggsave(file = "~/Towett/Figs/ggpubr/Te_concentration.png", height = 4, width = 4,te)



# Save all
ggsave(file = "~/Towett/Figs/ggpubr/Elemental.concentrations.png", height = 9, width = 12,grid.arrange(zn,ca,zr,cr,cr1, te, ncol= 3, nrow=2,top = textGrob("Elemental Concentrations",gp=gpar(fontsize=20,font=3))))


# Next we need to ensure regression line passes through the origin.
