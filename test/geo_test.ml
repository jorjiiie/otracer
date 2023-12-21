open OUnit2
open Otracer.Geo
open Otracer.Core

let v = vec3_make 1.0 0.0 0.0
let s = Sphere (v, 0.25)
let prim = (make_material TMatte (pix_broadcast 1.), s)
let r = (vec3_broadcast 0., vec3_make 1.0 0. 0.)
let y = intersect r prim
let test_geo = assert (Option.is_some y)
let tests = "test suite for core" >::: [ ("something" >:: fun _ -> test_geo) ]
