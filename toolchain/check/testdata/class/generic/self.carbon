// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// TIP: To test this file alone, run:
// TIP:   bazel test //toolchain/testing:file_test --test_arg=--file_tests=toolchain/check/testdata/class/generic/self.carbon
// TIP: To dump output, run:
// TIP:   bazel run //toolchain/testing:file_test -- --dump_output --file_tests=toolchain/check/testdata/class/generic/self.carbon

class Class(T:! type) {
  // `Self` is the same as `Class(T)` here.
  // TODO: Find a better way to test two types are the same.
  fn MakeSelf() -> Self;
  fn MakeClass() -> Class(T);
  fn F() {
    var c: Class(T) = MakeSelf();
    var s: Self = MakeClass();
  }
}

// CHECK:STDOUT: --- self.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %T: type = bind_symbolic_name T 0 [symbolic]
// CHECK:STDOUT:   %Class.type: type = generic_class_type @Class [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %Class.1: %Class.type = struct_value () [template]
// CHECK:STDOUT:   %Class.2: type = class_type @Class, (%T) [symbolic]
// CHECK:STDOUT:   %MakeSelf.type: type = fn_type @MakeSelf [template]
// CHECK:STDOUT:   %MakeSelf: %MakeSelf.type = struct_value () [template]
// CHECK:STDOUT:   %MakeClass.type: type = fn_type @MakeClass [template]
// CHECK:STDOUT:   %MakeClass: %MakeClass.type = struct_value () [template]
// CHECK:STDOUT:   %F.type: type = fn_type @F [template]
// CHECK:STDOUT:   %F: %F.type = struct_value () [template]
// CHECK:STDOUT:   %.2: type = struct_type {} [template]
// CHECK:STDOUT:   %.3: type = ptr_type %.2 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .Class = %Class.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core.import = import Core
// CHECK:STDOUT:   %Core: <namespace> = namespace %Core.import, [template] {}
// CHECK:STDOUT:   %Class.decl: %Class.type = class_decl @Class [template = constants.%Class.1] {
// CHECK:STDOUT:     %T.loc11_13.1: type = param T
// CHECK:STDOUT:     %T.loc11_13.2: type = bind_symbolic_name T 0, %T.loc11_13.1 [symbolic = constants.%T]
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @Class
// CHECK:STDOUT:     generic [file.%T.loc11_13.2: type] {
// CHECK:STDOUT:   %MakeSelf.decl: %MakeSelf.type = fn_decl @MakeSelf [template = constants.%MakeSelf] {
// CHECK:STDOUT:     %Self.ref: type = name_ref Self, constants.%Class.2 [symbolic = constants.%Class.2]
// CHECK:STDOUT:     %return.var.loc14: ref %Class.2 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %MakeClass.decl: %MakeClass.type = fn_decl @MakeClass [template = constants.%MakeClass] {
// CHECK:STDOUT:     %Class.ref: %Class.type = name_ref Class, file.%Class.decl [template = constants.%Class.1]
// CHECK:STDOUT:     %T.ref: type = name_ref T, file.%T.loc11_13.2 [symbolic = constants.%T]
// CHECK:STDOUT:     %.loc15_26: init type = call %Class.ref(%T.ref) [symbolic = constants.%Class.2]
// CHECK:STDOUT:     %.loc15_28.1: type = value_of_initializer %.loc15_26 [symbolic = constants.%Class.2]
// CHECK:STDOUT:     %.loc15_28.2: type = converted %.loc15_26, %.loc15_28.1 [symbolic = constants.%Class.2]
// CHECK:STDOUT:     %return.var.loc15: ref %Class.2 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %F.decl: %F.type = fn_decl @F [template = constants.%F] {}
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = constants.%Class.2
// CHECK:STDOUT:   .MakeSelf = %MakeSelf.decl
// CHECK:STDOUT:   .MakeClass = %MakeClass.decl
// CHECK:STDOUT:   .F = %F.decl
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @MakeSelf() -> %Class.2
// CHECK:STDOUT:     generic [file.%T.loc11_13.2: type];
// CHECK:STDOUT:
// CHECK:STDOUT: fn @MakeClass() -> %Class.2
// CHECK:STDOUT:     generic [file.%T.loc11_13.2: type];
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F()
// CHECK:STDOUT:     generic [file.%T.loc11_13.2: type] {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %Class.ref: %Class.type = name_ref Class, file.%Class.decl [template = constants.%Class.1]
// CHECK:STDOUT:   %T.ref: type = name_ref T, file.%T.loc11_13.2 [symbolic = constants.%T]
// CHECK:STDOUT:   %.loc17_17: init type = call %Class.ref(%T.ref) [symbolic = constants.%Class.2]
// CHECK:STDOUT:   %.loc17_19.1: type = value_of_initializer %.loc17_17 [symbolic = constants.%Class.2]
// CHECK:STDOUT:   %.loc17_19.2: type = converted %.loc17_17, %.loc17_19.1 [symbolic = constants.%Class.2]
// CHECK:STDOUT:   %c.var: ref %Class.2 = var c
// CHECK:STDOUT:   %c: ref %Class.2 = bind_name c, %c.var
// CHECK:STDOUT:   %MakeSelf.ref: %MakeSelf.type = name_ref MakeSelf, @Class.%MakeSelf.decl [template = constants.%MakeSelf]
// CHECK:STDOUT:   %.loc17_9: ref %Class.2 = splice_block %c.var {}
// CHECK:STDOUT:   %MakeSelf.call: init %Class.2 = call %MakeSelf.ref() to %.loc17_9
// CHECK:STDOUT:   assign %c.var, %MakeSelf.call
// CHECK:STDOUT:   %Self.ref: type = name_ref Self, constants.%Class.2 [symbolic = constants.%Class.2]
// CHECK:STDOUT:   %s.var: ref %Class.2 = var s
// CHECK:STDOUT:   %s: ref %Class.2 = bind_name s, %s.var
// CHECK:STDOUT:   %MakeClass.ref: %MakeClass.type = name_ref MakeClass, @Class.%MakeClass.decl [template = constants.%MakeClass]
// CHECK:STDOUT:   %.loc18: ref %Class.2 = splice_block %s.var {}
// CHECK:STDOUT:   %MakeClass.call: init %Class.2 = call %MakeClass.ref() to %.loc18
// CHECK:STDOUT:   assign %s.var, %MakeClass.call
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
