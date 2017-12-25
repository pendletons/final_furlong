defmodule LegacyWeb.Controller do
  @moduledoc """
  Macros to tidy controller logic.
  """
  defmacro __using__(_) do
    quote do
      def action(conn, _), do: LegacyWeb.Controller.__action__(__MODULE__, conn)
      defoverridable action: 2
    end
  end

  @doc """
  Add current_user (or :guest) to arguments list for controller functions.
  e.g. index(conn, params, current_user)
  """
  def __action__(controller, conn) do
    args = [conn, conn.params, conn.assigns[:current_user] || :guest]
    apply(controller, Phoenix.Controller.action_name(conn), args)
  end
end
