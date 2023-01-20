export interface ILink {
	first?: string | null;
	last?: string | null;
	prev?: string | null;
	next?: string | null;
}

interface IMetaLink {
	url: null | string;
	label: string | null;
	active: boolean | null;
}

export interface IMeta {
	current_page?: number;
	from?: null | string;
	last_page?: number;
	links?: IMetaLink[];
	path?: string | null;
	per_page?: number;
  to?: string | null;
  total?: number;
}