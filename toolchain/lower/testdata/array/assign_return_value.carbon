// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// TIP: To test this file alone, run:
// TIP:   bazel test //toolchain/testing:file_test --test_arg=--file_tests=toolchain/lower/testdata/array/assign_return_value.carbon
// TIP: To dump output, run:
// TIP:   bazel run //toolchain/testing:file_test -- --dump_output --file_tests=toolchain/lower/testdata/array/assign_return_value.carbon

fn F() -> (i32, i32) { return (12, 24); }

fn Run() {
  var t: [i32; 2] = F();
}

// CHECK:STDOUT: ; ModuleID = 'assign_return_value.carbon'
// CHECK:STDOUT: source_filename = "assign_return_value.carbon"
// CHECK:STDOUT:
// CHECK:STDOUT: @tuple.loc11_39 = internal constant { i32, i32 } { i32 12, i32 24 }
// CHECK:STDOUT:
// CHECK:STDOUT: define void @F(ptr sret({ i32, i32 }) %return) {
// CHECK:STDOUT: entry:
// CHECK:STDOUT:   %.loc11_38.2.tuple.elem = getelementptr inbounds { i32, i32 }, ptr %return, i32 0, i32 0
// CHECK:STDOUT:   %.loc11_38.4.tuple.elem = getelementptr inbounds { i32, i32 }, ptr %return, i32 0, i32 1
// CHECK:STDOUT:   call void @llvm.memcpy.p0.p0.i64(ptr align 4 %return, ptr align 4 @tuple.loc11_39, i64 8, i1 false)
// CHECK:STDOUT:   ret void
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: define void @main() {
// CHECK:STDOUT: entry:
// CHECK:STDOUT:   %t.var = alloca [2 x i32], align 4
// CHECK:STDOUT:   %.loc14_22.1.temp = alloca { i32, i32 }, align 8
// CHECK:STDOUT:   call void @F(ptr %.loc14_22.1.temp)
// CHECK:STDOUT:   %.loc14_22.3.tuple.elem = getelementptr inbounds { i32, i32 }, ptr %.loc14_22.1.temp, i32 0, i32 0
// CHECK:STDOUT:   %.loc14_22.4 = load i32, ptr %.loc14_22.3.tuple.elem, align 4
// CHECK:STDOUT:   %.loc14_22.6.array.index = getelementptr inbounds [2 x i32], ptr %t.var, i32 0, i32 0
// CHECK:STDOUT:   store i32 %.loc14_22.4, ptr %.loc14_22.6.array.index, align 4
// CHECK:STDOUT:   %.loc14_22.8.tuple.elem = getelementptr inbounds { i32, i32 }, ptr %.loc14_22.1.temp, i32 0, i32 1
// CHECK:STDOUT:   %.loc14_22.9 = load i32, ptr %.loc14_22.8.tuple.elem, align 4
// CHECK:STDOUT:   %.loc14_22.11.array.index = getelementptr inbounds [2 x i32], ptr %t.var, i32 0, i32 1
// CHECK:STDOUT:   store i32 %.loc14_22.9, ptr %.loc14_22.11.array.index, align 4
// CHECK:STDOUT:   ret void
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: ; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
// CHECK:STDOUT: declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #0
// CHECK:STDOUT:
// CHECK:STDOUT: attributes #0 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
