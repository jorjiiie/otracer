(* image_io.mli *)

type imageWriter = {
  width : int;
  height : int;
  gamma : float;
}

type pixel = {
  r : float;
  g : float;
  b : float;
}


val write_img : imageWriter -> string -> pixel list -> unit
(** [write_img iw fn pix] writes the data in [pix] to [fn] as specified by the config in [iw] *)


val comp_map : (float -> float) -> pixel -> pixel
(** [comp_map f p] applies [f] to each component of [p]*)
