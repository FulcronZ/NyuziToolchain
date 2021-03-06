//===-- NyuziInstrFormats.td - Target Description for Nyuzi Target -----------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file describes the Nyuzi instructions in TableGen format.
//
//===----------------------------------------------------------------------===//

//////////////////////////////////////////////////////////////////
// Node types
//////////////////////////////////////////////////////////////////

def simm13  : PatLeaf<(imm), [{ return isInt<13>(N->getSExtValue()); }]>;
def simm8  : PatLeaf<(imm), [{ return isInt<8>(N->getSExtValue()); }]>;

// A splat is a vector with the same value in all lanes. NyuziTargetLowering 
// detects this condition and converts it to a SPLAT node.
// Many instructions for this architecture can mix scalar and vector operands.  
// This pattern allows us to detect that case and match it explicitly. 
def splat : SDNode<"NyuziISD::SPLAT", SDTypeProfile<1, 1, [SDTCisEltOfVec<1, 0>]>>;
def wrapper : SDNode<"NyuziISD::WRAPPER", SDTIntUnaryOp>;
def reciprocal : SDNode<"NyuziISD::RECIPROCAL_EST", SDTFPUnaryOp>;
def jtwrapper : SDNode<"NyuziISD::JT_WRAPPER", SDTIntUnaryOp>;

def SDT_BRJT    : SDTypeProfile<0, 2, [SDTCisPtrTy<0>, SDTCisVT<1, i32>]>;
def brjt : SDNode<"NyuziISD::BR_JT", SDT_BRJT, [SDNPHasChain]>;

def return : SDNode<"NyuziISD::RET_FLAG", 
	SDTypeProfile<0, 0, []>,
    [SDNPHasChain, SDNPOptInGlue, SDNPVariadic]>;

// selcondresult is (dest, predicate, trueval, falseval)
def selcondresult : SDNode<"NyuziISD::SEL_COND_RESULT", SDTypeProfile<1, 3, [  
	SDTCisSameAs<0, 2>, SDTCisSameAs<0, 3>]>>;

def ADDRri : ComplexPattern<iPTR, 2, "SelectADDRri", [frameindex], []>;
def VADDRri : ComplexPattern<v16i32, 2, "SelectADDRri", [], []>;

def MemAsmOperand : AsmOperandClass {
  let Name = "Mem";
  let ParserMethod = "ParseMemoryOperand";
}

def MEMri : Operand<iPTR> {
	let PrintMethod = "printMemOperand";
	let EncoderMethod = "encodeMemoryOpValue";
	let DecoderMethod = "decodeScalarMemoryOpValue";
	let ParserMatchClass = MemAsmOperand;
	let MIOperandInfo = (ops GPR32, i32imm);
}

def VMEMri : Operand<v16i32> {
	let PrintMethod = "printMemOperand";
	let EncoderMethod = "encodeMemoryOpValue";
	let DecoderMethod = "decodeVectorMemoryOpValue";
	let ParserMatchClass = MemAsmOperand;
	let MIOperandInfo = (ops VR512, i32imm);
}

def LEAri : Operand<iPTR> {
	let PrintMethod = "printMemOperand";
	let EncoderMethod = "encodeLEAValue";
	let ParserMatchClass = MemAsmOperand;
	let MIOperandInfo = (ops GPR32, i32imm);
}

def JTADDR : Operand<iPTR> {
	let EncoderMethod = "encodeJumpTableAddr";
	let PrintMethod = "printJumpTableOperand";
}

def cpooladdr : Operand<iPTR> {
	let PrintMethod = "printMemOperand";
	let EncoderMethod = "encodeMemoryOpValue";
}

def brtarget : Operand<OtherVT> 
{
	let EncoderMethod = "encodeBranchTargetOpValue";
	let DecoderMethod = "decodeBranchTargetOpValue";
}

def calltarget : Operand<iPTR>
{
	let EncoderMethod = "encodeBranchTargetOpValue";
	let DecoderMethod = "decodeBranchTargetOpValue";
}

def SIMM13OP : Operand<i32> {
  let DecoderMethod = "decodeSimm13Value";
}

def SIMM8OP : Operand<i32> {
  let DecoderMethod = "decodeSimm8Value";
}

