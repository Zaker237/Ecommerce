import { ICustomer } from "./customer";
import { IOrder } from "./order";

export interface IDateOptions {
	key: String;
	text: Number;
}

export interface IOrdersByCountry {

}

export interface ILatestCustomer {

}

export interface ILatestOrders {

}

export type RootDashboardState = {
	orders: IOrder[];
	customers: ICustomer[];
	customersCountLoading: Boolean;
  productsCountLoading: Boolean;
  paidOrdersLoading: Boolean;
  totalIncomeLoading: Boolean;
  ordersByCountryLoading: Boolean;
  latestCustomers: Boolean,
  latestOrdersLoading: Boolean;
};