import { ILink, IMeta} from "./commons";


export interface ICountry {
  code: number | null;
  name: string;
  states: null | object;
}

export type GetCountriesResponse = {
  data: ICountry[];
  links: ILink;
  meta: IMeta;
};

export type RootCountryState = {
  countries: ICountry[];
  links: ILink;
  meta: IMeta;
  loading: boolean,
  error: null | string
};