import { ILink, IMeta} from "./commons";

export interface IProduct {
  id: number | null;
  title: string;
	slug: string;
	description: string | null;
  image_url?: string;
  price: number;
  created_at: string | null;
  updated_at: string | null;
}

export interface IProductList {
  id: number | null;
  title: string;
  price: number;
  updated_at: string | null;
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
  links: ILink;
  meta: IMeta;
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