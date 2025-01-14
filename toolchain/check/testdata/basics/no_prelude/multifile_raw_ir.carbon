// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// ARGS: compile --no-prelude-import  --phase=check --dump-raw-sem-ir %s
//
// Check that raw IR dumping works as expected.
//
// AUTOUPDATE
// TIP: To test this file alone, run:
// TIP:   bazel test //toolchain/testing:file_test --test_arg=--file_tests=toolchain/check/testdata/basics/no_prelude/multifile_raw_ir.carbon
// TIP: To dump output, run:
// TIP:   bazel run //toolchain/testing:file_test -- --dump_output --file_tests=toolchain/check/testdata/basics/no_prelude/multifile_raw_ir.carbon

// --- a.carbon
package A;

fn A() {}

// --- b.carbon
package B;

import A;

fn B() {
  A.A();
}

// CHECK:STDOUT: ---
// CHECK:STDOUT: filename:        a.carbon
// CHECK:STDOUT: sem_ir:
// CHECK:STDOUT:   import_irs:
// CHECK:STDOUT:     ir0:             {decl_id: inst<invalid>, is_export: false}
// CHECK:STDOUT:   import_ir_insts: {}
// CHECK:STDOUT:   name_scopes:
// CHECK:STDOUT:     name_scope0:     {inst: inst+0, parent_scope: name_scope<invalid>, has_error: false, extended_scopes: [], names: {name0: inst+1}}
// CHECK:STDOUT:   bind_names:      {}
// CHECK:STDOUT:   functions:
// CHECK:STDOUT:     function0:       {name: name0, parent_scope: name_scope0, param_refs: empty, body: [block4]}
// CHECK:STDOUT:   classes:         {}
// CHECK:STDOUT:   generics:        {}
// CHECK:STDOUT:   generic_instances: {}
// CHECK:STDOUT:   types:
// CHECK:STDOUT:     type0:           {constant: template instNamespaceType, value_rep: {kind: copy, type: type0}}
// CHECK:STDOUT:     type1:           {constant: template inst+2, value_rep: {kind: none, type: type2}}
// CHECK:STDOUT:     type2:           {constant: template inst+3, value_rep: {kind: none, type: type2}}
// CHECK:STDOUT:   type_blocks:
// CHECK:STDOUT:     type_block0:     {}
// CHECK:STDOUT:   insts:
// CHECK:STDOUT:     'inst+0':          {kind: Namespace, arg0: name_scope0, arg1: inst<invalid>, type: type0}
// CHECK:STDOUT:     'inst+1':          {kind: FunctionDecl, arg0: function0, arg1: empty, type: type1}
// CHECK:STDOUT:     'inst+2':          {kind: FunctionType, arg0: function0, type: typeTypeType}
// CHECK:STDOUT:     'inst+3':          {kind: TupleType, arg0: type_block0, type: typeTypeType}
// CHECK:STDOUT:     'inst+4':          {kind: StructValue, arg0: empty, type: type1}
// CHECK:STDOUT:     'inst+5':          {kind: Return}
// CHECK:STDOUT:   constant_values:
// CHECK:STDOUT:     'inst+0':          template inst+0
// CHECK:STDOUT:     'inst+1':          template inst+4
// CHECK:STDOUT:     'inst+2':          template inst+2
// CHECK:STDOUT:     'inst+3':          template inst+3
// CHECK:STDOUT:     'inst+4':          template inst+4
// CHECK:STDOUT:   inst_blocks:
// CHECK:STDOUT:     empty:           {}
// CHECK:STDOUT:     exports:
// CHECK:STDOUT:       0:               inst+1
// CHECK:STDOUT:     import_refs:     {}
// CHECK:STDOUT:     global_init:     {}
// CHECK:STDOUT:     block4:
// CHECK:STDOUT:       0:               inst+5
// CHECK:STDOUT:     block5:
// CHECK:STDOUT:       0:               inst+0
// CHECK:STDOUT:       1:               inst+1
// CHECK:STDOUT: ...
// CHECK:STDOUT: ---
// CHECK:STDOUT: filename:        b.carbon
// CHECK:STDOUT: sem_ir:
// CHECK:STDOUT:   import_irs:
// CHECK:STDOUT:     ir0:             {decl_id: inst<invalid>, is_export: false}
// CHECK:STDOUT:     ir1:             {decl_id: inst+1, is_export: false}
// CHECK:STDOUT:   import_ir_insts:
// CHECK:STDOUT:     import_ir_inst0: {ir_id: ir1, inst_id: inst+1}
// CHECK:STDOUT:     import_ir_inst1: {ir_id: ir1, inst_id: inst+1}
// CHECK:STDOUT:   name_scopes:
// CHECK:STDOUT:     name_scope0:     {inst: inst+0, parent_scope: name_scope<invalid>, has_error: false, extended_scopes: [], names: {name1: inst+2, name0: inst+3}}
// CHECK:STDOUT:     name_scope1:     {inst: inst+2, parent_scope: name_scope0, has_error: false, extended_scopes: [], names: {}}
// CHECK:STDOUT:   bind_names:
// CHECK:STDOUT:     bind_name0:      {name: name1, parent_scope: name_scope1, index: comp_time_bind<invalid>}
// CHECK:STDOUT:   functions:
// CHECK:STDOUT:     function0:       {name: name0, parent_scope: name_scope0, param_refs: empty, body: [block4]}
// CHECK:STDOUT:     function1:       {name: name1, parent_scope: name_scope1, param_refs: empty}
// CHECK:STDOUT:   classes:         {}
// CHECK:STDOUT:   generics:        {}
// CHECK:STDOUT:   generic_instances: {}
// CHECK:STDOUT:   types:
// CHECK:STDOUT:     type0:           {constant: template instNamespaceType, value_rep: {kind: copy, type: type0}}
// CHECK:STDOUT:     type1:           {constant: template inst+4, value_rep: {kind: none, type: type2}}
// CHECK:STDOUT:     type2:           {constant: template inst+5, value_rep: {kind: none, type: type2}}
// CHECK:STDOUT:     type3:           {constant: template inst+10, value_rep: {kind: none, type: type2}}
// CHECK:STDOUT:   type_blocks:
// CHECK:STDOUT:     type_block0:     {}
// CHECK:STDOUT:   insts:
// CHECK:STDOUT:     'inst+0':          {kind: Namespace, arg0: name_scope0, arg1: inst<invalid>, type: type0}
// CHECK:STDOUT:     'inst+1':          {kind: ImportDecl, arg0: name1}
// CHECK:STDOUT:     'inst+2':          {kind: Namespace, arg0: name_scope1, arg1: inst+1, type: type0}
// CHECK:STDOUT:     'inst+3':          {kind: FunctionDecl, arg0: function0, arg1: empty, type: type1}
// CHECK:STDOUT:     'inst+4':          {kind: FunctionType, arg0: function0, type: typeTypeType}
// CHECK:STDOUT:     'inst+5':          {kind: TupleType, arg0: type_block0, type: typeTypeType}
// CHECK:STDOUT:     'inst+6':          {kind: StructValue, arg0: empty, type: type1}
// CHECK:STDOUT:     'inst+7':          {kind: NameRef, arg0: name1, arg1: inst+2, type: type0}
// CHECK:STDOUT:     'inst+8':          {kind: ImportRefLoaded, arg0: import_ir_inst0, arg1: bind_name0, type: type3}
// CHECK:STDOUT:     'inst+9':          {kind: FunctionDecl, arg0: function1, arg1: empty, type: type3}
// CHECK:STDOUT:     'inst+10':         {kind: FunctionType, arg0: function1, type: typeTypeType}
// CHECK:STDOUT:     'inst+11':         {kind: StructValue, arg0: empty, type: type3}
// CHECK:STDOUT:     'inst+12':         {kind: NameRef, arg0: name1, arg1: inst+8, type: type3}
// CHECK:STDOUT:     'inst+13':         {kind: Call, arg0: inst+12, arg1: block5, type: type2}
// CHECK:STDOUT:     'inst+14':         {kind: Return}
// CHECK:STDOUT:   constant_values:
// CHECK:STDOUT:     'inst+0':          template inst+0
// CHECK:STDOUT:     'inst+2':          template inst+2
// CHECK:STDOUT:     'inst+3':          template inst+6
// CHECK:STDOUT:     'inst+4':          template inst+4
// CHECK:STDOUT:     'inst+5':          template inst+5
// CHECK:STDOUT:     'inst+6':          template inst+6
// CHECK:STDOUT:     'inst+7':          template inst+2
// CHECK:STDOUT:     'inst+8':          template inst+11
// CHECK:STDOUT:     'inst+9':          template inst+11
// CHECK:STDOUT:     'inst+10':         template inst+10
// CHECK:STDOUT:     'inst+11':         template inst+11
// CHECK:STDOUT:     'inst+12':         template inst+11
// CHECK:STDOUT:   inst_blocks:
// CHECK:STDOUT:     empty:           {}
// CHECK:STDOUT:     exports:
// CHECK:STDOUT:       0:               inst+3
// CHECK:STDOUT:     import_refs:
// CHECK:STDOUT:       0:               inst+8
// CHECK:STDOUT:     global_init:     {}
// CHECK:STDOUT:     block4:
// CHECK:STDOUT:       0:               inst+7
// CHECK:STDOUT:       1:               inst+12
// CHECK:STDOUT:       2:               inst+13
// CHECK:STDOUT:       3:               inst+14
// CHECK:STDOUT:     block5:          {}
// CHECK:STDOUT:     block6:
// CHECK:STDOUT:       0:               inst+0
// CHECK:STDOUT:       1:               inst+1
// CHECK:STDOUT:       2:               inst+2
// CHECK:STDOUT:       3:               inst+3
// CHECK:STDOUT: ...
