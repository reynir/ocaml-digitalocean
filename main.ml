module Json = Yojson.Safe
open Http_client.Convenience
open Util
module DO = Digitalocean

let pretty json =
  Json.pretty_to_string json

let () =
  let () = DO.init () in
  let api = load_api_from_file "../do.json" in
  let droplets = DO.droplets_raw api in
  let domains = DO.domains_raw api in
  print_endline (pretty droplets);
  match domains with
  | `Assoc xs ->
    (match List.assoc "domains" xs with
    | `List domains ->
      let domain_ids : int list =
	List.map
	  (function `Assoc xs ->
	    (match List.assoc "id" xs with
	    | `Int id -> id
	    | _ -> failwith "Malformed response")
	  | _ -> failwith "Malformed response")
	  domains
      in
      List.iter (fun j -> print_endline (pretty j))
	(List.map (DO.get_domain_records_raw api) domain_ids)
    | _ -> failwith "Malformed response")
  | _ -> failwith "Malformed response"