def SDT_SPCallSeqStart : SDCallSeqStart<[ SDTCisVT<0, i32> ]>;
def SDT_SPCallSeqEnd   : SDCallSeqEnd<[ SDTCisVT<0, i32>, SDTCisVT<1, i32> ]>;
def callseq_start : SDNode<"ISD::CALLSEQ_START", SDT_SPCallSeqStart,
                           [SDNPHasChain, SDNPSideEffect, SDNPOutGlue]>;
def callseq_end   : SDNode<"ISD::CALLSEQ_END",   SDT_SPCallSeqEnd,
                           [SDNPHasChain, SDNPSideEffect, SDNPOptInGlue, SDNPOutGlue]>;
def SDT_SPCall : SDTypeProfile<0, -1, [SDTCisVT<0, i32>]>;
def call       : SDNode<"NyuziISD::CALL", SDT_SPCall,
                           [SDNPHasChain, SDNPOptInGlue, SDNPOutGlue,
                            SDNPVariadic]>;

//////////////////////////////////////////////////////////////////
// Instruction Classes
//////////////////////////////////////////////////////////////////

class NyuziInstruction<dag outputs, dag inputs, string asmString, list<dag> pattern>
	: Instruction 
{
	let Namespace = "Nyuzi";
	dag OutOperandList = outputs;
	dag InOperandList = inputs;
	let AsmString = asmString;
	let Pattern = pattern;
	let Size = 4;

	field bits<32> Inst;
	field bits<32> SoftFail = 0;	// needed for disassembler
}

class Pseudo<dag outputs, dag inputs, list<dag> pattern>
	: NyuziInstruction<outputs, inputs, "Pseudo", pattern>
{
	let isCodeGenOnly = 1;
	let isPseudo = 1;
	let Inst{31-0} = 0;
}

multiclass AtomicBinary<SDNode OpNode>
{
	def R : Pseudo<
		(outs GPR32:$dest),
		(ins GPR32:$ptr, GPR32:$amt),
		[(set i32:$dest, (OpNode GPR32:$ptr, GPR32:$amt))]>;

	def I : Pseudo<
		(outs GPR32:$dest),
		(ins GPR32:$ptr, SIMM13OP:$amt),
		[(set i32:$dest, (OpNode GPR32:$ptr, simm13:$amt))]>;
}

//////////////////////////////////////////////////////////////////
// Format R: Register arithmetic
//////////////////////////////////////////////////////////////////

class FmtR<bits<3> val> {
	bits<3> Value = val;
}

def FmtR_SSS : FmtR<0>;
def FmtR_VVS : FmtR<1>;
def FmtR_VVSM : FmtR<2>;
def FmtR_VVV : FmtR<4>;
def FmtR_VVVM : FmtR<5>;

class FormatRInst<dag outputs, dag inputs, string asmString, list<dag> pattern,
	bits<6> opcode, FmtR fmt> 
	: NyuziInstruction<outputs, inputs, asmString, pattern>
{
	bits <5> dest;
	bits <5> src2;

	let Inst{31-29} = 6;
	let Inst{28-26} = fmt.Value;
	let Inst{25-20} = opcode;
	let Inst{19-15} = src2;
	let Inst{9-5} = dest;
}

class FormatRUnmaskedOneOpInst<dag outputs, dag inputs, string asmString, list<dag> pattern,
	bits<6> opcode, FmtR fmt> 
	: FormatRInst<outputs, inputs, asmString, pattern, opcode, fmt>
{
	let Inst{4-0} = 0;
}

class FormatRMaskedOneOpInst<dag outputs, dag inputs, string asmString, list<dag> pattern,
	bits<6> opcode, FmtR fmt> 
	: FormatRInst<outputs, inputs, asmString, pattern, opcode, fmt>
{
	bits <5> mask;
	let Inst{14-10} = mask;
	let Inst{4-0} = 0;
}

class FormatRUnmaskedTwoOpInst<dag outputs, dag inputs, string asmString, list<dag> pattern,
	bits<6> opcode, FmtR fmt> 
	: FormatRInst<outputs, inputs, asmString, pattern, opcode, fmt>
{
	bits <5> src1;
	let Inst{4-0} = src1;
}

