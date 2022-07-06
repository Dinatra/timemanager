export interface WorkingTime {
  id?: string;
  name: string;
  start: string;
  end: string;
  pause: number;
  // employee: string;
  comment?: string;
}

export interface User extends Record<string, unknown> {
  id?: string;
  crsf?: string;
  username: string;
  email: string;
  role?: Role;
  teams?: Team[];
}

export interface Task extends Record<string, unknown> {
  id?: string;
  name: string;
  complete: boolean;
}

export interface Team extends Record<string, unknown> {
  id?: string;
  name: string;
}

type Role = "manager" | "superManager" | "employee" | undefined;
type WorkingTimes = WorkingTime[];
