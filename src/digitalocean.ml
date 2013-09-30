module Json = Yojson.Safe
open Http_client.Convenience
open ApiKey_t
module Url = Netencoding.Url
open Responses_j

exception Error of Responses_t.error

let debug = ref false

let request
    (api : api)
    (resource : string)
    (args: (string*string) list)
    : string =
  let url =
    Printf.sprintf
      "https://api.digitalocean.com/%s/?"
      resource
    ^ Url.mk_url_encoded_parameters
      (("client_id", api.id)
       :: ("api_key", api.key)
       :: args) in
  let () = if !debug then print_endline url else () in
  try let reply = http_get url
      in match (generic_response_of_string reply).status with
      | "OK" -> reply
      | "ERROR" -> raise (Error (error_of_string reply))
      | _ -> failwith "Reply was not wellformed!"
  with
  | Http_client.Http_error (401, access_denied) ->
    raise (Error (error_of_string access_denied))
  | Http_client.Http_error (404, not_found) ->
    raise (Error (error_of_string not_found))
  | Http_client.Http_error (ret_code, resp) ->
    raise (Error (error_of_string resp))


let droplets_raw (api : api) =
  request api "droplets" []

let droplets api =
  (droplets_of_string (droplets_raw api)).droplets

let droplet_method api id meth args =
  request
    api
    (Printf.sprintf "droplets/%d/%s" id meth)
    args

let new_droplet_raw api ?(priv=false) name size image region ssh_keys  =
  let other_args =
    [ ("name", name);
      ("size_id", string_of_int size);
      ("image_id", string_of_int image);
      ("region_id", string_of_int region);
      ("private_networking", string_of_bool priv) ]
  in request api "droplets/new"
  (if ssh_keys = []
   then other_args
   else ("ssh_key_ids",
	 String.concat "," (List.map string_of_int ssh_keys))
      :: other_args)
  
let get_droplet_raw api id =
  request api ("droplets/"^string_of_int id) []

let get_droplet api id =
  let resp = get_droplet_raw api id
  in (get_droplet_of_string resp).droplet

let reboot_droplet_raw api id =
  droplet_method api id "reboot" []

let reboot_droplet api id =
  event_of_string (reboot_droplet_raw api id)

let power_cycle_droplet_raw api id =
  droplet_method api id "power_cycle" []
    
let power_cycle_droplet api id =
  event_of_string (power_cycle_droplet_raw api id)

let shutdown_droplet_raw api id =
  droplet_method api id "shutdown" []

let shutdown_droplet api id =
  event_of_string (shutdown_droplet_raw api id)

let power_off_droplet_raw api id =
  droplet_method api id "power_off" []

let power_off_droplet api id =
  event_of_string (power_off_droplet_raw api id)

let power_on_droplet_raw api id =
  droplet_method api id "power_on" []

let power_on_droplet api id =
  event_of_string (power_on_droplet_raw api id)

let reset_password_raw api id =
  droplet_method api id "password_reset" []

let reset_password api id =
  event_of_string (reset_password_raw api id)

let resize_droplet_raw api id size =
  droplet_method api id "resize" [("size_id", string_of_int size)]

let resize_droplet api id size =
  event_of_string (resize_droplet_raw api id size)

let snapshot_droplet_raw api ?(name="") id =
  let args = if name = "" then [] else [("name", name)] in
  droplet_method api id "snapshot" args

let snapshot_droplet api ?(name="") id =
  event_of_string (snapshot_droplet_raw api ~name:name id)

let restore_droplet_raw api id image =
  droplet_method api id "restore" [("image_id", string_of_int image)]

let restore_droplet api id image =
  event_of_string (restore_droplet_raw api id image)

let rebuild_droplet_raw api id image =
  droplet_method api id "rebuild" [("image_id", string_of_int image)]

let rebuild_droplet api id image =
  event_of_string (rebuild_droplet_raw api id image)

let enable_backups_raw api id =
  droplet_method api id "enable_backups" []

let enable_backups api id =
  event_of_string (enable_backups_raw api id)

let disable_backups_raw api id =
  droplet_method api id "disable_backups" []

let disable_backups api id =
  event_of_string (disable_backups_raw api id)

let rename_droplet_raw api id name =
  droplet_method api id "rename" [("name", name)]

let rename_droplet api id name =
  event_of_string (rename_droplet_raw api id name)

let destroy_droplet_raw api ?(scrub=true) id  =
  droplet_method api id "destroy" [("scrub", string_of_bool scrub)]

let destroy_droplet api ?(scrub=true) id =
  event_of_string (destroy_droplet_raw api ~scrub:scrub id)

let regions_raw api =
  request api "regions" []

let regions api =
  (regions_of_string (regions_raw api)).regions

let images_raw ?(filter="") api =
  request api "images"
    (if filter = ""
     then []
     else [("filter", filter)])

let images ?(filter="") api =
  (images_of_string (images_raw ~filter:filter api)).images

let get_image_raw api image =
  request api ("images/"^string_of_int image) []

let get_image api image =
  (get_image_of_string (get_image_raw api image)).get_image

