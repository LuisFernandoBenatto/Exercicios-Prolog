% 1
adiciona(X,L,[X|L]).
% 2
apaga(X,[X|R],R).
apaga(X,[Y|R1],[Y|R2]):-apaga(X,R1,R2).
% 3
membro( X, [X|_] ).
membro( X, [_|R] ) :- membro( X, R ).
% 4
concatena([],L,L).
concatena([X|L1],L2,[X|L3]):- concatena(L1,L2,L3).
% 5
comprimento(0,[]).
comprimento(N,[_|R]):- comprimento(N1,R), N is 1 + N1.
% 6
max(X,[X]).
max(X,[Y|R]):- max(X,R), X > Y, !. 
max(Y,[Y|_]).
% 7
somatorio(0,[]).
somatorio(X,[Y|R]):- somatorio(S,R), X is S+Y.
media(X,L):- comprimento(N,L), somatorio(S,L), X is S/N.
%8
nelem(N,L,X):-nelem(N,1,L,X).
nelem(N,N,[X|_],X):-!.
nelem(N,I,[_|R],X):- I1 is I+1, nelem(N,I1,R,X).

% testar os predicados: 

questao_1_a(L):-adiciona(1,[2,3],L). % L = [1, 2, 3]
questao_1_b(X):-adiciona(X,[2,3],[1,2,3]). % X = 1
questao_1(L):-adiciona(1,L,[1,2,3]). % L = [2, 3]

questao_2_a(L):-apaga(a,[a,b,a,c],L). % L = [b, a, c] % L = [a, b, c]
questao_2_b(L):-apaga(a,L,[b,c]). % L = [a, b, c] % L = [b, a, c] % L = [b, c, a]

questao_3_a:-membro(b,[a,b,c]). % true
questao_3_b(X):-membro(X,[a,b,c]). % X = a % X = b % X = c
questao_3_c(L):-findall(X,membro(X,[a,b,c]),L). % L = [a, b, c]

questao_4_a(L):-concatena([1,2],[3,4],L). % L = [1, 2, 3, 4]
questao_4_b(L):-concatena([1,2],L,[1,2,3,4]). % L = [3, 4]
questao_4_c(L):-concatena(L,[3,4],[1,2,3,4]). % L = [1, 2]

questao_5(X):-comprimento(X,[a,b,c]). % X = 3

questao_6(X):-max(X,[3,2,1,7,4]). % X = 7

questao_7(X):-media(X,[1,2,3,4,5]). % X = 3

questao_8_a:-nelem(2,[1,2,3],2). % true
questao_8_b(X):-nelem(3,[1,2,3],X). % X = 3
questao_8_c(X):-nelem(4,[a,b,c,d,e,f,g],X). % X = d