defmodule Lic.Auth do
  import Plug.Conn
  import Phoenix.Controller
  alias Lic.Router.Helpers

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, _repo) do
    user_id = get_session(conn, :user_id)
    user = user_id && get_by_id(user_id)
    assign(conn, :current_user, user)
  end

  def authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged to access that page")
      |> redirect(to: Helpers.page_path(conn, :index))
      |> halt()
    end
  end

  def login(conn, user, pass) do
    user = get_user(user, pass)
    if user do
        conn
        |> assign(:current_user, user)
        |> put_session(:user_id, user)
        |> configure_session(renew: true)
        IO.inspect conn.assigns
        {:ok, conn}
    else
        {:error, :unauthorized, conn}
    end
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end

  defp get_user(user, pass) do
    valid_user = [
      Application.get_env(:lic, Lic.Auth)[:user],
      Application.get_env(:lic, Lic.Auth)[:pass]
    ]
    case valid_user  do
      [^user, ^pass] ->
        %{user: user}
      _ ->
        nil
    end
  end

  defp get_by_id(user_id) do
    valid_user = Application.get_env(:lic, Lic.Auth)[:user]
    case user_id do
      valid_user ->
        %{user: user_id}
      true ->
        nil
    end
  end

end
