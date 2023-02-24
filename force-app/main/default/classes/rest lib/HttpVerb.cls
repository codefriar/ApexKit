/**
 * @description This ENUM lists possible HTTP Verbs. Note: 'Delete' is an Apex Keyword (DML)
 * and as a result, the ENUM value 'DEL' is used for delete.
 */
public enum HttpVerb {
	GET,
	POST,
	PATCH,
	PUT,
	HEAD,
	DEL
}