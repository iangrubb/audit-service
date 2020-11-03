defmodule AuditService.Repo do
  use Ecto.Repo,
    otp_app: :audit_service,
    adapter: Ecto.Adapters.Postgres
end
