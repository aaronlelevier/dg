%%%-------------------------------------------------------------------
%%% @author Aaron Lelevier
%%% @doc
%%%
%%% @end
%%% Created : 25. Sep 2020 6:45 AM
%%%-------------------------------------------------------------------
-module(dg_jh_interface).
-author("Aaron Lelevier").
-vsn(1.0).

%% Types

-type name() :: string().

-type result() :: any().

-type reason() :: string().

-type jh_request() :: {name(), function()}.

-type jh_indication() :: {name(), {ok, result()}} | {name(), {error, reason()}}.

%% Callbacks

-callback submit(pid(), jh_request()) -> ok.

-callback confirm(pid(), jh_indication()) -> ok.
