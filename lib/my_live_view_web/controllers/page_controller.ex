defmodule MyLiveViewWeb.PageController do
  use MyLiveViewWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def svelte_1(conn, _params), do: render(conn, :svelte_1, layout: false)
end
