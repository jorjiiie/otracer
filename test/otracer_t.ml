open OUnit2

let _ = run_test_tt_main Core_test.tests
let _ = run_test_tt_main Image_io_test.tests
let _ = run_test_tt_main Geo_test.tests
let _ = run_test_tt_main Cam_test.tests