class FormatRMaskedTwoOpInst<dag outputs, dag inputs, string asmString, list<dag> pattern,
	bits<6> opcode, FmtR fmt> 
	: FormatRInst<outputs, inputs, asmString, pattern, opcode, fmt>
{
	bits <5> src1;
	bits <5> mask;
	let Inst{14-10} = mask;
	let Inst{4-0} = src1;
}

//////////////////////////////////////////////////////////////////
// Format I: Immediate Arithmetic
//////////////////////////////////////////////////////////////////

class FmtI<bits<3> val> {
	bits<3> Value = val;
}

def FmtI_SS : FmtI<0>;
def FmtI_VV : FmtI<1>;
def FmtI_VVM : FmtI<2>;
def FmtI_VS : FmtI<4>;
def FmtI_VSM : FmtI<5>;

class FormatIInst<dag outputs, dag inputs, string asmString, list<dag> pattern,
	bits<5> opcode, FmtI fmt>  
	: NyuziInstruction<outputs, inputs, asmString, pattern> 
{
	bits <5> dest;
	bits <5> src1;

	let Inst{31} = 0;
	let Inst{30-28} = fmt.Value;
	let Inst{27-23} = opcode;
	let Inst{9-5} = dest;
	let Inst{4-0} = src1;
}

class FormatIMaskedInst<dag outputs, dag inputs, string asmString, list<dag> pattern,
	bits<5> opcode, FmtI fmt> 
	: FormatIInst<outputs, inputs, asmString, pattern, opcode, fmt> 
{
	bits <5> mask;
	bits <8> imm;
	let Inst{22-15} = imm;
	let Inst{14-10} = mask;
}

class FormatIUnmaskedInst<dag outputs, dag inputs, string asmString, list<dag> pattern,
	bits<5> opcode, FmtI fmt> 
	: FormatIInst<outputs, inputs, asmString, pattern, opcode, fmt> 
{
	bits <13> imm;
	let Inst{22-10} = imm;
}

multiclass TwoOpIntArith<string operator, SDNode OpNode, bits<6> opcode> {
	// Format R
	// Scalar = Scalar Op Scalar
	def SSS : FormatRUnmaskedTwoOpInst<
		(outs GPR32:$dest), 
		(ins GPR32:$src1, GPR32:$src2),
		operator # " $dest, $src1, $src2",
		[(set i32:$dest, (OpNode i32:$src1, i32:$src2))],
		opcode,
		FmtR_SSS>;
		
	// Vector = Vector Op Vector
	def VVV : FormatRUnmaskedTwoOpInst<
		(outs VR512:$dest), 
		(ins VR512:$src1, VR512:$src2),
		operator # " $dest, $src1, $src2",
		[(set v16i32:$dest, (OpNode v16i32:$src1, v16i32:$src2))],
		opcode,
		FmtR_VVV>;

	// Vector = Vector Op Scalar
	def VVS : FormatRUnmaskedTwoOpInst<
		(outs VR512:$dest), 
		(ins VR512:$src1, GPR32:$src2),
		operator # " $dest, $src1, $src2",
		[(set v16i32:$dest, (OpNode v16i32:$src1, (splat i32:$src2)))],
		opcode,
		FmtR_VVS>;

	let Constraints = "$dest = $oldvalue" in {
		// Vector = Vector op Vector, masked
		def VVVM : FormatRMaskedTwoOpInst<
			(outs VR512:$dest),
			(ins GPR32:$mask, VR512:$src1, VR512:$src2, VR512:$oldvalue),
			operator # "_mask $dest, $mask, $src1, $src2",
			[(set v16i32:$dest, (int_nyuzi_vector_mixi i32:$mask, (OpNode v16i32:$src1, v16i32:$src2), v16i32:$oldvalue))],
			opcode,
			FmtR_VVVM>;

		// Vector = Vector Op Scalar, masked
		def VVSM : FormatRMaskedTwoOpInst<
			(outs VR512:$dest),
			(ins GPR32:$mask, VR512:$src1, GPR32:$src2, VR512:$oldvalue),
			operator # "_mask $dest, $mask, $src1, $src2",
			[(set v16i32:$dest, (int_nyuzi_vector_mixi i32:$mask, (OpNode v16i32:$src1, (splat i32:$src2)), v16i32:$oldvalue))],
			opcode,
			FmtR_VVSM>;
	}

	// Format I
	// Scalar = Scalar Op Immediate
	def SSI : FormatIUnmaskedInst<
		(outs GPR32:$dest), 
		(ins GPR32:$src1, SIMM13OP:$imm),
		operator # " $dest, $src1, $imm",
		[(set i32:$dest, (OpNode i32:$src1, (i32 simm13:$imm)))],
		opcode{4-0},
		FmtI_SS>;
	
	// Vector = Vector Op Immediate
	def VVI : FormatIUnmaskedInst<
		(outs VR512:$dest), 
		(ins VR512:$src1, SIMM13OP:$imm),
		operator # " $dest, $src1, $imm",
		[(set v16i32:$dest, (OpNode v16i32:$src1, (splat simm13:$imm)))],
		opcode{4-0},
		FmtI_VV>;

	// Vector = Scalar Op Immediate
	def VSI : FormatIUnmaskedInst<
		(outs VR512:$dest), 
		(ins GPR32:$src1, SIMM13OP:$imm),
		operator # " $dest, $src1, $imm",
		[(set v16i32:$dest, (OpNode (splat i32:$src1), (splat simm13:$imm)))],
		opcode{4-0},
		FmtI_VS>;

	let Constraints = "$dest = $oldvalue" in {
		// Vector = Vector Op Immediate, masked
		def VVIM : FormatIMaskedInst<
			(outs VR512:$dest),
			(ins GPR32:$mask, VR512:$src1, SIMM8OP:$imm, VR512:$oldvalue),
			operator # "_mask $dest, $mask, $src1, $imm",
			[(set v16i32:$dest, (int_nyuzi_vector_mixi i32:$mask, (OpNode v16i32:$src1, (splat simm8:$imm)), v16i32:$oldvalue))],
			opcode{4-0},
			FmtI_VVM>;

		// Vector = Scalar Op Immediate, masked
		def VSIM : FormatIMaskedInst<
			(outs VR512:$dest),
			(ins GPR32:$mask, GPR32:$src1, SIMM8OP:$imm, VR512:$oldvalue),
			operator # "_mask $dest, $mask, $src1, $imm",
			[(set v16i32:$dest, (int_nyuzi_vector_mixi i32:$mask, (OpNode (splat i32:$src1), (splat simm8:$imm)), v16i32:$oldvalue))],
			opcode{4-0},
			FmtI_VSM>;
	}
}

