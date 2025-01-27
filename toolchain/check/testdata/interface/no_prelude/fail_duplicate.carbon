// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// TIP: To test this file alone, run:
// TIP:   bazel test //toolchain/testing:file_test --test_arg=--file_tests=toolchain/check/testdata/interface/no_prelude/fail_duplicate.carbon
// TIP: To dump output, run:
// TIP:   bazel run //toolchain/testing:file_test -- --dump_output --file_tests=toolchain/check/testdata/interface/no_prelude/fail_duplicate.carbon

interface Interface { }

// CHECK:STDERR: fail_duplicate.carbon:[[@LINE+7]]:1: ERROR: Redefinition of interface Interface.
// CHECK:STDERR: interface Interface {
// CHECK:STDERR: ^~~~~~~~~~~~~~~~~~~~~
// CHECK:STDERR: fail_duplicate.carbon:[[@LINE-5]]:1: Previous definition was here.
// CHECK:STDERR: interface Interface { }
// CHECK:STDERR: ^~~~~~~~~~~~~~~~~~~~~
// CHECK:STDERR:
interface Interface {
  fn F();
}

fn Function();

// CHECK:STDERR: fail_duplicate.carbon:[[@LINE+7]]:1: ERROR: Duplicate name being declared in the same scope.
// CHECK:STDERR: interface Function;
// CHECK:STDERR: ^~~~~~~~~~~~~~~~~~~
// CHECK:STDERR: fail_duplicate.carbon:[[@LINE-5]]:1: Name is previously declared here.
// CHECK:STDERR: fn Function();
// CHECK:STDERR: ^~~~~~~~~~~~~~
// CHECK:STDERR:
interface Function;

class Class;

// CHECK:STDERR: fail_duplicate.carbon:[[@LINE+6]]:1: ERROR: Duplicate name being declared in the same scope.
// CHECK:STDERR: interface Class { }
// CHECK:STDERR: ^~~~~~~~~~~~~~~~~
// CHECK:STDERR: fail_duplicate.carbon:[[@LINE-5]]:1: Name is previously declared here.
// CHECK:STDERR: class Class;
// CHECK:STDERR: ^~~~~~~~~~~~
interface Class { }

// CHECK:STDOUT: --- fail_duplicate.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %.1: type = interface_type @Interface [template]
// CHECK:STDOUT:   %Self.1: %.1 = bind_symbolic_name Self 0 [symbolic]
// CHECK:STDOUT:   %F.type: type = fn_type @F [template]
// CHECK:STDOUT:   %.2: type = tuple_type () [template]
// CHECK:STDOUT:   %F: %F.type = struct_value () [template]
// CHECK:STDOUT:   %Function.type: type = fn_type @Function [template]
// CHECK:STDOUT:   %Function: %Function.type = struct_value () [template]
// CHECK:STDOUT:   %.3: type = interface_type @.1 [template]
// CHECK:STDOUT:   %Class: type = class_type @Class [template]
// CHECK:STDOUT:   %.4: type = interface_type @.2 [template]
// CHECK:STDOUT:   %Self.2: %.4 = bind_symbolic_name Self 0 [symbolic]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Interface = %Interface.decl.loc11
// CHECK:STDOUT:     .Function = %Function.decl
// CHECK:STDOUT:     .Class = %Class.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Interface.decl.loc11: type = interface_decl @Interface [template = constants.%.1] {}
// CHECK:STDOUT:   %Interface.decl.loc20: type = interface_decl @Interface [template = constants.%.1] {}
// CHECK:STDOUT:   %Function.decl: %Function.type = fn_decl @Function [template = constants.%Function] {}
// CHECK:STDOUT:   %.decl.loc33: type = interface_decl @.1 [template = constants.%.3] {}
// CHECK:STDOUT:   %Class.decl: type = class_decl @Class [template = constants.%Class] {}
// CHECK:STDOUT:   %.decl.loc43: type = interface_decl @.2 [template = constants.%.4] {}
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: interface @Interface {
// CHECK:STDOUT:   %F.decl: %F.type = fn_decl @F [template = constants.%F] {}
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = <unexpected instref inst+3>
// CHECK:STDOUT:   .F = <error>
// CHECK:STDOUT:   witness = ()
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: interface @.1;
// CHECK:STDOUT:
// CHECK:STDOUT: interface @.2 {
// CHECK:STDOUT:   %Self: %.4 = bind_symbolic_name Self 0 [symbolic = constants.%Self.2]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = %Self
// CHECK:STDOUT:   witness = ()
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @Class;
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F();
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Function();
// CHECK:STDOUT:
