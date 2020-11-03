defmodule AuditService.Event do

    use Ecto.Schema
    import Ecto.Changeset

    schema "event" do
        field :action, :string
        field :initiator, :string
        field :resource, :string
        field :timestamp, :utc_datetime
        field :details, :map, default: %{}
    end

    def changeset(event, params \\ %{}) do
        event
        |> cast(params, [:action, :initiator, :resource, :timestamp, :details])
        |> validate_required([:action, :initiator])
        |> validate_change(:details, fn :details, details ->
            details
            |> Map.keys()
            |> Enum.filter(fn key ->
                key == "resource" || key == "initiator"
            end)
            |> Enum.map(fn key -> 
                [details: "#{key} is not a valid key"]
            end)
        end)
    end

end