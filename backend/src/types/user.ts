export interface IUser {
	id?: null | number;
	name?: null  | string;
	email?: null  | string;
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

export type RootUserState = {
  sUser: IUser;
  sIsAdmin?: true | null;
  sToken: string | null;
  loading: boolean,
  error: null | string
};