multiclass TwoOpFloatArith<string operator, SDNode OpNode, bits<6> opcode> 
{
	// Scalar = Scalar Op Scalar
	def SSS : FormatRUnmaskedTwoOpInst<
		(outs GPR32:$dest), 
		(ins GPR32:$src1, GPR32:$src2),
		operator # " $dest, $src1, $src2",
		[(set GPR32:$dest, (OpNode f32:$src1, f32:$src2))],
		opcode,
		FmtR_SSS>;

	// Vector = Vector Op Vector
	def VVV : FormatRUnmaskedTwoOpInst<
		(outs VR512:$dest), 
		(ins VR512:$src1, VR512:$src2),
		operator # " $dest, $src1, $src2",
		[(set VR512:$dest, (OpNode v16f32:$src1, v16f32:$src2))],
		opcode,
		FmtR_VVV>;

	// Vector = Vector Op Scalar
	def VVS : FormatRUnmaskedTwoOpInst<
		(outs VR512:$dest), 
		(ins VR512:$src1, GPR32:$src2),
		operator # " $dest, $src1, $src2",
		[(set VR512:$dest, (OpNode v16f32:$src1, (splat f32:$src2)))],
		opcode,
		FmtR_VVS>;

	// Predicated
	let Constraints = "$dest = $oldvalue" in {
		// Vector = Vector Op Vector, masked
		def VVVM : FormatRMaskedTwoOpInst<
			(outs VR512:$dest),
			(ins GPR32:$mask, VR512:$src1, VR512:$src2, VR512:$oldvalue),
			operator # "_mask $dest, $mask, $src1, $src2",
			[(set VR512:$dest, (int_nyuzi_vector_mixf i32:$mask, (OpNode v16f32:$src1, 
				v16f32:$src2), v16f32:$oldvalue))],
			opcode,
			FmtR_VVVM>;
		
		// Vector = Vector Op Scalar, masked
		def VVSM : FormatRMaskedTwoOpInst<
			(outs VR512:$dest),
			(ins GPR32:$mask, VR512:$src1, GPR32:$src2, VR512:$oldvalue),
			operator # "_mask $dest, $mask, $src1, $src2",
			[(set v16f32:$dest, (int_nyuzi_vector_mixf i32:$mask, (OpNode v16f32:$src1, 
				(splat f32:$src2)), v16f32:$oldvalue))],
			opcode,
			FmtR_VVSM>;
	}
}

