open OUnit2
open Otracer.Geo
open Otracer.Core



let v = vec3_make 1.0 0.0 0.0

let s = Sphere (v, 0.25)

let prim = (Blue, s)

let r = (vec3_broadcast 0., vec3_make 1.0 0. 0.)

let y = intersect r prim

let test_geo =  
  assert (Option.is_some y && 
  (0.00001 > vec3_dist_sq (Option.get y).pos (vec3_make 0.75 0. 0.)))



let tests = "test suite for core" >::: [ ("something" >:: fun _ -> test_geo) ]
