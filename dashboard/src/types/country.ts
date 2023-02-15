import { ILink, IMeta} from "./commons";


export interface ICountry {
  code: string;
  name: string;
  states: string | object;
}

export type GetCountriesResponse = {
  data: ICountry[];
  links: ILink;
  meta: IMeta;
};

export type RootCountryState = {
  countries: ICountry[];
  links: ILink | null;
  meta: IMeta | null;
  loading: boolean,
  error: null | string
};