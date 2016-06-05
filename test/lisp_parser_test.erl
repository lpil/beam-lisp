-module(lisp_parser_test).
-include_lib("eunit/include/eunit.hrl").

-define(assertAST(Code, AST),
        ?assertEqual(AST, lisp_parser:'string!'(Code))).

literal_test() ->
  ?assertAST("",       []),
  ?assertAST("12345",  [12345]),
  ?assertAST("-5",     [-5]),
  ?assertAST("1.5",    [1.5]),
  ?assertAST("\"Hi\"", ["Hi"]),
  ?assertAST("sup",    [sup]),
  ?assertAST("()",     [[]]).

expression_test() ->
  ?assertAST("(mult 1 2)",    [[mult, 1, 2]]),
  ?assertAST("(+ 1 2 3)",     [['+', 1, 2, 3]]),
  ?assertAST("(+ 3 (- 5 1))", [['+', 3, ['-', 5, 1]]]).

multiple_expression_test() ->
  ?assertAST("(print hi) (id 2)", [[print, hi], [id, 2]]).
