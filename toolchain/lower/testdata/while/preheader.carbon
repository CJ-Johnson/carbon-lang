// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// TIP: To test this file alone, run:
// TIP:   bazel test //toolchain/testing:file_test --test_arg=--file_tests=toolchain/lower/testdata/while/preheader.carbon
// TIP: To dump output, run:
// TIP:   bazel run //toolchain/testing:file_test -- --dump_output --file_tests=toolchain/lower/testdata/while/preheader.carbon

fn Cond() -> bool;

fn F();
fn G();

// TODO: It would be better to preserve the loop preheader blocks from SemIR
// into LLVM IR. If we don't, LLVM will recreate them for us as part of loop
// canonicalization.
fn While() {
  while (Cond()) {
    F();
  }

  if (Cond()) {
    while (Cond()) {
      G();
    }
  }
}

// CHECK:STDOUT: ; ModuleID = 'preheader.carbon'
// CHECK:STDOUT: source_filename = "preheader.carbon"
// CHECK:STDOUT:
// CHECK:STDOUT: declare i1 @Cond()
// CHECK:STDOUT:
// CHECK:STDOUT: declare void @F()
// CHECK:STDOUT:
// CHECK:STDOUT: declare void @G()
// CHECK:STDOUT:
// CHECK:STDOUT: define void @While() {
// CHECK:STDOUT: entry:
// CHECK:STDOUT:   br label %while.cond.loc20
// CHECK:STDOUT:
// CHECK:STDOUT: while.cond.loc20:                                 ; preds = %entry, %while.body.loc20
// CHECK:STDOUT:   %Cond.call.loc20 = call i1 @Cond()
// CHECK:STDOUT:   br i1 %Cond.call.loc20, label %while.body.loc20, label %while.done.loc20
// CHECK:STDOUT:
// CHECK:STDOUT: while.body.loc20:                                 ; preds = %while.cond.loc20
// CHECK:STDOUT:   call void @F()
// CHECK:STDOUT:   br label %while.cond.loc20
// CHECK:STDOUT:
// CHECK:STDOUT: while.done.loc20:                                 ; preds = %while.cond.loc20
// CHECK:STDOUT:   %Cond.call.loc24 = call i1 @Cond()
// CHECK:STDOUT:   br i1 %Cond.call.loc24, label %while.cond.loc25, label %if.else
// CHECK:STDOUT:
// CHECK:STDOUT: while.cond.loc25:                                 ; preds = %while.body.loc25, %while.done.loc20
// CHECK:STDOUT:   %Cond.call.loc25 = call i1 @Cond()
// CHECK:STDOUT:   br i1 %Cond.call.loc25, label %while.body.loc25, label %while.done.loc25
// CHECK:STDOUT:
// CHECK:STDOUT: while.body.loc25:                                 ; preds = %while.cond.loc25
// CHECK:STDOUT:   call void @G()
// CHECK:STDOUT:   br label %while.cond.loc25
// CHECK:STDOUT:
// CHECK:STDOUT: while.done.loc25:                                 ; preds = %while.cond.loc25
// CHECK:STDOUT:   br label %if.else
// CHECK:STDOUT:
// CHECK:STDOUT: if.else:                                          ; preds = %while.done.loc25, %while.done.loc20
// CHECK:STDOUT:   ret void
// CHECK:STDOUT:
// CHECK:STDOUT: ; uselistorder directives
// CHECK:STDOUT:   uselistorder label %while.cond.loc20, { 1, 0 }
// CHECK:STDOUT: }
