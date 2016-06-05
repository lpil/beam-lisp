Nonterminals expression expressions literal element elements sexp document.

Terminals int float string atom '(' ')'.

Rootsymbol document.

document -> '$empty'    : [].
document -> expressions : '$1'.

expressions -> expression             : ['$1'].
expressions -> expression expressions : ['$1'|'$2'].

expression -> literal  : '$1'.
expression -> sexp     : '$1'.

sexp -> '('          ')' : [].
sexp -> '(' elements ')' : '$2'.

elements -> element          : ['$1'].
elements -> element elements : ['$1'|'$2'].

element -> sexp    : '$1'.
element -> literal : '$1'.

literal -> atom   : atm('$1').
literal -> int    : int('$1').
literal -> float  : flt('$1').
literal -> string : val('$1').

Erlang code.

-export(['string!'/1]).

'string!'(Code) ->
  {ok, AST} = parse(lisp_lexer:'string!'(Code)),
  AST.

val({_, V}) -> V.
int(T) -> element(1, string:to_integer(val(T))).
flt(T) -> element(1, string:to_float(val(T))).
atm(T) -> list_to_atom(val(T)).
