import { ICustomer } from "./customer";

export interface IDateOptions {
	key: string;
	text: number;
}

export interface IOrder{
	id: number;
  total_price: number;
  created_at: string;
  items: any[];
  user_id: number;
  first_name: string;
  last_name: string;
}

export interface IOrdersByCountry {

}

export interface ILatestCustomer {

}

export interface ILatestOrders {

}

export type RootDashboardState = {
	customernumber: number;
	productnumber: number;
	paidOrdernumber: number;
	totalIncomenumber: number;
	orders: IOrder[];
	countryOrders: IOrder[];
	customers: ICustomer[];
	customersCountLoading: boolean;
  productsCountLoading: boolean;
  paidOrdersLoading: boolean;
  totalIncomeLoading: boolean;
  ordersByCountryLoading: boolean;
  latestCustomersLoading: boolean;
	latestOrdersLoading: boolean;
	error: null | string;
};