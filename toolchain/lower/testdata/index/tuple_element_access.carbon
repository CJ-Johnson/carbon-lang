// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// TIP: To test this file alone, run:
// TIP:   bazel test //toolchain/testing:file_test --test_arg=--file_tests=toolchain/lower/testdata/index/tuple_element_access.carbon
// TIP: To dump output, run:
// TIP:   bazel run //toolchain/testing:file_test -- --dump_output --file_tests=toolchain/lower/testdata/index/tuple_element_access.carbon

fn Run() -> i32 {
  var a: (i32, i32, i32) = (0, 1, 2);
  var b: i32 = a[0];
  var c: i32 = a[2];
  return 0;
}

// CHECK:STDOUT: ; ModuleID = 'tuple_element_access.carbon'
// CHECK:STDOUT: source_filename = "tuple_element_access.carbon"
// CHECK:STDOUT:
// CHECK:STDOUT: @tuple.loc12_37 = internal constant { i32, i32, i32 } { i32 0, i32 1, i32 2 }
// CHECK:STDOUT:
// CHECK:STDOUT: define i32 @main() {
// CHECK:STDOUT: entry:
// CHECK:STDOUT:   %a.var = alloca { i32, i32, i32 }, align 8
// CHECK:STDOUT:   %.loc12_36.2.tuple.elem = getelementptr inbounds { i32, i32, i32 }, ptr %a.var, i32 0, i32 0
// CHECK:STDOUT:   %.loc12_36.4.tuple.elem = getelementptr inbounds { i32, i32, i32 }, ptr %a.var, i32 0, i32 1
// CHECK:STDOUT:   %.loc12_36.6.tuple.elem = getelementptr inbounds { i32, i32, i32 }, ptr %a.var, i32 0, i32 2
// CHECK:STDOUT:   call void @llvm.memcpy.p0.p0.i64(ptr align 4 %a.var, ptr align 4 @tuple.loc12_37, i64 12, i1 false)
// CHECK:STDOUT:   %b.var = alloca i32, align 4
// CHECK:STDOUT:   %.loc13_19.1.tuple.index = getelementptr inbounds { i32, i32, i32 }, ptr %a.var, i32 0, i32 0
// CHECK:STDOUT:   %.loc13_19.2 = load i32, ptr %.loc13_19.1.tuple.index, align 4
// CHECK:STDOUT:   store i32 %.loc13_19.2, ptr %b.var, align 4
// CHECK:STDOUT:   %c.var = alloca i32, align 4
// CHECK:STDOUT:   %.loc14_19.1.tuple.index = getelementptr inbounds { i32, i32, i32 }, ptr %a.var, i32 0, i32 2
// CHECK:STDOUT:   %.loc14_19.2 = load i32, ptr %.loc14_19.1.tuple.index, align 4
// CHECK:STDOUT:   store i32 %.loc14_19.2, ptr %c.var, align 4
// CHECK:STDOUT:   ret i32 0
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: ; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
// CHECK:STDOUT: declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #0
// CHECK:STDOUT:
// CHECK:STDOUT: attributes #0 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
