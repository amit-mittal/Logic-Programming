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
					cycle(Start, Next, NewEdges).
					
%% With the edges given, it checks if cycle
%% is present in the cycle or not
cycle_in_graph([Start/Next | Edges]):-
					(
					cycle(Start, Next, Edges),
					!
					);
					cycle_in_graph(Edges).
					
%% Checks if path exists from X to Y					
path(X, Y, Edges):-
					(
					member(X/Y, Edges);
					member(Y/X, Edges)
					),
					!.
path(X, Y, Edges):-
					(
					member(X/Next, Edges),
					delete(Edges, X/Next, NewEdges),
					path(Next, Y, NewEdges),
					!
					);
					(
					member(Next/X, Edges),
					delete(Edges, Next/X, NewEdges),
					path(Next, Y, NewEdges)
					).
					