multiclass OneOpIntArith<string operator, SDNode OpNode, bits<6> opcode> {
	def SS : FormatRUnmaskedOneOpInst<
		(outs GPR32:$dest), 
		(ins GPR32:$src2),
		operator # " $dest, $src2",
		[(set i32:$dest, (OpNode i32:$src2))],
		opcode,
		FmtR_SSS>;

	def VS : FormatRUnmaskedOneOpInst<
		(outs VR512:$dest), 
		(ins GPR32:$src2),
		operator # " $dest, $src2",
		[(set v16i32:$dest, (OpNode (splat i32:$src2)))],
		opcode,
		FmtR_VVS>;

	def VV : FormatRUnmaskedOneOpInst<
		(outs VR512:$dest), 
		(ins VR512:$src2),
		operator # " $dest, $src2",
		[(set v16i32:$dest, (OpNode v16i32:$src2))],
		opcode,
		FmtR_VVV>;

	// Predicated
	let Constraints = "$dest = $oldvalue" in {
		def VVM : FormatRMaskedOneOpInst<
			(outs VR512:$dest),
			(ins GPR32:$mask, VR512:$src2, VR512:$oldvalue),
			operator # "_mask $dest, $mask, $src2",
			[(set v16i32:$dest, (int_nyuzi_vector_mixi i32:$mask, (OpNode v16i32:$src2), 
				v16i32:$oldvalue))],
			opcode,
			FmtR_VVVM>;

		def VSM : FormatRMaskedOneOpInst<
			(outs VR512:$dest),
			(ins GPR32:$mask, GPR32:$src2, VR512:$oldvalue),
			operator # "_mask $dest, $mask, $src2",
			[(set v16i32:$dest, (int_nyuzi_vector_mixi i32:$mask, (OpNode (splat i32:$src2)), 
				v16i32:$oldvalue))],
			opcode,
			FmtR_VVSM>;
	}
}

multiclass OneOpFloatArith<string operator, SDNode OpNode, bits<6> opcode> {
	def SS : FormatRUnmaskedOneOpInst<
		(outs GPR32:$dest), 
		(ins GPR32:$src2),
		operator # " $dest, $src2",
		[(set f32:$dest, (OpNode f32:$src2))],
		opcode,
		FmtR_SSS>;

	def VS : FormatRUnmaskedOneOpInst<
		(outs VR512:$dest), 
		(ins GPR32:$src2),
		operator # " $dest, $src2",
		[(set v16f32:$dest, (OpNode (splat f32:$src2)))],
		opcode,
		FmtR_VVS>;

	def VV : FormatRUnmaskedOneOpInst<
		(outs VR512:$dest), 
		(ins VR512:$src2),
		operator # " $dest, $src2",
		[(set v16f32:$dest, (OpNode v16f32:$src2))],
		opcode,
		FmtR_VVV>;

	// Predicated
	let Constraints = "$dest = $oldvalue" in {
		def VVM : FormatRMaskedOneOpInst<
			(outs VR512:$dest),
			(ins GPR32:$mask, VR512:$src2, VR512:$oldvalue),
			operator # "_mask $dest, $mask, $src2",
			[(set v16f32:$dest, (int_nyuzi_vector_mixf i32:$mask, (OpNode v16f32:$src2), 
				v16f32:$oldvalue))],
			opcode,
			FmtR_VVVM>;

		def VSM : FormatRMaskedOneOpInst<
			(outs VR512:$dest),
			(ins GPR32:$mask, GPR32:$src2, VR512:$oldvalue),
			operator # "_mask $dest, $mask, $src2",
			[(set v16f32:$dest, (int_nyuzi_vector_mixf i32:$mask, (OpNode (splat f32:$src2)), 
				v16f32:$oldvalue))],
			opcode,
			FmtR_VVSM>;
	}
}

