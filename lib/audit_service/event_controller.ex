defmodule AuditService.EventController do

    alias AuditService.Event
    alias AuditService.Repo

    def index() do

    end

    def create(params) do

        result =
            %Event{}
            |> Event.changeset(params)
            |> Repo.insert()
        
        case result do
            {:ok, event} -> {:ok, event}
            {:error, changeset} ->
                errors =
                    changeset.errors
                    |> format_errors()
                {:error, %{errors: errors}}
        end

    end

    defp format_errors(errors), do: Enum.map(errors, fn {key, {mess, _}} -> "#{key} #{mess}" end)


    
end