defmodule TimemachineWeb.Router do
  use TimemachineWeb, :router

  alias TimemachineWeb.Plug
  alias TimemachineWeb.Auth

  pipeline :api, do: plug :accepts, ["json"]

  pipeline :complete_auth do
    plug Auth.Pipeline                                # Guardian - Try load jwt
    plug Guardian.Plug.EnsureAuthenticated            # User is logged
    plug Plug.ValidCsrf                               # Valid csrf header
    plug Plug.NoRevokeToken                           # Revoked token ?
  end

  pipeline :is_super_manager, do: plug Plug.CheckRights, roles: ["super_manager"]
  pipeline :is_administration, do: plug Plug.CheckRights, roles: ["manager", "super_manager"]

  scope "/api", TimemachineWeb do
    pipe_through :api

    ##
    # Anonymous
    ##
    post "/users/sign_in", AuthController, :login       # Login
    post "/users/sign_up", UserController, :create      # Register

    ##
    # Authenticated
    ##
    pipe_through [:complete_auth]

    get "/users", UserController, :show_me              # View their account information
    put "/users", UserController, :update_me            # Edit their account information
    delete "/users", UserController, :delete_me         # Delete their account.

    get "/clocks", ClockController, :current_clock_me   # Get current clock
    post "/clocks", ClockController, :add_clock_me      # Report their departure and arrival times

    get "/teams/", TeamController, :current_teams_me              # Get their team(s)
    post "/teams/:teamID/leave", TeamController, :leave_team_me   # leave team

    get "/tasks/team/:teamID", TaskController, :task_of_team      # Get task of their team
    get "/workingtimes", WorkingtimeController, :search_me        # View their dashboards.
    post "/workingtimes", WorkingtimeController, :post_time       # Report time
    post "/users/sign_out", AuthController, :logout      # Logout

    ##
    # Management team
    ##
    pipe_through [:is_administration]

    post "/teams", TeamController, :create    # Create - Manage their team(s)
    delete "/teams/:teamID", TeamController, :delete  # Delete - Manage their team(s)
    post "/teams/:teamID/user/:userID", TeamController, :add_remove_user    # Add/Exclude user - Manage their team(s)
    get "/teams/:teamID/users", TeamController, :get_team_member            # Get team member

    post "/tasks/team/:teamID", TaskController, :create_task_of_team               # Create - Manage their team(s)
    delete "/tasks/team/:teamID/:taskID", TaskController, :delete_task_of_team     # Delete - Manage their team(s)

    get "/workingtimes/team/:teamID", WorkingtimeController, :get_all_workingtime_of_team # View their dashboards && View the averages of the daily and weekly hours of the team over a given period.
    get "/workingtimes/team/:teamID/users/:userID", WorkingtimeController, :get_all_workingtime_of_team_specif_user    # View the daily and weekly working hours of an employee over a period of time.

    ##
    # Super manager
    ##
    pipe_through [:is_super_manager]

    # put "/users/permission/:userID", UserController, :nil     # Change permission user
    # get "/workingtimes/:userID", UserController, :nil         # View the dashboards of all users.
    # delete "/users/:userID", UserController, :nil             # Delete accounts from all users.
  end
end
