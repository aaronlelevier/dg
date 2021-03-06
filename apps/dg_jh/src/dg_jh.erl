%%%-------------------------------------------------------------------
%%% @author Aaron Lelevier
%%% @doc
%%% @end
%%%-------------------------------------------------------------------
-module(dg_jh).
-behaviour(gen_server).

%% API
-export([start_link/0, submit_sync/2, submit_async/2]).

%% gen_server
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2,
  code_change/3]).

%% Macros
-define(SERVER, ?MODULE).

%%%===================================================================
%%% API
%%%===================================================================

start_link() ->
  gen_server:start_link(?MODULE, [], []).

submit_sync(Pid, JobRequest) ->
  gen_server:call(Pid, {job, JobRequest}).

submit_async(Pid, JobRequest) ->
  gen_server:cast(Pid, {job, JobRequest, self()}).

%%%===================================================================
%%% Spawning and gen_server implementation
%%%===================================================================

init([]) ->
  {ok, #{}}.

handle_call({job, JobRequest}, _From, State) ->
  Reply = process(JobRequest),
  {reply, Reply, State}.

handle_cast({job, JobRequest, ClientPid}, State) ->
  process(JobRequest, ClientPid),
  {noreply, State}.

handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================

process({Name, Fun}=_JobRequest) ->
  {Name, {ok, Fun()}}.

process({Name, Fun}=_JobRequest, ClientPid) ->
  ClientPid ! {Name, {ok, Fun()}}.
