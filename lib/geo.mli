(** geo.mli *)

open Core

type vec3 = Core.vec3
type ray = Core.ray
type material
type mat_opt = TMatte | TLight

val make_material : mat_opt -> pixel -> material
(** [make_material t c] makes a material of color [c] of type [t]*)
(* yes this is a terrible abstraction *)

val material_att : material -> pixel
(** [material_att m] gives the color of [m]. solid colors for now *)

val material_emit : material -> pixel
(** [material_emit m] gives emission of [m] *)

val material_sample : material -> ray -> vec3 -> vec3
(** [material_sample m r n] gives a sample of [m] with wi = [r] and normal [n]*)

type shape = Sphere of (vec3 * float)
type hit_info
type primitive = material * shape

val shape_normal : shape -> vec3 -> vec3
(** [shape_normal s v] gives the normal of [s] at [v] *)

val intersect : ray -> primitive -> hit_info option

type world

val make_world : primitive list -> world
(** [make_world lst] makes a world with the list of primitives *)

val bounce : world -> ray -> int -> pixel
(** [bounce w r b] returns attenuation given by [r] in [w], if [b] < 0 then black *)
