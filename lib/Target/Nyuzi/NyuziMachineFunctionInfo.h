//===- NyuziMachineFunctionInfo.h - Nyuzi Machine Function Info -*-
//C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file declares  Nyuzi specific per-machine-function information.
//
//===----------------------------------------------------------------------===//
#ifndef NYUZIMACHINEFUNCTIONINFO_H
#define NYUZIMACHINEFUNCTIONINFO_H

#include "llvm/CodeGen/MachineFunction.h"

namespace llvm {

class NyuziMachineFunctionInfo : public MachineFunctionInfo {
public:
  NyuziMachineFunctionInfo() : SRetReturnReg(0) {}

  explicit NyuziMachineFunctionInfo(MachineFunction &MF)
      : SRetReturnReg(0) {}

  unsigned getSRetReturnReg() const { return SRetReturnReg; }
  void setSRetReturnReg(unsigned Reg) { SRetReturnReg = Reg; }
  int getVarArgsFrameIndex() const { return VarArgsFrameIndex; }
  void setVarArgsFrameIndex(int Index) { VarArgsFrameIndex = Index; }

private:
  virtual void anchor();

  /// SRetReturnReg - Holds the virtual register into which the sret
  /// argument is passed.
  unsigned SRetReturnReg;
  int VarArgsFrameIndex;
};
}

#endif
