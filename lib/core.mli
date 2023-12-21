(* core.ml *)

type vec3 = { x : float; y : float; z : float }
(** defines the basic R^3 vector type *)

val vec3_make : float -> float -> float -> vec3

val vec3_broadcast : float -> vec3
(** [vec3_broadcast a] vec3 filled with [a] *)

val float_cmp : float -> float -> bool
(** [float_cmp a b] compares floats [a] and [b] up to an eps of 10^-7 *)

val vec3_dot : vec3 -> vec3 -> float
(** [vec3_dot x y] takes the dot product of [x] and [y] *)

val vec3_add : vec3 -> vec3 -> vec3
(** [vec3_add x y] adds [x] and [y] *)

val vec3_sub : vec3 -> vec3 -> vec3
(** [vec3_sub x y] subtracts [x] and [y] *)

val vec3_scale : float -> vec3 -> vec3
(** [vec3_scale r v] scales [v] by the float [r] *)

val vec3_neg : vec3 -> vec3
(** [vec3_neg v] flips [v] around, negating componentwise *)

val vec3_norm_sq : vec3 -> float
(** [vec3_norm_sq v] takes the norm squared of [v], or dot [v] dot [v] *)

val vec3_norm : vec3 -> float
(** [vec3_norm v] takes the norm of [v], or the sqrt of [v] dot [v] *)

val vec3_map : (float -> float) -> vec3 -> vec3
(** [vec3_map f v] applies [f] to each component of [v] *)

val vec3_combine : (float -> float -> float) -> vec3 -> vec3 -> vec3
(** [vec3_combine f x y] uses [f] to combine elementwise [x] and [y] *)

val vec3_dist_sq : vec3 -> vec3 -> float
(** [vec3_dist_sq u v] gives distance squared between [u] and [v] *)

val vec3_dist : vec3 -> vec3 -> float
(** [vec3_dist u v] gives distance between [u] and [v] *)

val vec3_unit : vec3 -> vec3
(** [vec3_unit v] returns a unit direction pointing in [v]'s direction *)

val vec3_cross : vec3 -> vec3 -> vec3
(** [vec3_cross u v] gives the cross product of [u] and [v] *)

val ( @@ ) : vec3 -> vec3 -> float
(** [x @@ y] dot product [x] and [y] *)

val ( ++ ) : vec3 -> vec3 -> vec3
(** [x ++ y] adds [x] and [y] *)

val ( -- ) : vec3 -> vec3 -> vec3
(** [x -- y] subtracts [x] and [y] *)

val ( ** ) : float -> vec3 -> vec3
(** [r ** s] scales [s] by [r] *)

type ray = vec3 * vec3
(** rays are a tuple of vec3 *)

type pixel = { r : float; g : float; b : float }
(** defines a pixel type with 3 components*)

val pix_make : float -> float -> float -> pixel
(** [pix_make r g b] makes a pixel with [r] [g] [b]*)

val pix_broadcast : float -> pixel
(** [pix_broadcast a] makes a pixel with [a]*)

val vec3_of_pixel : pixel -> vec3
(** [vec3_of_pixel p] converts [p] to a vec3 to do ops on bc I'm lazy *)

val pixel_of_vec3 : vec3 -> pixel
(** [pixel_of_vec3 v] converts [v] to a pixel from ops above *)

val pix_add : pixel -> pixel -> pixel
(** [pix_add a b] adds [a] and [b] componentwise*)

val pix_scale : float -> pixel -> pixel
(** [pix_scale r b] multiples each component of [b] by [r] *)

val pix_mul : pixel -> pixel -> pixel
(** [pix_mul a b] multiplies component wide [a] and [b]*)
