# plusUltraProject
Projeto acadêmico de desenvolvimento para cadeira de Estágio Supervisionado 1

## Nome do Jogo:
* Plus Ultra - The Space Crusade.
## Gênero: 
* Space Shooter.
## Público Alvo: 
* Jovens e Adultos.
## Objetivo Geral: 
* Obter o máximo de pontuação possível sem ser atingido por um asteroide.
## Objetivo Específico: 
* Destruir o máximo de asteroides sem ser atingido e coletar o máximo de itens possíveis.
## Enredo e Personagens: 
* Para estabelecer bases para o avanço das expedições espaciais é necessário ultrapassar 
  uma barreira quase intransponível, a do cinturão de asteroides. 
* O objetivo do comandante desta expedição espacial é definir as melhores rotas espaciais, estabelecer sinalizações e coletar recursos     minerais dos asteroides para dar base financeira e de recursos necessários para garantia de futuras expedições. Entretanto, o cinturão   de asteroides é umas das zonas mais complicadas da exploração espacial e por isso se faz necessário utilizar o máximo de recurso         bélico para ultrapassar. 
  essa verdadeira “muralha espacial”.
## Iteração do jogador: 
* O jogador irá interagir com os controladores exibidos em tela.
## Controle: 
* Botões virtuais de tiro e de uso de item; setas de movimentação de direita e esquerda.
## Diagrama de navegação: 
* https://drive.google.com/file/d/1wypLU9XHJOeqkkgo8ZGa3P0NeshB4TqS/view?usp=sharing
## Regras do jogo com sistema de pontuação : 
### Sistema de Vida: 
* Quando um asteroide atinge a nave o recomeça do desde o ponto inicial(Não há registro de progresso no decorrer do jogo).
### Sistema de Pontos: 
#### Tempo
* Cada segundo sem morrer: 0.016 ponto
* Cada minuto sem morrer: 1 ponto
#### Ganhando Pontos
* Destruição de lixo espacial : 0
* Destruição de asteroides pequenos: 10 pontos.
* Destruição de asteroides médios: 100 pontos.
* Destruição de asteroides grandes: 1000 pontos.
#### Perdendo Pontos
* Ser atingido por lixo espacial: -100
* Ser atigindo por asteroides pequenos: -10 pontos.
* Ser atigindo por asteroides médios: -100 pontos.
* Ser atigindo por asteroides grandes: -1000 pontos.
## Eventos
### Asteroides
#### Destruindo asteroides
* Para destruir lixo espacial: 1 tiro
* Para destruir asteroide pequeno: 2 tiros
* Para destruir asteroide médio: 3 tiros
* Para destruir asteroides grande: 5 tiros
#### Após destruir asteroides
* Asteroide Grande: Gera 4 Asteroides médios ou um item.
* Asteroides Médios: Gera 2 asteroides ou um item.
* Asteroide Pequeno: Não gera nada.
## Como o jogo acaba? : 
* O jogo encerra quando ultrapassar uma "linha de chegada" que determina o fim do cinturão de asteroides.
