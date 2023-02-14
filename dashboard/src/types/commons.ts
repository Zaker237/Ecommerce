export interface ILink {
	first: string | null;
	last: string | null;
	prev: string | null;
	next: string | null;
}

export interface IMetaLink {
	url: string | null;
	label: string;
	active: boolean;
}

export interface IMeta {
	current_page: number;
	from: null | string;
	last_page: number;
	links: IMetaLink[];
	path: string | null;
	per_page: number;
	to: string | null;
 	total?: number;
}