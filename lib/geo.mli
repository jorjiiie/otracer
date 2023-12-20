(** geo.mli *)

type vec3 = Core.vec3
type ray = Core.ray
type material = Blue | Red
type shape = Sphere of (vec3 * float)
type hit_info = { pos : vec3; mat : material }
type primitive = material * shape

val intersect : ray -> primitive -> hit_info option
