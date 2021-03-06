%% Generate all possible subsets
find_subset([], []).
find_subset([E | Tail], [E | NTail]):-
					find_subset(Tail, NTail).
find_subset([_ | Tail], NTail):-
					find_subset(Tail, NTail).

%% Checks if there is cycle in graph or not
%% cycle(start, curr, edges)
%% Algo is to check is there is a path from curr to start
%% Base Case is direct edge from curr to start
cycle(Start, Curr, Edges):-
					(
					member(Curr/Start, Edges);
					member(Start/Curr, Edges)
					),
					!.
cycle(Start, Curr, Edges):-
					member(Curr/Next, Edges),
					delete(Edges, Curr/Next, NewEdges),
					cycle(Start, Next, NewEdges),
					!.
cycle(Start, Curr, Edges):-
					member(Next/Curr, Edges),
					delete(Edges, Next/Curr, NewEdges),
					cycle(Start, Next, NewEdges),
					!.
					
%% With the edges given, it checks if cycle
%% is present in the cycle or not
cycle_in_graph([Start/Next | Edges]):-
					(
					cycle(Start, Next, Edges), !
					);
					cycle_in_graph(Edges).
					
%% Checks if path exists from X to Y					
path(X, Y, Edges):-
					member(X/Y, Edges), !.
path(X, Y, Edges):-
					member(Y/X, Edges), !.
path(X, Y, Edges):-
					member(X/Next, Edges),
					delete(Edges, X/Next, NewEdges),
					path(Next, Y, NewEdges), !.
path(X, Y, Edges):-					
					member(Next/X, Edges),
					delete(Edges, Next/X, NewEdges),
					path(Next, Y, NewEdges), !.
					
%% Checks of graph is connected or not
connected([], _).
connected([_], _):- !.
connected([Vertex, OtherVertex | Rest], Edges):-
					path(Vertex, OtherVertex, Edges),
					connected([Vertex | Rest], Edges),
					connected([OtherVertex | Rest], Edges), !.
						
%% Checks if Tree is spanning tree or not of the graph given
%% Brute Force Approach
brute_spanning_tree(V, Edges, Tree):-
					length(V, VSize),
					TSize is VSize - 1,
					length(Tree, TSize),
					find_subset(Edges, Tree),
					connected(V, Tree),
					\+ cycle_in_graph(Tree).
					
%% Algorithmic Approach - Kruskal's Algorithm
%% Assumption is Graph given will be connected
kruskal_spanning_tree(V, [], Tree, Tree):-
					length(V, VSize),
					TSize is VSize - 1,
					length(Tree, TSize),
					\+ cycle_in_graph(Tree).
kruskal_spanning_tree(V, [A | Graph], Tree, FTree):-
					\+ cycle_in_graph([A | Tree]), 
					kruskal_spanning_tree(V, Graph, [A | Tree], FTree).
kruskal_spanning_tree(V, [_ | Graph], Tree, FTree):-
					kruskal_spanning_tree(V, Graph, Tree, FTree).

%% Main predicate which calls kruskal_spanning_tree
%% Checks if graph connected and then finds spanning tree
algo_spanning_tree(V, Edges, Tree):-
					connected(V, Edges),
					kruskal_spanning_tree(V, Edges, [], Tree).