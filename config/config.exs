import Config

config :audit_service, AuditService.Repo,
  database: "audit_service_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :audit_service, ecto_repos: [AuditService.Repo]

config :postgrex, :json_library, Poison
