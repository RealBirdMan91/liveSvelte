defmodule MyLiveView.Repo do
  use Ecto.Repo,
    otp_app: :my_live_view,
    adapter: Ecto.Adapters.Postgres
end