multiclass IntCompareInst<string operator, CondCode condition, 
	bits<6> opcode, Intrinsic vectorIntr> {
	// Instruction format A, integer
	def SS : FormatRUnmaskedTwoOpInst<
		(outs GPR32:$dest), 
		(ins GPR32:$src1, GPR32:$src2),
		operator # " $dest, $src1, $src2",
		[(set i32:$dest, (setcc i32:$src1, i32:$src2, condition))],
		opcode,
		FmtR_SSS>;

	def VV : FormatRUnmaskedTwoOpInst<
		(outs GPR32:$dest), 
		(ins VR512:$src1, VR512:$src2),
		operator # " $dest, $src1, $src2",
		[(set i32:$dest, (vectorIntr v16i32:$src1, v16i32:$src2))],
		opcode,
		FmtR_VVV>;

	def VS : FormatRUnmaskedTwoOpInst<
		(outs GPR32:$dest), 
		(ins VR512:$src1, GPR32:$src2),
		operator # " $dest, $src1, $src2",
		[(set i32:$dest, (vectorIntr v16i32:$src1, (splat i32:$src2)))],
		opcode,
		FmtR_VVS>;

	// Instruction format B
	def SI : FormatIUnmaskedInst<
		(outs GPR32:$dest), 
		(ins GPR32:$src1, SIMM13OP:$imm),
		operator # " $dest, $src1, $imm",
		[(set i32:$dest, (setcc i32:$src1, simm13:$imm, condition))],
		opcode{4-0},
		FmtI_SS>;

	def VI : FormatIUnmaskedInst<
		(outs GPR32:$dest), 
		(ins VR512:$src1, SIMM13OP:$imm),
		operator # " $dest, $src1, $imm",
		[(set i32:$dest, (vectorIntr v16i32:$src1, (splat simm13:$imm)))],
		opcode{4-0},
		FmtI_VV>;
}

multiclass FloatCompareInst<string operator, CondCode condition, bits<6> opcode,
	Intrinsic vectorIntr> {
	def SS : FormatRUnmaskedTwoOpInst<
		(outs GPR32:$dest),
		(ins GPR32:$src1, GPR32:$src2),
		operator # "_f $dest, $src1, $src2",
		[(set i32:$dest, (setcc f32:$src1, f32:$src2, condition))],
		opcode,
		FmtR_SSS>;

	def VV : FormatRUnmaskedTwoOpInst<
		(outs GPR32:$dest),
		(ins VR512:$src1, VR512:$src2),
		operator # "_f $dest, $src1, $src2",
		[(set i32:$dest, (vectorIntr v16f32:$src1, v16f32:$src2))],
		opcode,
		FmtR_VVV>;

	def VS : FormatRUnmaskedTwoOpInst<
		(outs GPR32:$dest),
		(ins VR512:$src1, GPR32:$src2),
		operator # "_f $dest, $src1, $src2",
		[(set i32:$dest, (vectorIntr v16f32:$src1, (splat f32:$src2)))],
		opcode,
		FmtR_VVS>;
}

//////////////////////////////////////////////////////////////////
// Format M: Memory instructions
//////////////////////////////////////////////////////////////////

class FmtM<bits<4> val> {
	bits<4> Value = val;
}

def FmtM_Byte_Unsigned : FmtM<0>;
def FmtM_Byte_Signed : FmtM<1>;
def FmtM_Short_Unsigned : FmtM<2>;
def FmtM_Short_Signed : FmtM<3>;
def FmtM_Word : FmtM<4>;
def FmtM_Sync : FmtM<5>;
def FmtM_ControlReg : FmtM<6>;
def FmtM_Block : FmtM<7>;
def FmtM_BlockMasked : FmtM<8>;
def FmtM_ScGath : FmtM<13>;
def FmtM_ScGathMasked : FmtM<14>;

class FormatMInst<dag outputs, dag inputs, string asmString, list<dag> pattern,
	FmtM fmt, bits <1> isLoad>  
	: NyuziInstruction<outputs, inputs, asmString, pattern> 
{
	bits <5> srcDest;

	let Inst{31} = 1;
	let Inst{29} = isLoad;
	let Inst{28-25} = fmt.Value;
	let Inst{9-5} = srcDest;
	
	// XXX set hasSideEffects = 1, mayStore = 1 is !isLoad?
}

