val request : ApiKey_t.api -> string -> (string * string) list -> Yojson.Safe.json

val init : unit -> unit

val droplets_raw : ApiKey_t.api -> Yojson.Safe.json
val new_droplet_raw : ApiKey_t.api ->
  ?priv:bool -> string -> int -> int -> int -> int list -> Yojson.Safe.json
val get_droplet_raw : ApiKey_t.api -> int -> Yojson.Safe.json
val reboot_droplet_raw : ApiKey_t.api -> int -> Yojson.Safe.json
val power_cycle_droplet_raw : ApiKey_t.api -> int -> Yojson.Safe.json
val shutdown_droplet_raw : ApiKey_t.api -> int -> Yojson.Safe.json
val power_off_droplet_raw : ApiKey_t.api -> int -> Yojson.Safe.json
val power_on_droplet_raw : ApiKey_t.api -> int -> Yojson.Safe.json
val reset_password_raw : ApiKey_t.api -> int -> Yojson.Safe.json
val resize_droplet_raw : ApiKey_t.api -> int -> int -> Yojson.Safe.json
val snapshot_droplet_raw : ApiKey_t.api -> ?name:string -> int -> Yojson.Safe.json
val restore_droplet_raw : ApiKey_t.api -> int -> int -> Yojson.Safe.json
val rebuild_droplet_raw : ApiKey_t.api -> int -> int -> Yojson.Safe.json
val enable_backups_raw : ApiKey_t.api -> int -> Yojson.Safe.json
val disable_backups_raw : ApiKey_t.api -> int -> Yojson.Safe.json
val rename_droplet_raw : ApiKey_t.api -> int -> string -> Yojson.Safe.json
val destroy_droplet_raw : ApiKey_t.api -> ?scrub:bool -> int -> Yojson.Safe.json
val regions_raw : ApiKey_t.api -> Yojson.Safe.json
val images_raw : ?filter:string -> ApiKey_t.api -> Yojson.Safe.json
val get_image_raw : ApiKey_t.api -> int -> Yojson.Safe.json
val destroy_image_raw : ApiKey_t.api -> int -> Yojson.Safe.json
val transfer_image_raw : ApiKey_t.api -> int -> int -> Yojson.Safe.json
val ssh_keys_raw : ApiKey_t.api -> Yojson.Safe.json
val new_ssh_key_raw : ApiKey_t.api -> string -> string -> Yojson.Safe.json
val get_ssh_key_raw : ApiKey_t.api -> int -> Yojson.Safe.json
val edit_ssh_key_raw : ApiKey_t.api -> int -> string -> Yojson.Safe.json
val destroy_ssh_key_raw : ApiKey_t.api -> int -> Yojson.Safe.json
val sizes_raw : ApiKey_t.api -> Yojson.Safe.json
val domains_raw : ApiKey_t.api -> Yojson.Safe.json
val new_domain_raw : ApiKey_t.api -> string -> string -> Yojson.Safe.json
val get_domain_raw : ApiKey_t.api -> int -> Yojson.Safe.json
val destroy_domain_raw : ApiKey_t.api -> int -> Yojson.Safe.json
val get_domain_records_raw : ApiKey_t.api -> int -> Yojson.Safe.json
val new_CNAME_raw : ApiKey_t.api -> int -> string -> string -> Yojson.Safe.json
val new_A_raw : ApiKey_t.api -> int -> string -> string -> Yojson.Safe.json
val new_MX_raw : ApiKey_t.api  -> int -> int -> string -> Yojson.Safe.json
val new_TXT_raw : ApiKey_t.api -> int -> string -> string -> Yojson.Safe.json
val new_NS_raw : ApiKey_t.api -> int -> string -> Yojson.Safe.json
val new_SRV_raw : ApiKey_t.api -> int -> string -> string -> int -> int -> int -> Yojson.Safe.json
