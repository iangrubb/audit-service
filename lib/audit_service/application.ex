defmodule AuditService.Application do

  @moduledoc "OTP Application specification for AuditService"

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: AuditService.Endpoint
      )
    ]

    opts = [strategy: :one_for_one, name: AuditService.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
