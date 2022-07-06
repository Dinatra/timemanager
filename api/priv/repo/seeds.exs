# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Timemachine.Repo.insert!(%Timemachine.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# DELETE from clocks;
# DELETE from workingtimes;
# DELETE from users;

# ALTER SEQUENCE users_id_seq RESTART WITH 1;

alias Timemachine.UserManager.User
alias Timemachine.ClockManager.Clock
alias Timemachine.WorkingtimeManager.Workingtime
alias Timemachine.TeamManager.Team
alias Timemachine.TeamManager.UserTeam
alias Timemachine.Repo

# init date
{:ok, utc_date} = DateTime.now("Etc/UTC")
utc_date = DateTime.truncate(utc_date, :second)
nav_date = NaiveDateTime.local_now()
password = Bcrypt.hash_pwd_salt("totopass!!")

# Create Users
Repo.insert!(%User{
  id: 4242,
  username: "marc",
  email: "marc@gmail.com",
  role: :manager,
  password: password,
  inserted_at: nav_date,
  updated_at: nav_date
})

Repo.insert!(%User{
  id: 8080,
  username: "louis",
  email: "louis@gmail.com",
  password: password,
  inserted_at: nav_date,
  updated_at: nav_date
})

Repo.insert!(%User{
  id: 5050,
  username: "deleteme",
  email: "deleteme@gmail.com",
  password: password,
  inserted_at: nav_date,
  updated_at: nav_date
})

# Create Team
Repo.insert!(%Team{
  id: 1,
  name: "devgroup",
  inserted_at: nav_date,
  updated_at: nav_date
})

# Create UserTeam
Repo.insert!(%UserTeam{
  user_id: 4242,
  team_id: 1,
  is_owner: true,
  inserted_at: nav_date,
  updated_at: nav_date
})

# Create Clocks
Repo.insert!(%Clock{
  time: utc_date,
  status: false,
  user_id: 4242,
  inserted_at: nav_date,
  updated_at: nav_date
})

Repo.insert!(%Clock{
  time: utc_date,
  status: false,
  user_id: 4242,
  inserted_at: nav_date,
  updated_at: nav_date
})

# Create Workingtimes
Repo.insert!(%Workingtime{
  id: 4242,
  start: utc_date,
  end: utc_date,
  pause: 0,
  user_id: 8080,
  inserted_at: nav_date,
  updated_at: nav_date
})

Repo.insert!(%Workingtime{
  id: 9090,
  start: utc_date,
  end: utc_date,
  user_id: 8080,
  pause: 0,
  inserted_at: nav_date,
  updated_at: nav_date
})

Repo.insert!(%Workingtime{
  id: 4444,
  start: utc_date,
  end: utc_date,
  user_id: 8080,
  pause: 0,
  inserted_at: nav_date,
  updated_at: nav_date
})
