open Http_client.Convenience
open Util
module DO = Digitalocean
module Rt = Responses_t
open Record

(* Digitalocean's DNS panel has a huge 'add gmail mx records' button
right next to the 'create' button when adding mx records. It's easy to
click the wrong button by accident. Then you get 5 gmail mx records,
and they're a pain to remove manually ('Are you sure you want to
remove this MX record?'). This short script does it for you. *)

let gmail_records = [
  "ASPMX.L.GOOGLE.COM.";
  "ALT1.ASPMX.L.GOOGLE.COM.";
  "ALT2.ASPMX.L.GOOGLE.COM.";
  "ASPMX2.GOOGLEMAIL.COM.";
  "ASPMX3.GOOGLEMAIL.COM."
]

let () =
  let domain = 
    if Array.length Sys.argv = 2 
    then Sys.argv.(1)
    else failwith "args" in
  let api = load_api_from_file "../do.json" in
  let domain_id =
    (List.find
       (fun x -> x.Rt.domain_name = domain)
       (DO.domains api)).Rt.domain_id
  in try
    DO.get_domain_records api domain_id
    |> List.filter (function
                     | { Rt.record_type = "MX";
                         Rt.record_data } -> 
                        List.mem record_data gmail_records
                     | _ -> false)
    |> List.iter (fun { Rt.record_id } ->
		  DO.destroy_domain_record api domain_id record_id)
  with
    DO.Error e -> failwith ("DO error: " ^ e.Rt.error_message)
