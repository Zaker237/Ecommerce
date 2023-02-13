import { ICustomer } from "./customer";

export interface IDateOptions {
	key: String;
	text: Number;
}

export interface IOrder{
	id: Number;
  total_price: Number;
  created_at: String;
  items: any[];
  user_id: Number;
  first_name: String;
  last_name: String;
}

export interface IOrdersByCountry {

}

export interface ILatestCustomer {

}

export interface ILatestOrders {

}

export type RootDashboardState = {
	customerNumber: Number;
	productNumber: Number;
	paidOrderNumber: Number;
	totalIncomeNumber: Number;
	orders: IOrder[];
	countryOrders: IOrder[];
	customers: ICustomer[];
	customersCountLoading: Boolean;
  productsCountLoading: Boolean;
  paidOrdersLoading: Boolean;
  totalIncomeLoading: Boolean;
  ordersByCountryLoading: Boolean;
  latestCustomersLoading: Boolean;
	latestOrdersLoading: Boolean;
	error: null | string;
};