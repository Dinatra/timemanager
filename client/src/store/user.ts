import { User } from "@/types/global";
import { Store } from "./main";

class UserStore extends Store<User> {
  protected data(): User {
    return {
      username: "",
      email: "",
      role: undefined,
    };
  }

  login(user: User, crsfToken: string) {
    const { id, username, email, role } = user;

    this.state.id = id;
    this.state.crsf = crsfToken;
    this.state.username = username;
    this.state.email = email;
    this.state.role = role;
  }

  updateUser(user: User) {
    const { username, email } = user;

    this.state.username = username;
    this.state.email = email;
  }

  logout() {
    this.state.id = "";
    this.state.username = "";
    this.state.email = "";
    this.state.role = undefined;
  }
}

export const userStore: UserStore = new UserStore();