class FormatMMaskedInst<dag outputs, dag inputs, string asmString, list<dag> pattern,
	FmtM fmt, bits <1> isLoad> 
	: FormatMInst<outputs, inputs, asmString, pattern, fmt, isLoad> 
{
	bits <20> addr;	// Is offset/ptr, this is set up by encodeMemoryOpValue.
	bits <5> mask;

	let Inst{24-15} = addr{14-5};
	let Inst{14-10} = mask;
	let Inst{4-0} = addr{4-0};
}

class FormatMUnmaskedInst<dag outputs, dag inputs, string asmString, list<dag> pattern,
	FmtM fmt, bits <1> isLoad> 
	: FormatMInst<outputs, inputs, asmString, pattern, fmt, isLoad> 
{
	bits <20> addr;	// Is offset/ptr, this is set up by encodeMemoryOpValue.

	let Inst{24-10} = addr{19-5};
	let Inst{4-0} = addr{4-0};
}

class ScalarLoadInst<string suffix, PatFrag op, FmtM fmt>
	: FormatMUnmaskedInst<
		(outs GPR32:$srcDest),
		(ins MEMri:$addr),
		"load_" # suffix # " $srcDest, $addr",
		[(set i32:$srcDest, (i32 (op ADDRri:$addr)))], 
		fmt,
		1>;

class ScalarStoreInst<string suffix, PatFrag op, FmtM fmt>  
	: FormatMUnmaskedInst<
			(outs),
			(ins GPR32:$srcDest, MEMri:$addr),
			"store_" # suffix # " $srcDest, $addr",
			[(op i32:$srcDest, ADDRri:$addr)],
			fmt, 
			0>
{
	let hasSideEffects = 1;
	let mayStore = 1;
}


//////////////////////////////////////////////////////////////////
// Format C (cache control)
//////////////////////////////////////////////////////////////////

class FmtC<bits<3> val> {
	bits<3> Value = val;
}

def FmtC_DInvalidate : FmtC<1>;
def FmtC_DFlush : FmtC<2>;
def FmtC_IInvalidate : FmtC<3>;
def FmtC_MemBar : FmtC<4>;

class FormatCInst<dag outputs, dag inputs, string asmString, list<dag> pattern,
	FmtC fmt> 
	: NyuziInstruction<outputs, inputs, asmString, pattern>
{
	let Inst{31-28} = 0xe;
	let Inst{27-25} = fmt.Value;
}

// XXX Haven't implemented adding an offset
class FormatCOneOp<dag outputs, dag inputs, string asmString, list<dag> pattern,
	FmtC fmt> 
	: FormatCInst<outputs, inputs, asmString, pattern, fmt>
{
	bits<5> ptr;

	let Inst{4-0} = ptr;
}

//////////////////////////////////////////////////////////////////
// Format B: Branch Instruction
//////////////////////////////////////////////////////////////////

class BranchType<bits<3> val> {
	bits<3> Value = val;
}

def BT_All : BranchType<0>;
def BT_IfFalse : BranchType<1>;
def BT_IfTrue : BranchType<2>;
def BT_Uncond : BranchType<3>;
def BT_Call : BranchType<4>;
def BT_NAll : BranchType<5>;
def BT_CallReg : BranchType<6>;
def BT_Eret : BranchType<7>;

class BranchInst<dag outputs, dag inputs, string asmString, list<dag> pattern,
	BranchType type>
	: NyuziInstruction<outputs, inputs, asmString, pattern>
{
	let isBranch = 1;

	bits<20> dest;

	let Inst{31-28} = 0xf;
	let Inst{27-25} = type.Value;
	let Inst{24-5} = dest;
}

class ConditionalBranchInst<dag outputs, dag inputs, string asmString, list<dag> pattern,
	BranchType type>
	: BranchInst<outputs, inputs, asmString, pattern, type>
{
	bits<5> test;

	let Inst{4-0} = test;
}

class UnconditionalBranchInst<dag outputs, dag inputs, string asmString, list<dag> pattern,
	BranchType type>
	: BranchInst<outputs, inputs, asmString, pattern, type>
{
}
