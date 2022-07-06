import { User } from "@/types/global";
import { AxiosInstance, AxiosResponse } from "axios";

export default class AuthApi {
  instance: AxiosInstance;

  constructor(instance: AxiosInstance) {
    this.instance = instance;
  }

  async login(username: string, password: string): Promise<LoginAnswer> {
    return this.instance
      .post("/api/users/sign_in", {
        user: { username, password },
      })
      .then((res: AxiosResponse<LoginAnswer>) => res.data);
  }

  async register(
    username: string,
    password: string,
    email: string
  ): Promise<RegisterAnswer> {
    return this.instance
      .post("/api/users/sign_up", {
        user: {
          username,
          password,
          email,
        },
      })
      .then((res: AxiosResponse<{ data: RegisterAnswer }>) => res.data.data);
  }
}

type RegisterAnswer = {
  email: string;
  id: number;
  username: string;
};

type LoginAnswer = {
  csrf_token: string;
  user: User;
};
