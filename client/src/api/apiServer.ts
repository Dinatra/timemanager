import UserApi from "./part/user.api";
import AuthApi from "./part/auth.api";
import { userStore } from "@/store/user";
import axios, { AxiosInstance } from "axios";
import dotenv from "dotenv";
import TeamApi from "./part/team.api";
import WorkingtimeApi from "./part/workingtime.api";
dotenv.config();

export default class ApiServer {
  private _serverInstance: AxiosInstance;

  public users: UserApi;
  public teams: TeamApi;
  public auth: AuthApi;
  public workingTime: WorkingtimeApi;

  constructor(url: string) {
    this._serverInstance = axios.create({
      baseURL: url,
      withCredentials: true,
    });

    this._serverInstance.interceptors.request.use(
      (config: any) => this.authHeaderInterceptor(config),
      (error: any) => Promise.reject(error)
    );

    this.users = new UserApi(this._serverInstance);
    this.teams = new TeamApi(this._serverInstance);
    this.auth = new AuthApi(this._serverInstance);
    this.workingTime = new WorkingtimeApi(this._serverInstance);
  }

  private authHeaderInterceptor(config: any) {
    const token = userStore.getState().crsf;
    if (token) config.headers["xcsrf"] = token;

    return config;
  }
}

const url =
  process.env.NODE_ENV === "development"
    ? "http://localhost:4000"
    : process.env.VUE_APP_API_URL || "/";
const apiServer = new ApiServer(url);
export { apiServer };
