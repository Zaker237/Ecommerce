export interface IUser {
	id: null | number;
	name: null  | string;
	email: null  | string;
}

export interface IUserLogin {
  email: string | null;
  password: string | null;
  remember?: boolean
}