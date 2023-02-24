import { ILink, IMeta} from "./commons";

export interface IProduct {
  id: number;
  title: string;
	slug: string;
	description: string;
  image: string;
  price: number;
  published: boolean;
  created_at: string;
  updated_at: string;
}

export interface IProductList {
  id: number;
  title: string;
  image: string;
  price: number;
  updated_at: string;
}

export interface ProductProps {
  product: IProduct
}

export type GetProductsResponse = {
  data: IProduct[];
  links: ILink;
  meta: IMeta;
};

export type GetProductResponse = {
  data: IProduct;
  links: ILink;
  meta: IMeta;
};

export type GetProductListResponse = {
  data: IProductList[];
  links: ILink;
  meta: IMeta;
};

export type RootProductState = {
  products: IProduct[];
  links: ILink | null;
  meta: IMeta | null;
  loading: boolean,
  error: null | string
};

export type GetProductsParams = {
  url?: string | null;
  search?: string;
  per_page?: number;
  sort_field?: string;
  sort_direction?: string
};