(* image_io.mli *)

type imageWriter = { width : int; height : int; gamma : float }
(** defines some options for image writing (although pretty useless) *)

type pixel = Core.pixel
(** pixel definition to use*)

val write_img : imageWriter -> string -> pixel list -> unit
(** [write_img iw fn pix] writes the data in [pix] to [fn] as specified by the config in [iw] *)

val comp_map : (float -> float) -> pixel -> pixel
(** [comp_map f p] applies [f] to each component of [p]*)
