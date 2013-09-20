module Json = Yojson.Safe
open Http_client.Convenience
open ApiKey_t

let request
    (api : api)
    (resource : string)
    (args : (string*string) list)
    : string =
  let url =
    Printf.sprintf
      "https://api.digitalocean.com/%s/?client_id=%s&api_key=%s"
      resource
      api.id
      api.key in
  let reply = http_get url in
  match Json.from_string reply with
  | `Assoc xs ->
    if List.assoc "status" xs <> `String "OK"
    then failwith "Status was not OK"
    else reply
  | _ -> failwith "Reply was not a json object!"

let droplets (api : api) =
  request api "droplets"

let droplet_new api = api

let init () =
  Ssl.init();
    Http_client.Convenience.configure_pipeline
      (fun p ->
	let ctx = Ssl.create_context Ssl.TLSv1 Ssl.Client_context in
	let tct = Https_client.https_transport_channel_type ctx in
	p # configure_transport Http_client.https_cb_id tct
      )
