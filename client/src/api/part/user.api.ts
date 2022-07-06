import { AxiosInstance, AxiosResponse } from "axios";
import { User } from "@/types/global";

export default class UserApi {
  instance: AxiosInstance;

  constructor(instance: AxiosInstance) {
    this.instance = instance;
  }

  async currentProfil(): Promise<User> {
    return this.instance
      .get("/api/users", {})
      .then((res: AxiosResponse<{ data: User }>) => res.data.data);
  }

  async modifyProfil(
    username: string,
    email: string,
    password?: string
  ): Promise<User> {
    return this.instance
      .put("/api/users", { user: { username, password, email } })
      .then((res: AxiosResponse<{ data: User }>) => res.data.data);
  }

  async deleteProfil(): Promise<unknown> {
    return this.instance
      .delete("/api/users")
      .then((res: AxiosResponse<any>) => res.data);
  }
}

type UserCreate = {
  email: string;
  username: string;
};

type UserModify = UserCreate;

export { UserCreate, UserModify };
