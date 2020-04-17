'''
Created on Apr 13, 2020

@author: ballance
'''
from typing import Tuple

from pssparser.model.composite_type import CompositeType
from pssparser.model.type_identifier import TypeIdentifier


class StructType(CompositeType):
    
    def __init__(self, name : Tuple[str], template_params, super_type : TypeIdentifier):
        super().__init__(name, template_params, super_type)
        
    def accept(self, v):
        v.visit_struct_type(self)


    