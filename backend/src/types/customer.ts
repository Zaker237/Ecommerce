import { ILink, IMeta} from "./commons";

export interface IShippingAddress {
	id: number | null;
	address1: string;
	address2: string;
	city: string;
	state: string;
	zipcode: number;
	country: string;
}

export interface IBillingAddress {
	id: number | null;
	address1: string;
	address2: string;
	city: string;
	state: string;
	zipcode: number;
	country: string;
}

export interface ICustomer {
	id: number | null;
	first_name: string;
  last_name: string;
  email: string;
  phone: string;
  status: string;
  created_at: string | null;
	updated_at: string | null;
	shippingAddress: IShippingAddress;
	billingAddress: IBillingAddress;
}

export interface ICustomerList {
  id: number | null;
	first_name: string;
  last_name: string;
  email: string;
  phone: string;
  status: string;
  created_at: string | null;
	updated_at: string | null;
}

export interface CustomerProps {
  customer: ICustomer
}

export type GetCustomersResponse = {
  data: ICustomer[];
  links: ILink;
  meta: IMeta;
};

export type GetCustomerResponse = {
  data: ICustomer;
  links: ILink;
  meta: IMeta;
};

export type GetCustomerListResponse = {
  data: ICustomerList[];
  links: ILink;
  meta: IMeta;
};

export type RootCustomerState = {
	customers: ICustomer[];
	statuse:string[];
  links: ILink;
  meta: IMeta;
  loading: boolean,
  error: null | string
};

export type GetCustomersParams = {
  url?: string | null;
  search?: string;
  per_page?: number;
  sort_field?: string;
  sort_direction?: string
};