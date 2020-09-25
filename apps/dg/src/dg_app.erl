%%%-------------------------------------------------------------------
%% @doc dg public API
%% @end
%%%-------------------------------------------------------------------

-module(dg_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    dg_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
