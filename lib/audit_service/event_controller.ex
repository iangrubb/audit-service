defmodule AuditService.EventController do
  alias AuditService.Event
  alias AuditService.Repo
  import Ecto.Query, only: [from: 2]

  def index(params) do

    # Validate time params formats

    base_query = 
        from e in Event,
        order_by: [asc: :timestamp]

    response =
        base_query
        |> start_query(params["at_or_after"])
        |> end_query(params["before"])
        |> Repo.all()
        |> Enum.map(&render_event/1)
        
    {:ok, response}

  end

  defp start_query(query, start_time) do
    case start_time do
        nil -> query
        _ -> from e in query, where: e.timestamp >= ^start_time
    end
  end

  defp end_query(query, end_time) do
    case end_time do
        nil -> query
        _ -> from e in query, where: e.timestamp < ^end_time
    end
  end

  

  def create(params) do
    result =
      %Event{}
      |> Event.changeset(params)
      |> Repo.insert()

    case result do
      {:ok, event} ->
        {:ok, render_event(event)}

      {:error, changeset} ->
        errors =
          changeset.errors
          |> format_errors()

        {:error, %{errors: errors}}
    end
  end

  defp render_event(event) do
    {meta, event} = Map.pop(event, :"__meta__")
    event
  end

  defp format_errors(errors), do: Enum.map(errors, fn {key, {mess, _}} -> "#{key} #{mess}" end)

end
