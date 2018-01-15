% Isaac Griffith
% CSCI 305 Prolog Lab

consult('royal.pl').

% M is the mother of C
mother(M, C):- parent(M, C), female(M).

% F is the father of C
father(F, C):- parent(F, C), male(F).

% X is the spouse of Y and Y is the spouse of X, must be reflexive
spouse(X, Y):- married(X, Y); married(Y, X).

% C is a child of P if and only if P is a parent of C and C is not equal to P
child(C, P):- parent(P, C), C\=P.

% S is the son of P if and only if S is a child of P and S is male
son(S, P):- child(S, P), male(S).

% D is the daughter of P if and only if D is a child of P and D is female
daughter(D, P):- child(D, P), female(D).

% X is a sibling of Y if X and Y share a parent in common and X is not equal to Y
sibling(X, Y):- parent(P, X), parent(P, Y), X \= Y.

% B is the brother of X if and only if B and X are siblings and B is male
brother(B, X):- sibling(B, X), male(B).

% S is the sister of X if and only if S and X are siblings and S is female
sister(S, X):- sibling(S, X), female(S).

% X is the uncle of Y
% blood case
uncle(X, Y):- child(X, P), brother(Y, P).
% marriage case, X is a child of P and Z is the sibling of P, and Y is the spouse of Z and Y is male
uncle(X, Y):- child(X, P), sibling(Z, P), spouse(Y, Z), male(Y).

% X is the aunt of Y
% blood case, X is the child of P and Y is the sister of P
aunt(X, Y):- child(Y, P), sister(X, P).
% marriage case, X is the child of P and Z is the sibling of P and Y is the spouse of Z and Y is female
aunt(X, Y):- child(Y, P), sibling(Z, P), spouse(X, Z), female(X).

% G is the grandparent of C, where C is the child of P and P is the child of G
grandparent(G, C):- child(C, P), child(P, G).

% G is the grandfather of C, where G is a grandparent of C and G is male
grandfather(G, C):- grandparent(G, C), male(G).

% G is the grandmother of C, where G is a grandparent of C and G is female
grandmother(G, C):- grandparent(G, C), female(G).

% C is the grandchild of G, where G is the grandparent of C
grandchild(C, G):- grandparent(G, C).

% X is an ancestor of Y
% base case, X is a parent of Y
ancestor(X, Y):- parent(X, Y).
% recursive case, X is the parent of Z, and Z is an ancestor of Y
ancestor(X, Y):- parent(X, Z), ancestor(Z, Y).

% X is a descendant of Y
% base case, X is a child of Y
descendant(X, Y):- child(X, Y).
% recursive case, X is a child of Z and Z is a descendant of Y
descendant(X, Y):- child(X, Z), descendant(Z, Y).

% X is older than Y, if and only if X was born before Y
older(X, Y):- born(X, A), born(Y, B), died(X, C), died(Y, D), (C - A) < (D - B).

% X is younger than Y, if and only if X was born after Y
younger(X, Y):- born(X, A), born(Y, B), A > B.

% X was regent when Y was born, if and only if Y was born during the period X reigned
regentWhenBorn(X, Y):- born(Y, B), reigned(X, A, C), A =< B, B =< C .

% X is a cousin of Y, if P is the parent of Y and Z is a sibling of P and X is a child of Z
cousin(X, Y):- parent(P, Y), sibling(P, Z), child(X, Z).
