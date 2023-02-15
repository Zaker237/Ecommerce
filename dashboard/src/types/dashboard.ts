import { ICustomer } from "./customer";

export interface IDateOptions {
	key: string;
	text: number;
}

export interface IChartItem {
	name: string;
	count: number;
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

export interface IChartDataItem {
	label?: string;
  backgroundColor?: string | string[];
	data: number[];
}

export interface IChartData {
	labels: string[];
	datasets: IChartDataItem[];
}

export type RootDashboardState = {
	customerNumber: number;
	productNumber: number;
	paidOrderNumber: number;
	totalIncomeNumber: number;
	orders: IOrder[];
	countryOrders: IChartItem[];
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