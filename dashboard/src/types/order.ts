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

export interface IProduct {
	id: number | null;
  slug: string;
  title: string;
  image: string;
}

export interface IOrderItem {
	id: number | null;
  unit_price: number;
	quantity: number;
	product: IProduct;
}

export interface ICustomer {
	id: number| null; 
  email: string;
  first_name: string;
  last_name: string;
	phone: string;
	shippingAddress: IShippingAddress;
	billingAddress: IBillingAddress;
}

export interface ICustomerList {
	id: number| null;
  first_name: string;
  last_name: string;
}

export interface IOrder {
  id: number | null;
  status: string;
	total_price: number;
	items: IOrderItem[] | null;
  costumer: ICustomer[];
  created_at: string | null;
  updated_at: string | null;
}

export interface IOrderList {
  id: number | null;
  status: string;
	total_price: number;
	number_of_items: number;
	customer: ICustomerList;
  created_at: string | null;
  updated_at: string | null;
}

export interface OrderProps {
  order: IOrder
}

export type GetOrdersResponse = {
  data: IOrder[];
  links: ILink;
  meta: IMeta;
};

export type GetOrderResponse = {
  data: IOrder;
  links: ILink;
  meta: IMeta;
};

export type GetOrderListResponse = {
  data: IOrderList[];
  links: ILink;
  meta: IMeta;
};

export type RootOrderState = {
	orders: IOrder[];
	statuse:string[];
  links: ILink;
  meta: IMeta;
  loading: boolean,
  error: null | string
};

export type GetOrdersParams = {
  url?: string | null;
  search?: string;
  per_page?: number;
  sort_field?: string;
  sort_direction?: string
};