import { ILink, IMeta} from "./commons";

export interface IUser {
	id: number;
	name: string;
  email: string;
  created_at: string;
}

export interface IUserLogin {
  email: string;
  password: string;
  remember: boolean
}

export interface ILoginResponse {
  user: IUser,
  token: string
}

export type GetUserResponse = {
  data: IUser;
  links: ILink;
  meta: IMeta;
};

export type GetUsersResponse = {
  data: IUser[];
  links: ILink;
  meta: IMeta;
};

export type GetUsersParams = {
  url?: string | null;
  search?: string;
  per_page?: number;
  sort_field?: string;
  sort_direction?: string
};

export type RootUserState = {
  users: IUser[];
  currentUser: IUser;
  sIsAdmin?: boolean;
  sToken: string;
  links: ILink | null;
  meta: IMeta | null;
  loading: boolean,
  error: null | string
};