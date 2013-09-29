val request : ApiKey_t.api -> string -> (string * string) list -> string

val init : unit -> unit

val droplets_raw : ApiKey_t.api -> string
val new_droplet_raw : ApiKey_t.api ->
  ?priv:bool -> string -> int -> int -> int -> int list -> string
val get_droplet_raw : ApiKey_t.api -> int -> string
val get_droplet : ApiKey_t.api -> int -> Responses_t.get_droplet
val reboot_droplet_raw : ApiKey_t.api -> int -> string
val power_cycle_droplet_raw : ApiKey_t.api -> int -> string
val shutdown_droplet_raw : ApiKey_t.api -> int -> string
val power_off_droplet_raw : ApiKey_t.api -> int -> string
val power_on_droplet_raw : ApiKey_t.api -> int -> string
val reset_password_raw : ApiKey_t.api -> int -> string
val resize_droplet_raw : ApiKey_t.api -> int -> int -> string
val snapshot_droplet_raw : ApiKey_t.api -> ?name:string -> int -> string
val restore_droplet_raw : ApiKey_t.api -> int -> int -> string
val rebuild_droplet_raw : ApiKey_t.api -> int -> int -> string
val enable_backups_raw : ApiKey_t.api -> int -> string
val disable_backups_raw : ApiKey_t.api -> int -> string
val rename_droplet_raw : ApiKey_t.api -> int -> string -> string
val destroy_droplet_raw : ApiKey_t.api -> ?scrub:bool -> int -> string
val regions_raw : ApiKey_t.api -> string
val images_raw : ?filter:string -> ApiKey_t.api -> string
val get_image_raw : ApiKey_t.api -> int -> string
val destroy_image_raw : ApiKey_t.api -> int -> string
val transfer_image_raw : ApiKey_t.api -> int -> int -> string
val ssh_keys_raw : ApiKey_t.api -> string
val new_ssh_key_raw : ApiKey_t.api -> string -> string -> string
val get_ssh_key_raw : ApiKey_t.api -> int -> string
val edit_ssh_key_raw : ApiKey_t.api -> int -> string -> string
val destroy_ssh_key_raw : ApiKey_t.api -> int -> string
val sizes_raw : ApiKey_t.api -> string
val domains_raw : ApiKey_t.api -> string
val new_domain_raw : ApiKey_t.api -> string -> string -> string
val get_domain_raw : ApiKey_t.api -> int -> string
val destroy_domain_raw : ApiKey_t.api -> int -> string
val get_domain_records_raw : ApiKey_t.api -> int -> string
val new_CNAME_raw : ApiKey_t.api -> int -> string -> string -> string
val new_A_raw : ApiKey_t.api -> int -> string -> string -> string
val new_MX_raw : ApiKey_t.api  -> int -> int -> string -> string
val new_TXT_raw : ApiKey_t.api -> int -> string -> string -> string
val new_NS_raw : ApiKey_t.api -> int -> string -> string
val new_SRV_raw : ApiKey_t.api -> int -> string -> string -> int -> int -> int -> string
