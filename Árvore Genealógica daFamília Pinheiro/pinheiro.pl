% factos

progenitor(maria,joao). 
progenitor(jose,joao). 
progenitor(maria,ana). 
progenitor(jose,ana). 
progenitor(joao,mario).
progenitor(ana,helena). 
progenitor(ana,joana). 
progenitor(helena,carlos). 
progenitor(mario,carlos). 

sexo(ana,feminino).
sexo(maria,feminino).
sexo(joana,feminino).
sexo(helena,feminino).

sexo(mario,masculino).
sexo(joao,masculino).
sexo(jose,masculino).
sexo(carlos,masculino).

irma(X,Y):- progenitor(A,X), progenitor(A,Y), X\==Y, sexo(X,feminino).

irmao(X,Y):- progenitor(A,X), progenitor(A,Y), X\==Y, sexo(X,masculino).

descendente(X,Y):- progenitor(X,Y).
descendente(X,Y):- progenitor(X,A), descendente(A,Y).

avo(X,Y):- progenitor(X,A), progenitor(A,Y), sexo(X,masculino).

mae(X,Y):- progenitor(X,Y), sexo(X,feminino).

pai(X,Y):- progenitor(X,Y), sexo(X,masculino).

tio(X,Y):- irmao(X,A), progenitor(A,Y).

primo(X,Y):-irmao(A,B), progenitor(A,X), progenitor(B,Y), X\==Y.

primo(X,Y):-irma(A,B), progenitor(A,X), progenitor(B,Y), X\==Y.

% questoes:

q1:- progenitor(jose,joao). % true
q1b:- pai(jose,joao). % true

q2(X):- mae(maria,X). % X = joao X = ana
q2b(L):-findall(X,mae(maria,X),L). % L = [joao, ana]

q3(X):- primo(mario,X). % X = helena X = joana 
q3b(L):- findall(X,primo(mario,X),L). % L = [helena, joana, helena, joana]
q3c(L):- findall(X,primo(mario,X),LR),list_to_set(LR,L). % L = [helena, joana],
% LR = [helena, joana, helena, joana]

q4(X):- tio(_,X). % X = helena X = joana 
q4b(L):- findall(X,tio(_,X),LR),list_to_set(LR,L). % L = [helena, joana],
% LR = [helena, joana, helena, joana]

q5(X):- descendente(X,carlos). % X = helena X = mario X = maria X = jose X = maria X = jose X = joao X = ana
q5b(L):- findall(X,descendente(X,carlos),L). % L = [helena, mario, maria, jose, maria, jose, joao, ana]

q6a(X):- irmao(helena,X). % false
q6b(X):- irma(helena,X). % joana
