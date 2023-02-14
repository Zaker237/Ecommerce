import { ILink, IMeta} from "./commons";

export interface IShippingAddress {
	id: number;
	address1: string;
	address2: string;
	city: string;
	state: string;
	zipcode: number;
	country_code: string;
}

export interface IBillingAddress {
	id: number;
	address1: string;
	address2: string;
	city: string;
	state: string;
	zipcode: number;
	country_code: string;
}

export interface ICustomer {
	id: number;
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
  links: ILink | null;
  meta: IMeta | null;
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