let image_method api image resource args =
  request api (Printf.sprintf "images/%d/%s" image resource) args

let destroy_image_raw api image =
  image_method api image "destroy" []

let destroy_image api image =
  ignore (destroy_image_raw api image)

let transfer_image_raw api image region =
  image_method api image "transfer" [("region_id", string_of_int region)]

let transfer_image api image region =
  ignore (transfer_image_raw api image region)

let ssh_keys_raw api =
  request api "ssh_keys" []

let ssh_keys api =
  (ssh_keys_of_string (ssh_keys_raw api)).ssh_keys

let new_ssh_key_raw api name key =
  request api "ssh_keys/new" [("name", name); ("ssh_pub_key", key)]

let new_ssh_key api name key =
  (get_ssh_key_of_string (new_ssh_key_raw api name key)).ssh_key

let get_ssh_key_raw api key =
  request api ("ssh_keys/" ^ string_of_int key) []

let get_ssh_key api key =
  (get_ssh_key_of_string (get_ssh_key_raw api key)).ssh_key

let ssh_key_method api key resource args =
  request api (Printf.sprintf "ssh_keys/%d/%s" key resource) args

let edit_ssh_key_raw api key new_key =
  ssh_key_method api key "edit" [("ssh_pub_key", new_key)]

let edit_ssh_key api key new_key =
  (get_ssh_key_of_string (edit_ssh_key_raw api key new_key)).ssh_key

(* Documentation says another argument is required:
   > "ssh_pub_key Required, String, the new public SSH key"
   But I think that's an error - why would you supply a key? *)
let destroy_ssh_key_raw api key =
  ssh_key_method api key "destroy" []

let destroy_ssh_key api key =
  ignore (destroy_ssh_key_raw api key)

let sizes_raw api =
  request api "sizes" []

let sizes api =
  (sizes_of_string (sizes_raw api)).sizes

let domains_raw api =
  request api "domains" []

let domains api =
  (domains_of_string (domains_raw api)).domains

let new_domain_raw api name ip =
  request api "domains/new" [("name", name); ("ip_address", ip)]

let new_domain api name ip =
  (new_domain'_of_string (new_domain_raw api name ip)).new_domain

let get_domain_raw api id =
  request api ("domains/" ^ string_of_int id) []

let get_domain api id =
  (get_domain_of_string (get_domain_raw api id)).domain

let domain_method api id resource args =
  request api (Printf.sprintf "domains/%d/%s" id resource) args

let destroy_domain_raw api id =
  domain_method api id "destroy" []

let destroy_domain api id =
  ignore (destroy_domain_raw api id)

let get_domain_records_raw api id =
  domain_method api id "records" []

let get_domain_records api id =
  (records_of_string (get_domain_records_raw api id)).records

let to_record s =
  (get_record_of_string s).record

let new_domain_record_raw api id args =
  domain_method api id "records/new" args

let get_domain_record_raw api domain record =
  domain_method api domain ("records/"^string_of_int record) []

let get_domain_record api domain record =
  to_record (get_domain_record_raw api domain record)

let destroy_domain_record_raw api domain record =
  domain_method api domain ("records/"^string_of_int record^"/destroy") []

let destroy_domain_record api domain record =
  ignore (destroy_domain_record_raw api domain record)

let new_CNAME_raw api id name hostname =
  new_domain_record_raw api id [("record_type", "CNAME");
			    ("name", name);
			    ("data", hostname)]

let new_CNAME api id name hostname =
  to_record (new_CNAME_raw api id name hostname)

let new_A_raw api id name ip =
  new_domain_record_raw api id [("record_type", "A");
			    ("name", name);
			    ("data", ip)]

let new_A api id name ip =
  to_record (new_A_raw api id name ip)

let new_MX_raw api id priority hostname =
  new_domain_record_raw api id [("record_type", "MX");
			    ("priority", string_of_int priority);
			    ("data", hostname)]

let new_MX api id priority hostname =
  to_record (new_MX_raw api id priority hostname)

let new_TXT_raw api id name data =
  new_domain_record_raw api id [("record_type", "TXT");
			    ("name", name);
			    ("data", data)]

let new_TXT api id name data =
  to_record (new_TXT_raw api id name data)

let new_NS_raw api id ns =
  new_domain_record_raw api id [("record_type", "NS"); ("data", ns)]

let new_NS api id ns =
  to_record (new_NS_raw api id ns)

let new_SRV_raw api id name hostname priority port weight =
  new_domain_record_raw api id [("record_type", "SRV");
			    ("name", name);
			    ("data", hostname);
			    ("priority", string_of_int priority);
			    ("port", string_of_int port);
			    ("weight", string_of_int weight)]

let new_SRV api id name hostname priority port weight =
  to_record (new_SRV_raw api id name hostname priority port weight)

let init () =
  Ssl.init();
    Http_client.Convenience.configure_pipeline
      (fun p ->
	let ctx = Ssl.create_context Ssl.TLSv1 Ssl.Client_context in
	let tct = Https_client.https_transport_channel_type ctx in
	p # configure_transport Http_client.https_cb_id tct
      )

let () = init ()
