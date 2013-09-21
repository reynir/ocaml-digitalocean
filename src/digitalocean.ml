module Json = Yojson.Safe
open Http_client.Convenience
open ApiKey_t
module Url = Netencoding.Url

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
  match Json.from_string reply with
  | `Assoc xs ->
    if List.assoc "status" xs <> `String "OK"
    then failwith "Status was not OK"
    else reply
  | _ -> failwith "Reply was not a json object!"

let droplets (api : api) =
  request api "droplets" []

let droplet_method api id meth args =
  request
    api
    (Printf.sprintf "droplets/%s/%s" id meth)
    args

let new_droplet api ?(priv=false) name size image region ssh_keys  =
  let other_args =
    [ ("name", name);
      ("size_id", size);
      ("image_id", image);
      ("region_id", region);
      ("private_networking", string_of_bool priv) ]
  in request api "droplets/new"
  (if ssh_keys = []
   then other_args
   else ("ssh_key_ids", String.concat "," ssh_keys)
      :: other_args)
  
let get_droplet api id =
  request api ("droplets/"^id) []

let reboot_droplet api id =
  droplet_method api id "reboot" []

let power_cycle_droplet api id =
  droplet_method api id "power_cycle" []

let shutdown_droplet api id =
  droplet_method api id "shutdown" []

let power_off_droplet api id =
  droplet_method api id "power_off" []

let power_on_droplet api id =
  droplet_method api id "power_on" []

let reset_password api id =
  droplet_method api id "password_reset" []

let resize_droplet api id size =
  droplet_method api id "resize" [("size_id", size)]

let snapshot_droplet api ?(name="") id =
  let args = if name = "" then [] else [("name", name)] in
  droplet_method api id "snapshot" args

let restore_droplet api id image =
  droplet_method api id "restore" [("image_id", image)]

let rebuild_droplet api id image =
  droplet_method api id "rebuild" [("image_id", image)]

let enable_backups api id =
  droplet_method api id "enable_backups" []

let disable_backups api id =
  droplet_method api id "disable_backups" []

let rename_droplet api id name =
  droplet_method api id "rename" [("name", name)]

let destroy_droplet api ?(scrub=true) id  =
  droplet_method api id "destroy" [("scrub", string_of_bool scrub)]

let regions api =
  request api "regions" []

let images ?(filter="") api =
  request api "images"
    (if filter = ""
     then []
     else [("filter", filter)])

let get_image api image =
  request api ("images/"^image) []

let destroy_image api image =
  request api ("images/"^image^"/destroy") []

let transfer_image api image region =
  request api ("images/"^image^"/transfer") [("region_id", region)]

let ssh_keys api =
  request api "ssh_keys" []

let new_ssh_key api name key =
  request api "ssh_keys/new" [("name", name); ("ssh_pub_key", key)]

let get_ssh_key api id =
  request api ("ssh_keys/"^id) []

let edit_ssh_key api id new_key =
  request api ("ssh_keys/"^id^"/edit") [("ssh_pub_key", new_key)]

(* Documentation says another argument is required:
   > "ssh_pub_key Required, String, the new public SSH key"
   But I thin that's wrong. *)
let destroy_ssh_key api id =
  request api ("ssh_keys/"^id^"/destroy") []

let sizes api =
  request api "sizes" []

let domains api =
  request api "domains" []

let new_domain api name ip =
  request api "domains/new" [("name", name); ("ip_address", ip)]

let get_domain api id =
  request api ("domains/"^id) []

let destroy_domain api id =
  request api ("domains/"^id^"/destroy") []
 
let get_domain_records api id =
  request api ("domains/"^id^"/records") []

let new_domain_record api id args =
  request api ("domains/"^id^"/records/new") args

let new_CNAME api id name hostname =
  new_domain_record api id [("record_type", "CNAME");
			    ("name", name);
			    ("data", hostname)]

let new_A api id name ip =
  new_domain_record api id [("record_type", "A");
			    ("name", name);
			    ("data", ip)]

let new_MX api id priority hostname =
  new_domain_record api id [("record_type", "MX");
			    ("priority", string_of_int priority);
			    ("data", hostname)]

let new_TXT api id name data =
  new_domain_record api id [("record_type", "TXT");
			    ("name", name);
			    ("data", data)]

let new_NS api id ns =
  new_domain_record api id [("record_type", "NS"); ("data", ns)]

let new_SRV api id name hostname priority port weight =
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
