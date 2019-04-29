defmodule Absinthe.Phase.Telemetry do
  @moduledoc """
  Gather and report telemetry about an operation.
  """
  @telemetry_event [:absinthe, :execute, :operation]

  use Absinthe.Phase

  def run(blueprint, options) do
    with %{start_time: start_time, start_time_mono: start_time_mono} <- blueprint.telemetry do
      :telemetry.execute(
        @telemetry_event,
        %{
          duration: System.monotonic_time() - start_time_mono
        },
        %{
          start_time: start_time,
          blueprint: blueprint,
          options: options
        }
      )
    end

    {:ok, blueprint}
  end
end
