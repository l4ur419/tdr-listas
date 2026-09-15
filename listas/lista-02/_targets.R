library(targets)
library(tarchetypes)

#Avisa ao targets onde estao as funcoes do projeto
source(here::here("R", "funcoes.R"))

#Define o pipeline e os sete alvos
list(
  #Alvo 1: O arquivo de dados original (format = "file")
  tar_target(
    arquivo_entrada,
    here::here("dados", "airquality.csv"),
    format = "file"
  ),
  
  #Alvo 2: Ler os dados (usa o resultado do alvo 1)
  tar_target(
    dados_lidos,
    ler_dados(arquivo_entrada)
  ),
  
  #Alvo 3: Calcular as medias mensais
  tar_target(
    medias,
    medias_mensais(dados_lidos)
  ),
  
  #Alvo 4: Ajustar o modelo linear
  tar_target(
    modelo,
    ajustar_modelo(dados_lidos)
  ),
  
  #Alvo 5: Gerar a figura (format = "file" pois devolve um PNG fisico)
  tar_target(
    figura,
    salvar_figura(dados_lidos, modelo, here::here("saidas", "dispersao.png")),
    format = "file"
  ),
  
  #Alvo 6: Exportar as médias para um CSV físico (format = "file")
  tar_target(
    arquivo_medias,
    {
      caminho <- here::here("saidas", "medias.csv")
      write.csv(medias, caminho, row.names = FALSE)
      caminho
    },
    format = "file"
  ),
  tar_quarto(relatorio, "relatorio.qmd")
)