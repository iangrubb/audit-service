defmodule AuditService.Event do

    use Ecto.Schema

    schema "event" do
        field :action, :string
        field :initiator, :string
        field :resource, :string
        field :timestamp, :utc_datetime
        field :details, :map
    end

end