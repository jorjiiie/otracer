open OUnit2
open Otracer.Cam
open Otracer.Core

let v1 =
  make_camera Perspective (vec3_broadcast 0.) (vec3_make 1. 0. 0.)
    (vec3_make 0. 0. 1.) 90. 500 600

let o, d = get_ray v1 499 599
let joe = List.iter (fun x -> x) []

let tests =
  "test suite for core"
  >::: [
         ("something" >:: fun _ -> assert_equal 1 1);
         ( "joe print " >:: fun _ ->
           joe;
           assert_equal 2 2 );
       ]
