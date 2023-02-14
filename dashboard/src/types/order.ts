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

export interface IProduct {
	id: number;
  slug: string;
  title: string;
  image: string;
}

export interface IOrderItem {
	id: number;
  unit_price: number;
	quantity: number;
	product: IProduct;
}

export interface ICustomer {
	id: number; 
  email: string;
  first_name: string;
  last_name: string;
	phone: string;
	shippingAddress: IShippingAddress;
	billingAddress: IBillingAddress;
}

export interface ICustomerList {
	id: number;
  first_name: string;
  last_name: string;
}

export interface IOrder {
  id: number;
  status: string;
	total_price: number;
	items: IOrderItem[];
  customer: ICustomer;
  created_at: string;
  updated_at: string;
}

export interface IOrderList {
  id: number;
  status: string;
	total_price: number;
	number_of_items: number;
	customer: ICustomerList;
  created_at: string;
  updated_at: string;
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
	statuse: string[];
  links: ILink | null;
  meta: IMeta | null;
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