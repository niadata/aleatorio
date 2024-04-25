#UESTAO 1

library("igraph")
require(igraph)

#Carregando o arquivo
archive <- read.csv("Tabela1.csv", header = T)

# Suponha que 'dados' seja o nome da sua tabela
coluna<- subset(archive, select = c("Atividade", "Pred"))

#usando o arquivo online
g<-graph_from_data_frame(coluna,directed=T)

V(g)
V(g)$label <- V(net)$name
V(net)$degree <- degree (net)

set.seed(222)
plot(g,
     vertex.color = "green",
     vertex.size = 22,
     edge.arrow.size = 1.5,
     vertex.label.cex = 0.5)


#QUESTAO 2

library("igraph")
require(igraph)

#Carregando o arquivo
archive <- read.csv("Tabela1.csv", header = T)

# Suponha que 'dados' seja o nome da sua tabela
coluna<- subset(archive, select = c("Pred", "DMin"))

#usando o arquivo online
g<-graph_from_data_frame(coluna,directed=T)

#Plotando o gráfico
set.seed(222)
plot(g,
     vertex.color = "green",
     vertex.size = 22,
     edge.arrow.size = 1.5,
     vertex.label.cex = 0.5)

#Achando a Entrada
?degree
entrada <- V(g)[degree(g,mode = "in") ==0]

#Achando a saída
saida <- V(g)[degree(g,mode = "out")==0]

print("Atividades de entrada:")
print(V(g)$name[entrada])

print("Atividades de saída")
print(V(g)$name[saida])


#QUESTAO3

require(igraph)

#Carregando o arquivo
arquivo <- read.csv("Tabela1.csv", header = T)

# Suponha que 'dados' seja o nome da sua tabela
coluna<- subset(arquivo, select = c("Pred", "DMin"))

#Achando a Entrada
entrada <- V(g)[degree(g,mode = "in") ==0]

#Achando a saída
saida <- V(g)[degree(g,mode = "out")==0]

tabela <- data.frame(V(g)$name[entrada], V(g)$name[saida])

#usando o arquivo online
g<-graph_from_data_frame(coluna,directed=T)

#Plotando o gráfico
set.seed(222)
plot(g,
     vertex.color = "green",
     vertex.size = 22,
     edge.arrow.size = 1.5,
     vertex.label.cex = 0.5)




#QUESTÃO 4

install.packages('readr')
library('readr')

#Carregando o arquivo
Tabela1 <- readr::read_csv2("https://docs.google.com/spreadsheets/d/13mjNgYcBwfYVRArWgODNwfeDrKGNyAS3CO_W7mZmX58/edit?usp=sharing")
Tabela1 <- read_csv(file = "Tabela1.csv")

n_amostras <- 50
amostras <- replicate(n_amostras, mean(sample(Tabela1$DMin)))
#warnings()

options(stringsAsFactors = FALSE)

media_DMin <- mean(Tabela1$DMin)
media_DMp <- mean(Tabela1["DMp"])
media_DMax <- mean(Tabela1["DMax"])

TE <- (4*media_DMax+media_Dmin+media_DMp)/6
desvio <-(media_DMin-media_DMax)/6
