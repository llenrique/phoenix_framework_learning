defmodule BlogWeb.HelloController do
  use BlogWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end

  def show(conn, %{"someone" => someone} = params) do
    render(conn, :show, someone: someone)
  end
end
