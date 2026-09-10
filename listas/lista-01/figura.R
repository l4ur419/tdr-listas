# Leitura dos dados a partir do diretório atual
dados <-read.csv("airquality.csv")

# Abre o dispositivo PDF para salvar o gráfico
pdf("figura.pdf", width = 7, height = 5)

# Cria um boxplot de Ozone por Mês
boxplot(Ozone ~ Month,
  data =dados,
  main ="Distribuição de Ozone por Mês",
  xlab ="Mês", ylab = "Ozone (ppb)",
  col ="lightblue"
)

# Fecha o dispositivo
dev.off()
