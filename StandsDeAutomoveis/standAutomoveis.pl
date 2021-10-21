:- dynamic(stand/2).

% 1: representacao da base de dados
stand(vegas,[
    cliente(rui,2324,23,medico,[ 
        carro(audi,a2,20000),
        carro(bmw,serie3,30000)
    ]),
    cliente(rita,2325,32,advogado,[
        carro(audi,a3,30000)
    ]),
    cliente(joao,2326,26,professor,[
        moto(honda,gl1800,26000)
    ]),
    cliente(ana,2327,49,medico,[
        carro(audi,a4,40000),
        carro(bmw,serie3,32000),
        carro(ford,focus,24000)
    ])
]).

stand(miami,[ 
    cliente(rui,3333,33,operario,[
        carro(fiat,panda,12000)
    ]),
    cliente(paulo,3334,22,advogado,[
        carro(audi,a4,36000)
    ]),
    cliente(pedro,3335,46,advogado,[
        carro(honda,accord,32000),
        carro(audi,a2,20000)
    ])
]).

% 2.1: devolve a lista com o nome de todos os clientes de um stand
listar_clientes(X,LC):-
    stand(X,L),
    findall(C,member(cliente(C,_,_,_,_),L),LC).

% -------------------------------------------------------------------
LC = [rui, rita, joao, ana],
X = vegas
LC = [rui, paulo, pedro],
X = miami
% -------------------------------------------------------------------

% 2.2: devolve os dados de cliente (todos excepto o nome): 
listar_dados(X,C,D):-
    stand(X,L),
    findall((N,ID,P),
    member(cliente(C,N,ID,P,_),L),D).

% -------------------------------------------------------------------
D = [(2324,23,medico), (2325,32,advogado), (2326,26,professor), (2327,49,medico)],
X = vegas
D = [(3333,33,operario), (3334,22,advogado), (3335,46,advogado)],
X = miami
% -------------------------------------------------------------------
 
% 2.3: devolve a lista LM com o nome de todas as marcas de carros vendidos pelo stand X.
listar_carros(X,LM):-
    stand(X,L),
    findall(C,member(cliente(_,_,_,_,C),L),LC),
    flatten(LC,LCC),
    findall(M,member(carro(M,_,_),LCC),LM1),
    list_to_set_(LM1,LM).

% -------------------------------------------------------------------
LM1 = [audi, bmw, audi, audi, bmw, ford],
X = vegas
LM1 = [fiat, audi, honda, audi],
X = miami
% -------------------------------------------------------------------

% 2.4: devolve a lista LA com o nome de todos os advogados de todos os stands;
listar_advogados(LA):-
    findall(L,stand(_,L),LL),
    flatten(LL,LL2),
    findall(C,member(cliente(C,_,_,advogado,_),LL2),LA1),
    list_to_set_(LA1,LA).

% -------------------------------------------------------------------
LA1 = [rita, paulo, pedro]
% -------------------------------------------------------------------

% 2.5: devolve o preço médio (Med) de todos os carros vendidos por um stand. Nota: pode re-utilizar o predicado media(X,L) do exercício anterior;
preco_medio(X,Med):-
    stand(X,L),
    findall(C,member(cliente(_,_,_,_,C),L),LP),
    flatten(LP,LP2),
    findall(P,member(carro(_,_,P),LP2),LP3),
    media(Med,LP3).

% -------------------------------------------------------------------
LP3 = [20000, 30000, 30000, 40000, 32000, 24000],
Med = 29333.33
X = vegas

LP3 = [12000, 36000, 32000, 20000],
Med = 25000
X = miami
% -------------------------------------------------------------------

% 2.6: altera a idade do cliente C do stand X para Id. Nota: deve usar os predicados do Prolog assert e retract.
altera_id(X,C,Id):-
    retract(stand(X,L)),
    altera_id(L,L2,C,Id),
    assert(stand(X,L2)). 

% -------------------------------------------------------------------
C = rui,
X = vegas

C = rita,
X = vegas

C = joao,
X = vegas

C = ana,
X = vegas

C = rui,
X = miami

C = paulo,
X = miami

C = pedro,
X = miami
% -------------------------------------------------------------------

% predicado auxiliar:
altera_id(L,L2,C,NID):- 
    select(cliente(C,N,_,P,V),L,L1),
    append([cliente(C,N,NID,P,V)],L1,L2).

% exemplo de um teste deste programa:
teste:- 
    write('mudar idade da ana\nde:'),
    listar_dados(vegas,ana,D),write(D),
    altera_id(vegas,ana,50),listar_dados(vegas,ana,D1),
    write(' para: '),write(D1).  

% -------------------------------------------------------------------
mudar idade da ana de:[(2327,49,medico)] para: [(2327,50,medico)]
D = [(2327,49,medico)],
D1 = [(2327,50,medico)]
% -------------------------------------------------------------------