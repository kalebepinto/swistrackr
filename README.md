
# swistrackr

O pacote R swistrackr é um conjunto de scripts que auxiliam na análise de dados
de rastreamento de objetos com base em dados de coordenadas x e y. Inicialmente,
este pacote R foi criado para ser aplicado em conjunto com dados provenientes
do software livre Swistrack4, mas podem ser aplicados em outros conjuntos de
dados que utilizem coordenadas x e y para localizar um  objeto ao longo do tempo.

## Instalação

Para o processo de rastreamento de objetos até a análise dos dados, utilizamos
as seguintes ferramentas:
	
### *Swistrack4*

No SourceForge você encontra para download o software [Swistrack4 para Windows](https://sourceforge.net/projects/swistrack/). Também é necessário a
instalação do pacote de codecs de vídeos [K-Lite Codec Pack](http://www.codecguide.com/download_kl.htm) (recomendanos o download da versão Mega). Se houver dúvidas, você pode acessar
este tutorial de [instalação do Swistrack4 para Windows](https://youtu.be/g18WtIhrsb4).
Você também pode acessar ao [tutorial de preparação de arquivos](https://youtu.be/A4IahW5J-Ig) e ao [tutorial de utilização do Swistrack4](https://youtu.be/ou0MpSuAoNc) para
informações de como utilizar o programa para rastreamento de objetos em vídeos.

### *FFmpeg*

O FFmpeg é uma biblioteca de código aberto, utilizada para edição de áudio e
vídeo através de linhas de comando. O pacote R swistrackr utiliza o FFmpeg em
algumas de suas funções para obter dados de vídeo e imagem, mas de forma mais
prática e que não exigem do usuário trabalho de codificação mais avançada. Para
mais informações, você pode acessar este tutorial de [instalação do FFmpeg](https://youtu.be/Eb06D8tk6NM)
e sua configuração no sistema.

### *swistrackr*

O pacote R swistrackr se encontra depositado no Github. Para instalação utilize:


```{package install, message=FALSE}
if(!require(devtools)){
  install.packages('devtools')
  library(devtools)
}
devtools::install_github("kalebepinto/swistrackr", build_vignettes = TRUE)
```

## Utilização do pacote

Depois de instalado, carregue a biblioteca e execute os exemplos:

```{examples, message=FALSE}
library(swistrackr)

# Extrair frames do video para criacao do arquivo background.jpg
salami('data/example_2/swistrack_video_2.avi',
       c('00:00:05', '00:00:10'), 'bg.jpg', 3)

# Obter informacoes de dimensao do arquivo background.jpg
background(img = 'data/example_2/swistrack_background_2.jpg')

# Obter informcoes de duracao e framerate do video
video <- track_video('data/example_2/swistrack_video_2.avi')

# Obter informacoes dos dados de coordenadas, background e video
swis_set(swis.out = 'data/example_2/swistrack_output_2.txt',
         swis.video = 'data/example_2/swistrack_video_2.avi',
         swis.bg = 'data/example_2/swistrack_background_2.jpg')

# Permite ao usuario determinar as zonas de interesse no video
output.zones <- zones(img = 'data/example_2/swistrack_background_2.jpg',
                      nzones = 1, pzones = 4)

# Retorna ao usuario o tempo em que o objeto permaneceu nas zonas de interesse
times('data/example_2/swistrack_output_2.txt', output.zones, video)

# Retorna ao usuario a ordem em que as zonas de interesse foram visitadas
visits('data/example_2/swistrack_output_2.txt', output.zones)
```

## Licença

O pacote R swistrackr é de código aberto e livre para contribuições.
