module Json = Yojson.Safe
open Http_client.Convenience
open Util
module DO = Digitalocean
module Rt = Responses_t
open Record

let pretty json =
  Json.pretty_to_string json

let () =
  let api = load_api_from_file "../do.json" in
  let name_of_domain domain_id = (DO.get_domain api domain_id).Rt.domain_name in
  DO.domains api 
  |> List.map (fun x -> x.Rt.domain_id)
  |> List.map (DO.get_domain_records api)
  |> List.iter
       (fun domain_records ->
        let domain_id = (List.hd domain_records).Rt.record_domain_id in
        if not (List.exists
                  (fun r -> match record_of_responses_record r with
                            | CNAME (_, _, r) -> r.record_CNAME_name = "www"
                            | A (_, _, r) -> r.record_A_name = "www"
                            | _ -> false)
                  domain_records)
        then (print_endline ("Adding 'www' CNAME to " ^ name_of_domain domain_id);
              ignore (DO.new_CNAME api domain_id "www" "@"))
        else print_endline (name_of_domain domain_id
                            ^ " already has a 'www' record"))
