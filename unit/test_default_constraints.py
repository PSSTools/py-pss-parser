'''
Created on Mar 3, 2020

@author: ballance
'''

from unittest import TestCase
from antlr4.InputStream import InputStream
from pssparser.cu_parser import CUParser
from _io import StringIO

class TestDefaultConstraint(TestCase):

    def _runTest(self, text, name):
        input_stream = InputStream(text)
        parser = CUParser(input_stream, name)
        cu = parser.parse()
        
        if len(cu.markers) > 0:
            print("Test Failed:")
            in_reader = StringIO(text)
            i=1
            while True:
                line = in_reader.readline()
                if line == "":
                    break
                line = line[:-1]
                print("%3d: %s" % (i, line))
                i+=1
        
        self.assertEqual(len(cu.markers), 0, "Errors")    
    
    def test_example_1(self):
        text = """
        struct my_struct {
          rand int in [0..3] attr1;
          constraint default attr1 == 0; // (1)
  
          rand int in [0..3] attr2;
          constraint attr1 < attr2; // (2)
        };
        
        //<example>
        component container {
        //</example>

        action my_action {
          rand my_struct s1;
  
          rand my_struct s2;
          constraint default s2.attr1 == 2; // (3)
  
          rand my_struct s3;
          constraint default disable s3.attr1; // (4)
          constraint s3.attr1 > 0; // (5)
        };

        //<example>
        }
        //</example>
        """

        self._runTest(text, "test_example_1")