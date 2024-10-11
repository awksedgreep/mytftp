defmodule Mytftp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Mytftp.Worker.start_link(arg)
      # {Mytftp.Worker, arg}
      {Trivial, {Mytftp, nil, port: 6699}}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mytftp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
