module Json = Yojson.Safe
open Http_client.Convenience
open ApiKey_t
module Url = Netencoding.Url
open Responses_j

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
  let reply = http_get url in
  match (generic_response_of_string reply).status with
  | "OK" -> reply
  | _ -> failwith "Reply was not wellformed!"

let droplets_raw (api : api) =
  request api "droplets" []

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
  in get_droplet_of_string resp

let reboot_droplet_raw api id =
  droplet_method api id "reboot" []

let power_cycle_droplet_raw api id =
  droplet_method api id "power_cycle" []

let shutdown_droplet_raw api id =
  droplet_method api id "shutdown" []

let power_off_droplet_raw api id =
  droplet_method api id "power_off" []

let power_on_droplet_raw api id =
  droplet_method api id "power_on" []

let reset_password_raw api id =
  droplet_method api id "password_reset" []

let resize_droplet_raw api id size =
  droplet_method api id "resize" [("size_id", string_of_int size)]

let snapshot_droplet_raw api ?(name="") id =
  let args = if name = "" then [] else [("name", name)] in
  droplet_method api id "snapshot" args

let restore_droplet_raw api id image =
  droplet_method api id "restore" [("image_id", string_of_int image)]

let rebuild_droplet_raw api id image =
  droplet_method api id "rebuild" [("image_id", string_of_int image)]

let enable_backups_raw api id =
  droplet_method api id "enable_backups" []

let disable_backups_raw api id =
  droplet_method api id "disable_backups" []

let rename_droplet_raw api id name =
  droplet_method api id "rename" [("name", name)]

let destroy_droplet_raw api ?(scrub=true) id  =
  droplet_method api id "destroy" [("scrub", string_of_bool scrub)]

let regions_raw api =
  request api "regions" []

let images_raw ?(filter="") api =
  request api "images"
    (if filter = ""
     then []
     else [("filter", filter)])

let get_image_raw api image =
  request api ("images/"^string_of_int image) []

let image_method api image resource args =
  request api (Printf.sprintf "images/%d/%s" image resource) args

let destroy_image_raw api image =
  image_method api image "destroy" []

let transfer_image_raw api image region =
  image_method api image "transfer" [("region_id", string_of_int region)]

let ssh_keys_raw api =
  request api "ssh_keys" []

let new_ssh_key_raw api name key =
  request api "ssh_keys/new" [("name", name); ("ssh_pub_key", key)]

let get_ssh_key_raw api key =
  request api ("ssh_keys/" ^ string_of_int key) []

let ssh_key_method api key resource args =
  request api (Printf.sprintf "ssh_keys/%d/%s" key resource) args

let edit_ssh_key_raw api key new_key =
  ssh_key_method api key "edit" [("ssh_pub_key", new_key)]

(* Documentation says another argument is required:
   > "ssh_pub_key Required, String, the new public SSH key"
   But I thin that's wrong. *)
let destroy_ssh_key_raw api key =
  ssh_key_method api key "destroy" []

let sizes_raw api =
  request api "sizes" []

let domains_raw api =
  request api "domains" []

let new_domain_raw api name ip =
  request api "domains/new" [("name", name); ("ip_address", ip)]

let get_domain_raw api id =
  request api ("domains/" ^ string_of_int id) []

let domain_method api id resource args =
  request api (Printf.sprintf "domains/%d/%s" id resource) args

let destroy_domain_raw api id =
  domain_method api id "destroy" []
 
let get_domain_records_raw api id =
  domain_method api id "records" []

let new_domain_record api id args =
  domain_method api id "new" args

let new_CNAME_raw api id name hostname =
  new_domain_record api id [("record_type", "CNAME");
			    ("name", name);
			    ("data", hostname)]

let new_A_raw api id name ip =
  new_domain_record api id [("record_type", "A");
			    ("name", name);
			    ("data", ip)]

let new_MX_raw api id priority hostname =
  new_domain_record api id [("record_type", "MX");
			    ("priority", string_of_int priority);
			    ("data", hostname)]

let new_TXT_raw api id name data =
  new_domain_record api id [("record_type", "TXT");
			    ("name", name);
			    ("data", data)]

let new_NS_raw api id ns =
  new_domain_record api id [("record_type", "NS"); ("data", ns)]

let new_SRV_raw api id name hostname priority port weight =
  new_domain_record api id [("record_type", "SRV");
			    ("name", name);
			    ("data", hostname);
			    ("priority", string_of_int priority);
			    ("port", string_of_int port);
			    ("weight", string_of_int weight)]

let init () =
  Ssl.init();
    Http_client.Convenience.configure_pipeline
      (fun p ->
	let ctx = Ssl.create_context Ssl.TLSv1 Ssl.Client_context in
	let tct = Https_client.https_transport_channel_type ctx in
	p # configure_transport Http_client.https_cb_id tct
      )

let () = init ()
