-module(lisp_lexer_test).
-include_lib("eunit/include/eunit.hrl").

-define(assertTokens(Code, Tokens),
        ?assertEqual(Tokens, lisp_lexer:'string!'(Code))).

int_test() ->
  ?assertTokens("1",    [{int, "1"}]),
  ?assertTokens("0007", [{int, "0007"}]),
  ?assertTokens("-23",  [{int, "-23"}]).

float_test() ->
  ?assertTokens("1.1",   [{float, "1.1"}]),
  ?assertTokens("29.12", [{float, "29.12"}]),
  ?assertTokens("-1.1",  [{float, "-1.1"}]).

string_test() ->
  ?assertTokens("\"Hi\"",     [{string, "Hi"}]),
  ?assertTokens("\"\"",       [{string, ""}]),
  ?assertTokens("\" \\\\ \"", [{string, " \\ "}]),
  ?assertTokens("\" \\\" \"", [{string, " \" "}]).

atom_test() ->
  ?assertTokens("add",       [{atom, "add"}]),
  ?assertTokens("minus_two", [{atom, "minus_two"}]),
  ?assertTokens("Bang!",     [{atom, "Bang!"}]),
  ?assertTokens("+",         [{atom, "+"}]),
  ?assertTokens("add-one",   [{atom, "add-one"}]).

expression_test() ->
  ?assertTokens("(add 1 (mult 2 3))",
                [{'(',  "("},
                 {atom, "add"},
                 {int,  "1"},
                 {'(',  "("},
                 {atom, "mult"},
                 {int,  "2"},
                 {int,  "3"},
                 {')',  ")"},
                 {')',  ")"}]).
