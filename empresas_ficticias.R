###### Organizando os dados ############

# Carregamento dos pacotes
if(!require(pacman)){install.packages("pacman")}
pacman::p_load( readxl, survival,survminer)
install.packages("ggsurvfit")
install.packages("dplyr")
library(dplyr)
library(ggsurvfit)

# Leitura do banco | Créditos da base: diabetic (do pacote survival)
setwd("C:/Users/Alexandra Gomes/Documents/Faculdade/2024/final/analise")
dados <- readxl::read_excel("empresas_ficticias.xlsx")

# Analisamos o tipo dos dados
glimpse(dados)

#Pegar somente o dia das datas
dados$Tempo <- as.numeric(difftime(dados$`Fechamento`, dados$`Abertura`,
                                   units = "days")) 

#Modificar o tipo doa dados da col 2,4,5
#dados[,c(7)] <- lapply(dados[,c(3)], factor) 
glimpse(dados)

########## Curva de sobrevivência para toda a amostra ##############

## Estimador Kaplan-Meier
ekm <- survival::survfit(Surv(Tempo, Status) ~ 1, data = dados)
ekm #media
summary(ekm) #Tabela


## Curva -  ggsurvfit
## https://www.danieldsjoberg.com/ggsurvfit/articles/gallery.html

ggsurvfit(ekm, color = "cadetblue") +
  add_censor_mark(color = "cadetblue") +
  add_confidence_interval(fill = "cadetblue") +
  add_quantile(y_value = 0.5, linetype = "dashed", color = "grey30") + 
  labs(x = "Tempo (dias)", y = "Probabilidade de sobrevivência") +
  scale_ggsurvfit(x_scales = list(breaks = seq(0, 2250, by = 250))) +
  add_risktable(stats_label = c("Em risco", "Eventos")) +
  theme(axis.title = element_text(size = 11),
        axis.title.x = element_text(margin = margin(5,5,15,5)))




# Curva de acordo com uma variável + comparação entre os grupos por log-rank
ekm_trt <- survival::survfit(Surv(Tempo, Status) ~ Regiao,data = dados)

ekm_trt
summary(ekm_trt)


summary(ekm_trt, times = c(500, 1000))


survdiff(Surv(Tempo, Status) ~ Tratamento, data = dados, rho = 0)
# rho = 0 -> equivale ao teste log-rank (= teste Mantel-Haenszel)


## Curva - ggsurvfit
## https://www.danieldsjoberg.com/ggsurvfit/articles/gallery.html

ggsurvfit(ekm_trt) +
  add_censor_mark() +
  add_confidence_interval() +
  add_quantile(y_value = 0.5, linetype = "dashed", color = "grey30") + 
  labs(x = "Tempo (dias)", y = "Probabilidade de sobrevivência") +
  scale_ggsurvfit(x_scales = list(breaks = seq(0, 2250, by = 250))) +
  add_risktable(stats_label = c("Em risco", "Eventos")) +
  theme(axis.title = element_text(size = 11),
        axis.title.x = element_text(margin = margin(5,5,15,5)))


