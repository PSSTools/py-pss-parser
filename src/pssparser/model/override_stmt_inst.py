
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

'''
Created on Apr 20, 2020

@author: ballance
'''
from pssparser.model.expr_hierarchical_id import ExprHierarchicalId
from pssparser.model.type_identifier import TypeIdentifier

class OverrideStmtInst(object):
    
    def __init__(self,
                 target : ExprHierarchicalId,
                 override : TypeIdentifier):
        self.target = target
        self.override = override
        
    def accept(self, v):
        v.visit_override_stmt_inst(self)