defmodule AuditService.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:event) do
      add :action, :string, null: false
      add :initiator, :string, null: false
      add :resource, :string
      add :timestamp, :utc_datetime, default: fragment("now()")
      add :details, :map
    end
  end
end
