import { ILink, IMeta} from "./commons";

export interface IProduct {
  id: number | null;
  title: string;
	slug: string;
	description: string | null;
  image_url: string | null;
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

export type GetProductResponse = {
  data: IProduct[];
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