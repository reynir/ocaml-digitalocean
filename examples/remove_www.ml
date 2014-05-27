module DO = Digitalocean
module Rt = Responses_t
open Record

let () =
  let api = Util.load_api_from_file "../do.json" in
  let name_of_domain domain_id = (DO.get_domain api domain_id).Rt.domain_name in
  let domains = DO.domains api in
  List.iter
    (fun domain ->
      List.iter
	(fun record ->
	  match record_of_responses_record record with
	  | CNAME (domain_id, record_id, r) ->
	    if r.record_CNAME_name = "www"
	    then begin
	      print_endline "Found a 'www' CNAME! KILL IT WITH FIRE!!!";
	      DO.destroy_domain_record api domain_id record_id;
	      print_endline ("www."^name_of_domain domain_id^" no longer exists!")
	    end
	  | _ -> ())
	(DO.get_domain_records api domain.Rt.domain_id))
    domains
