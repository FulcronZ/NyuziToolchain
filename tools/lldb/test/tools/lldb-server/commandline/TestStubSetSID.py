import unittest2

import gdbremote_testcase
import lldbgdbserverutils
import os
import select
import tempfile
import time
from lldbtest import *

class TestStubSetSIDTestCase(gdbremote_testcase.GdbRemoteTestCaseBase):
    def get_stub_sid(self, extra_stub_args=None):
        # Launch debugserver
        if extra_stub_args:
            self.debug_monitor_extra_args += extra_stub_args

        server = self.launch_debug_monitor()
        self.assertIsNotNone(server)
        self.assertTrue(lldbgdbserverutils.process_is_running(server.pid, True))

        # Get the process id for the stub.
        return os.getsid(server.pid)

    def sid_is_same_without_setsid(self):
        stub_sid = self.get_stub_sid()
        self.assertEquals(stub_sid, os.getsid(0))

    def sid_is_different_with_setsid(self):
        stub_sid = self.get_stub_sid(["--setsid"])
        self.assertNotEquals(stub_sid, os.getsid(0))

    def sid_is_different_with_S(self):
        stub_sid = self.get_stub_sid(["-S"])
        self.assertNotEquals(stub_sid, os.getsid(0))

    @debugserver_test
    @skipIfRemote # --setsid not used on remote platform and currently it is also impossible to get the sid of lldb-platform running on a remote target
    @unittest2.expectedFailure() # This is the whole purpose of this feature, I would expect it to be the same without --setsid. Investigate.
    def test_sid_is_same_without_setsid_debugserver(self):
        self.init_debugserver_test()
        self.set_inferior_startup_launch()
        self.sid_is_same_without_setsid()

    @llgs_test
    @skipIfRemote # --setsid not used on remote platform and currently it is also impossible to get the sid of lldb-platform running on a remote target
    @unittest2.expectedFailure() # This is the whole purpose of this feature, I would expect it to be the same without --setsid. Investigate.
    def test_sid_is_same_without_setsid_llgs(self):
        self.init_llgs_test()
        self.set_inferior_startup_launch()
        self.sid_is_same_without_setsid()

    @debugserver_test
    @skipIfRemote # --setsid not used on remote platform and currently it is also impossible to get the sid of lldb-platform running on a remote target
    def test_sid_is_different_with_setsid_debugserver(self):
        self.init_debugserver_test()
        self.set_inferior_startup_launch()
        self.sid_is_different_with_setsid()

    @llgs_test
    @skipIfRemote # --setsid not used on remote platform and currently it is also impossible to get the sid of lldb-platform running on a remote target
    def test_sid_is_different_with_setsid_llgs(self):
        self.init_llgs_test()
        self.set_inferior_startup_launch()
        self.sid_is_different_with_setsid()

    @debugserver_test
    @skipIfRemote # --setsid not used on remote platform and currently it is also impossible to get the sid of lldb-platform running on a remote target
    def test_sid_is_different_with_S_debugserver(self):
        self.init_debugserver_test()
        self.set_inferior_startup_launch()
        self.sid_is_different_with_S()

    @llgs_test
    @skipIfRemote # --setsid not used on remote platform and currently it is also impossible to get the sid of lldb-platform running on a remote target
    def test_sid_is_different_with_S_llgs(self):
        self.init_llgs_test()
        self.set_inferior_startup_launch()
        self.sid_is_different_with_S()
