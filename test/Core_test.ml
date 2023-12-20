open OUnit2
open Otracer.Core

let v1 = vec3_make 1.0 2.0 3.0

let tests =
  "test suite for core" >::: [ ("something" >:: fun _ -> assert_equal 1 1) ]
