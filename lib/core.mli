(* core.ml *)

type vec3 = { x : float; y : float; z : float }
(** defines the basic R^3 vector type *)

val float_cmp : float -> float -> bool
(** [float_cmp a b] compares floats [a] and [b] up to an eps of 10^-7 *)

val make_vec3 : float -> float -> float -> vec3
(** [make_vec a b c] makes a vec3 with [a] [b] and [c] *)

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

val ( @@ ) : vec3 -> vec3 -> float
(** [x @@ y] dot product [x] and [y] *)

val ( ++ ) : vec3 -> vec3 -> vec3
(** [x ++ y] adds [x] and [y] *)

val ( -- ) : vec3 -> vec3 -> vec3
(** [x -- y] subtracts [x] and [y] *)

val ( ** ) : float -> vec3 -> vec3
(** [r ** s] scales [s] by [r] *)
