Definitions.

WS     = [\n\s\r\t]
Int    = [+-]?[0-9]+
Float  = [+-]?[0-9]+\.[0-9]+
String = "([^\\""]|\\.)*"
Atom   = [a-zA-Z_^!+=*\-\?]+


Rules.

{WS}     : skip_token.
[(]      : {token, {'(', TokenChars}}.
[)]      : {token, {')', TokenChars}}.
{Int}    : {token, {int, TokenChars}}.
{Float}  : {token, {float, TokenChars}}.
{String} : {token, {string, strValue(TokenChars)}}.
{Atom}   : {token, {atom, TokenChars}}.


Erlang code.

-export(['string!'/1]).

'string!'(Code) ->
 {ok, Tokens, _} = string(Code),
 Tokens.

strValue(S) when is_list(S) ->
  Contents  = tl(lists:droplast(S)),
  deescape(Contents).

deescape(S) when is_list(S) ->
  deescape(S, []).

deescape([$\\, C|Tail], Acc) ->
  deescape(Tail, [C|Acc]);
deescape([C|Tail], Acc) ->
  deescape(Tail, [C|Acc]);
deescape([], Acc) ->
  lists:reverse(Acc).
