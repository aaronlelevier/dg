%%%-------------------------------------------------------------------
%% @doc dg_jh public API
%% @end
%%%-------------------------------------------------------------------

-module(dg_jh_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    dg_jh_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
