defmodule AuditService.Endpoint do

    @moduledoc """
    A Plug for handling requests, routing, and dispatching responses.
    """

    use Plug.Router

    # Logs request info
    plug(Plug.Logger)

    # Matches routes
    plug(:match)

    # Uses Poison to decode JSON in requests
    plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)

    # Dispatches responses
    plug(:dispatch)

    # Routes

    get "/events" do
        send_resp(conn,  200, "Beef")
    end

    # post "/events" do

    # end

    match _ do
        send_resp(conn, 404, "No Route Found")
    end


end