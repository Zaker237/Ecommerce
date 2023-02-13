import { ILink, IMeta} from "./commons";

export interface IUser {
	id?: | number;
	name?: | string;
  email?: | string;
  created_at?: string;
}

export interface IUserLogin {
  email: string | null;
  password: string | null;
  remember?: boolean
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
  sIsAdmin?: true | null;
  sToken: string | null;
  links: ILink;
  meta: IMeta;
  loading: boolean,
  error: null | string
};