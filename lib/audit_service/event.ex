defmodule AuditService.Event do

    use Ecto.Schema
    import Ecto.Changeset

    @timestamps_opts [type: :utc_datetime]

    schema "event" do
        field :action, :string
        field :initiator, :string
        field :resource, :string
        field :timestamp, :utc_datetime, read_after_writes: true
        field :details, :map, default: %{}
    end

    def changeset(event, params \\ %{}) do
        event
        |> cast(params, [:action, :initiator, :resource, :timestamp, :details])
        |> validate_required([:action, :initiator])
        |> validate_change(:details, fn :details, details ->
            error? =
                details
                |> Map.keys()
                |> Enum.any?(fn key ->
                    key == "resource" || key == "initiator"
                end)

            case error? do
                true -> [details: "can't use key 'resource' or 'initiator'"]
                false -> []
            end
        end)
    end

end