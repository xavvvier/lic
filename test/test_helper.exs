ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Lic.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Lic.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Lic.Repo)

