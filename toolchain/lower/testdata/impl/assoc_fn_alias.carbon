// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// TIP: To test this file alone, run:
// TIP:   bazel test //toolchain/testing:file_test --test_arg=--file_tests=toolchain/lower/testdata/impl/assoc_fn_alias.carbon
// TIP: To dump output, run:
// TIP:   bazel run //toolchain/testing:file_test -- --dump_output --file_tests=toolchain/lower/testdata/impl/assoc_fn_alias.carbon

interface I {
  fn F[self: Self]() -> i32;
}

class A {
  alias F = I.F;
  var n: i32;
}

impl A as I {
  fn F[self: A]() -> i32 {
    return self.n;
  }
}

fn Call(a: A) -> i32 {
  return a.F();
}

// CHECK:STDOUT: ; ModuleID = 'assoc_fn_alias.carbon'
// CHECK:STDOUT: source_filename = "assoc_fn_alias.carbon"
// CHECK:STDOUT:
// CHECK:STDOUT: define i32 @F(ptr %self) {
// CHECK:STDOUT: entry:
// CHECK:STDOUT:   %.loc22_16.1.n = getelementptr inbounds { i32 }, ptr %self, i32 0, i32 0
// CHECK:STDOUT:   %.loc22_16.2 = load i32, ptr %.loc22_16.1.n, align 4
// CHECK:STDOUT:   ret i32 %.loc22_16.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: define i32 @Call(ptr %a) {
// CHECK:STDOUT: entry:
// CHECK:STDOUT:   %F.call = call i32 @F(ptr %a)
// CHECK:STDOUT:   ret i32 %F.call
// CHECK:STDOUT: }
