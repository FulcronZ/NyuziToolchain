"""
Test lldb-mi -gdb-set and -gdb-show commands.
"""

import lldbmi_testcase
from lldbtest import *
import unittest2

class MiGdbSetShowTestCase(lldbmi_testcase.MiTestCaseBase):

    mydir = TestBase.compute_mydir(__file__)

    @lldbmi_test
    @expectedFailureWindows("llvm.org/pr22274: need a pexpect replacement for windows")
    def test_lldbmi_gdb_set_target_async_default(self):
        """Test that 'lldb-mi --interpreter' switches to async mode by default."""

        self.spawnLldbMi(args = None)

        # Switch to sync mode
        self.runCmd("-gdb-set target-async off")
        self.expect("\^done")
        self.runCmd("-gdb-show target-async")
        self.expect("\^done,value=\"off\"")

        # Test that -gdb-set switches to async by default
        self.runCmd("-gdb-set target-async")
        self.expect("\^done")
        self.runCmd("-gdb-show target-async")
        self.expect("\^done,value=\"on\"")

    @lldbmi_test
    @expectedFailureWindows("llvm.org/pr22274: need a pexpect replacement for windows")
    def test_lldbmi_gdb_set_target_async_on(self):
        """Test that 'lldb-mi --interpreter' can execute commands in async mode."""

        self.spawnLldbMi(args = None)

        # Switch to sync mode
        self.runCmd("-gdb-set target-async off")
        self.expect("\^done")
        self.runCmd("-gdb-show target-async")
        self.expect("\^done,value=\"off\"")

        # Test that -gdb-set can switch to async mode
        self.runCmd("-gdb-set target-async on")
        self.expect("\^done")
        self.runCmd("-gdb-show target-async")
        self.expect("\^done,value=\"on\"")

        # Load executable
        self.runCmd("-file-exec-and-symbols %s" % self.myexe)
        self.expect("\^done")

        # Test that program is executed in async mode
        self.runCmd("-exec-run")
        self.expect("\*running")
        self.expect("~\"argc=1")

    @lldbmi_test
    @expectedFailureWindows("llvm.org/pr22274: need a pexpect replacement for windows")
    def test_lldbmi_gdb_set_target_async_off(self):
        """Test that 'lldb-mi --interpreter' can execute commands in sync mode."""

        self.spawnLldbMi(args = None)

        # Test that -gdb-set can switch to sync mode
        self.runCmd("-gdb-set target-async off")
        self.expect("\^done")
        self.runCmd("-gdb-show target-async")
        self.expect("\^done,value=\"off\"")

        # Load executable
        self.runCmd("-file-exec-and-symbols %s" % self.myexe)
        self.expect("\^done")

        # Test that program is executed in async mode
        self.runCmd("-exec-run")
        unexpected = [ "\*running" ] # "\*running" is async notification
        it = self.expect(unexpected + [ "~\"argc=1\\\\r\\\\n" ])
        if it < len(unexpected):
            # generate error if it's not "~\"argc=1\\\\r\\\\n"
            self.expect("$UNEXPECTED FOUND: %s.^" % unexpected[it], timeout = 0)

    @lldbmi_test
    @expectedFailureWindows("llvm.org/pr22274: need a pexpect replacement for windows")
    def test_lldbmi_gdb_show_target_async(self):
        """Test that 'lldb-mi --interpreter' in async mode by default."""

        self.spawnLldbMi(args = None)

        # Test that default target-async value is "on"
        self.runCmd("-gdb-show target-async")
        self.expect("\^done,value=\"on\"")

    @lldbmi_test
    @expectedFailureWindows("llvm.org/pr22274: need a pexpect replacement for windows")
    @unittest2.expectedFailure("-gdb-set ignores unknown properties")
    def test_lldbmi_gdb_set_unknown(self):
        """Test that 'lldb-mi --interpreter' fails when setting an unknown property."""

        self.spawnLldbMi(args = None)

        # Test that -gdb-set fails if property is unknown
        self.runCmd("-gdb-set unknown some_value")
        self.expect("\^error")

    @lldbmi_test
    @expectedFailureWindows("llvm.org/pr22274: need a pexpect replacement for windows")
    @unittest2.expectedFailure("-gdb-show ignores unknown properties")
    def test_lldbmi_gdb_show_unknown(self):
        """Test that 'lldb-mi --interpreter' fails when showing an unknown property."""

        self.spawnLldbMi(args = None)

        # Test that -gdb-show fails if property is unknown
        self.runCmd("-gdb-show unknown")
        self.expect("\^error")


    @lldbmi_test
    @expectedFailureWindows("llvm.org/pr22274: need a pexpect replacement for windows")
    @skipIfFreeBSD # llvm.org/pr22411: Failure presumably due to known thread races
    @skipIfLinux # llvm.org/pr22841: lldb-mi tests fail on all Linux buildbots
    def test_lldbmi_gdb_set_ouptut_radix(self):
        """Test that 'lldb-mi --interpreter' works for -gdb-set output-radix."""

        self.spawnLldbMi(args = None)

        # Load executable
        self.runCmd("-file-exec-and-symbols %s" % self.myexe)
        self.expect("\^done")

        # Run to BP_printf
        line = line_number('main.cpp', '// BP_printf')
        self.runCmd("-break-insert main.cpp:%d" % line)
        self.expect("\^done,bkpt={number=\"1\"")
        self.runCmd("-exec-run")
        self.expect("\^running");
        self.expect("\*stopped,reason=\"breakpoint-hit\"")

        # Setup variable
        self.runCmd("-var-create var_a * a");
        self.expect("\^done,name=\"var_a\",numchild=\"0\",value=\"10\",type=\"int\",thread-id=\"1\",has_more=\"0\"")

        # Test default output
        self.runCmd("-var-evaluate-expression var_a");
        self.expect("\^done,value=\"10\"");

        # Test hex output
        self.runCmd("-gdb-set output-radix 16");
        self.expect("\^done");
        self.runCmd("-var-evaluate-expression var_a");
        self.expect("\^done,value=\"0xa\"");

        # Test octal output
        self.runCmd("-gdb-set output-radix 8");
        self.expect("\^done");
        self.runCmd("-var-evaluate-expression var_a");
        self.expect("\^done,value=\"012\"");

        # Test decimal output
        self.runCmd("-gdb-set output-radix 10");
        self.expect("\^done");
        self.runCmd("-var-evaluate-expression var_a");
        self.expect("\^done,value=\"10\"");

if __name__ == '__main__':
    unittest2.main()
