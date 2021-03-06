/****************************************************************************
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 ****************************************************************************/

grammar Expressions;

constant_expression: expression;


expression:
	unary_op lhs=expression								|
	lhs=expression exp_op rhs=expression 				|
	lhs=expression mul_div_mod_op rhs=expression 		|
	lhs=expression add_sub_op rhs=expression			|
	lhs=expression shift_op rhs=expression				|
	lhs=expression inside_expr_term						|
    lhs=expression logical_inequality_op rhs=expression	|
    lhs=expression eq_neq_op rhs=expression				|
    lhs=expression binary_and_op rhs=expression			|
    lhs=expression binary_xor_op rhs=expression			|
    lhs=expression binary_or_op rhs=expression			|
    lhs=expression logical_and_op rhs=expression		|
    lhs=expression logical_or_op rhs=expression			|
    lhs=expression conditional_expr						|
	primary
	;

conditional_expr :
	'?' true_expr=expression ':' false_expr=expression
	; 

logical_or_op : '||';
logical_and_op : '&&';
binary_or_op : '|';
binary_xor_op : '^';
binary_and_op : '&';

inside_expr_term :
	'in' '[' open_range_list ']'
;

open_range_list:
	open_range_value (',' open_range_value)*
;

open_range_value:
	lhs=expression ('..' rhs=expression)?
;

logical_inequality_op:
	'<'|'<='|'>'|'>='
;

unary_op: '+' | '-' | '!' | '~' | '&' | '|' | '^';

exp_op: '**';


primary: 
	number 					
	| bool_literal			
	| paren_expr
	| string
	| variable_ref_path
	| method_function_symbol_call
	| static_ref_path
	| is_super='super' '.' variable_ref_path
	| compile_has_expr
	| cast_expression // TODO: File Jama issue
	;
	
paren_expr:
	'(' expression ')'
;

// TODO: casting_type is undefined
cast_expression:
	'(' casting_type ')' expression
	;
	
casting_type:
	data_type
	;
	
variable_ref_path:
	hierarchical_id ('[' expression (':' expression)? ']')?
;

method_function_symbol_call:
	method_call
	| function_symbol_call
	;

// TODO: trailing ';' is incorrect
method_call:
	hierarchical_id method_parameter_list /*';'*/
	;

// TODO: trailing ';' is incorrect
function_symbol_call:
	function_symbol_id method_parameter_list /*';'*/
	;
	
function_symbol_id:
	function_id
	| symbol_identifier
	;

function_id:
	identifier ('::' identifier)*
	;	


static_ref_path:
	is_global='::'? static_ref_path_elem ('::' static_ref_path_elem)*
	;
	
static_ref_path_elem: 
	identifier template_param_value_list?
	;

mul_div_mod_op: '*' | '/' | '%';

add_sub_op: '+' | '-';

// Note: Implementation difference vs spec
// shift_op: '<<' | '>>';
shift_op: '<<' | '>' '>';

eq_neq_op: '==' | '!=';





