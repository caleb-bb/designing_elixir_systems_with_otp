defmodule DesigningElixirSystemsWithOtp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DesigningElixirSystemsWithOtpWeb.Telemetry,
      DesigningElixirSystemsWithOtp.Repo,
      {DNSCluster, query: Application.get_env(:designing_elixir_systems_with_otp, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DesigningElixirSystemsWithOtp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: DesigningElixirSystemsWithOtp.Finch},
      # Start a worker by calling: DesigningElixirSystemsWithOtp.Worker.start_link(arg)
      # {DesigningElixirSystemsWithOtp.Worker, arg},
      # Start to serve requests, typically the last entry
      DesigningElixirSystemsWithOtpWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DesigningElixirSystemsWithOtp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DesigningElixirSystemsWithOtpWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
