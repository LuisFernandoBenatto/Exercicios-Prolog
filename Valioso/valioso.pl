valioso(ouro). %Ouro é valioso
valioso(prata).

possui(jane, ouro). %Jane possui ouro

gosta(pedro, maria). %Pedro gosta de Maria
gosta(maria, pedro). %Maria gosta de Pedro
gosta(pedro, X) :- possui(X,ouro). %regra Pedro gosta de quem possui ouro

mulher(jane). %Jane é mulher
mulher(maria). %Jane é mulher

entrega(romeu, livro, maria). %Romeu entrega o livro a Maria