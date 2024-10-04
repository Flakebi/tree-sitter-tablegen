================================================================================
trailing comma
================================================================================
def OMP_Tile : Directive<"tile"> {
  let allowedOnceClauses = [
    VersionedClause<OMPC_Sizes, 51>,
  ];
}
--------------------------------------------------------------------------------

(file
  (statement
    (def
      (value
        (identifier))
      (parent_class_list
        (identifier)
        (argument_list
          (value
            (string_string))))
      (record_body
        (body_item
          (let_inst
            (identifier)
            (value
              (value
                (identifier)
                (value
                  (identifier))
                (value
                  (number))))))))))

================================================================================
trailing comma in cond
================================================================================
class WMMA_REGS<string Geom, string Frag, string PtxEltType> {
  list<LLVMType> regs = !cond(
    !eq(gft,"m8n8k4:a:f16") : !listsplat(llvm_v2f16_ty, 2),
  );
}
--------------------------------------------------------------------------------

(file
  (statement
    (class
      (identifier)
      (template_args
        (template_arg
          (type)
          (identifier))
        (template_arg
          (type)
          (identifier))
        (template_arg
          (type)
          (identifier)))
      (record_body
        (body_item
          (instruction
            (type
              (type
                (identifier)))
            (identifier)
            (value
              (operator
                (value
                  (operator
                    (operator_keyword)
                    (value
                      (identifier))
                    (value
                      (string_string))))
                (value
                  (operator
                    (operator_keyword)
                    (value
                      (identifier))
                    (value
                      (number))))))))))))

================================================================================
multiclass generic base class
================================================================================
multiclass SystemZUnaryBHFG<string name> : SystemZUnaryBHF<name> {
  def g : SystemZUnary<name#"g", llvm_v2i64_ty>;
}
--------------------------------------------------------------------------------

(file
  (statement
    (multiclass
      (identifier)
      (template_args
        (template_arg
          (type)
          (identifier)))
      (parent_class_list
        (identifier)
        (argument_list
          (value
            (identifier))))
      (multiclass_body
        (multiclass_statement
          (def
            (value
              (identifier))
            (parent_class_list
              (identifier)
              (argument_list
                (value
                  (value
                    (identifier))
                  (value
                    (string_string)))
                (value
                  (identifier))))
            (record_body)))))))

================================================================================
field
================================================================================
class AArch64Inst<Format f, string cstr> : Instruction {
  field bits<32> Inst; // Instruction encoding.
}
--------------------------------------------------------------------------------

(file
  (statement
    (class
      (identifier)
      (template_args
        (template_arg
          (type
            (identifier))
          (identifier))
        (template_arg
          (type)
          (identifier)))
      (parent_class_list
        (identifier))
      (record_body
        (body_item
          (instruction
            (type
              (number))
            (identifier)))
        (comment)))))

================================================================================
empty multiclass body
================================================================================
multiclass FRIntNNT<bits<2> opcode, string asm, SDPatternOperator node = null_frag> :
      SingleOperandFPNo16<{0b0100,opcode}, asm, node>;
--------------------------------------------------------------------------------

(file
  (statement
    (multiclass
      (identifier)
      (template_args
        (template_arg
          (type
            (number))
          (identifier))
        (template_arg
          (type)
          (identifier))
        (template_arg
          (type
            (identifier))
          (identifier)
          (value
            (identifier))))
      (parent_class_list
        (identifier)
        (argument_list
          (value
            (value
              (number))
            (value
              (identifier)))
          (value
            (identifier))
          (value
            (identifier))))
      (multiclass_body))))

================================================================================
no dot in identifier
================================================================================
multiclass sve_int_dup_imm_pred_merge_inst {
  def : Pat<(SVE8BitLslImm<scalarty>.Pat i32:$imm)>;
}
--------------------------------------------------------------------------------

(file
  (statement
    (multiclass
      (identifier)
      (multiclass_body
        (multiclass_statement
          (def
            (parent_class_list
              (identifier)
              (argument_list
                (value
                  (dag_arg
                    (value
                      (identifier)
                      (value
                        (identifier))
                      (value_suffix
                        (identifier))))
                  (dag_arg
                    (value
                      (identifier))
                    (var)))))
            (record_body)))))))

================================================================================
value in range piece
================================================================================
class C {
  let Inst{14} = !if(ps.has_glc, cpol{CPolBit.GLC}, ps.glc_value);
}
--------------------------------------------------------------------------------

(file
  (statement
    (class
      (identifier)
      (record_body
        (body_item
          (let_inst
            (identifier)
            (value
              (number))
            (value
              (operator
                (operator_keyword)
                (value
                  (identifier)
                  (value_suffix
                    (identifier)))
                (value
                  (identifier)
                  (value_suffix
                    (value
                      (identifier)
                      (value_suffix
                        (identifier)))))
                (value
                  (identifier)
                  (value_suffix
                    (identifier)))))))))))

================================================================================
multiline comment
================================================================================
/********** ========================================= **********/
--------------------------------------------------------------------------------

(file
  (multiline_comment))

================================================================================
multiple multiline comments
================================================================================
/********** ================== **********/
def : GCNPat <
  (V_CNDMASK_B32_e64 /*src0mod*/(i32 0), /*src0*/(i32 0))
>;
--------------------------------------------------------------------------------

(file
  (multiline_comment)
  (statement
    (def
      (parent_class_list
        (identifier)
        (argument_list
          (value
            (dag_arg
              (value
                (identifier)))
            (multiline_comment)
            (dag_arg
              (value
                (dag_arg
                  (value
                    (identifier)))
                (dag_arg
                  (value
                    (number)))))
            (multiline_comment)
            (dag_arg
              (value
                (dag_arg
                  (value
                    (identifier)))
                (dag_arg
                  (value
                    (number))))))))
      (record_body))))

================================================================================
complicated dag arg
================================================================================
def : Pat<(VTIs[0].Vec MQPR:$offsets)>;
--------------------------------------------------------------------------------

(file
  (statement
    (def
      (parent_class_list
        (identifier)
        (argument_list
          (value
            (dag_arg
              (value
                (identifier)
                (value_suffix
                  (value
                    (number)))
                (value_suffix
                  (identifier))))
            (dag_arg
              (value
                (identifier))
              (var)))))
      (record_body))))

================================================================================
for
================================================================================
foreach Size = {2...6,8,16} in {
}
--------------------------------------------------------------------------------

(file
  (statement
    (foreach
      (identifier)
      (value
        (value
          (number)
          (value_suffix
            (value
              (number))))
        (value
          (number))
        (value
          (number)))
      (statement_or_block))))

================================================================================
string with escape
================================================================================
def NAME : C<".this \"should not emit\" ">;
--------------------------------------------------------------------------------

(file
  (statement
    (def
      (value
        (identifier))
      (parent_class_list
        (identifier)
        (argument_list
          (value
            (string_string))))
      (record_body))))

================================================================================
identifier starting with number
================================================================================
def 8rr : I8rr;
--------------------------------------------------------------------------------

(file
  (statement
    (def
      (value
        (identifier))
      (parent_class_list
        (identifier))
      (record_body))))

================================================================================
string with comment chars
================================================================================
def Callseq_Start :
  NVPTXInst<"\\{ // callseq $amt1, $amt2\n"
            "\t.reg .b32 temp_param_reg;">;
--------------------------------------------------------------------------------

(file
  (statement
    (def
      (value
        (identifier))
      (parent_class_list
        (identifier)
        (argument_list
          (value
            (string_string)
            (string_string))))
      (record_body))))

================================================================================
string with comment chars 2
================================================================================
class PseudoUseParamInst :
  NVPTXInst<"// Pseudo use of $src">;
--------------------------------------------------------------------------------

(file
  (statement
    (class
      (identifier)
      (parent_class_list
        (identifier)
        (argument_list
          (value
            (string_string))))
      (record_body))))

================================================================================
trailing #
================================================================================
// Mask setting all 0s or 1s
def NAME# : I<0, Pseudo>;
--------------------------------------------------------------------------------

(file
  (comment)
  (statement
    (def
      (value
        (value
          (identifier)))
      (parent_class_list
        (identifier)
        (argument_list
          (value
            (number))
          (value
            (identifier))))
      (record_body))))

================================================================================
nested comment
================================================================================
/* Foo
  bar
  /* 
  blah
  */

  stuff
  */

def x;
--------------------------------------------------------------------------------

(file
  (multiline_comment)
  (statement
    (def
      (value
        (identifier))
      (record_body))))

================================================================================
comment in code string
================================================================================
def frag_anyptr : PatFrag<(ops node:$src),
                   (int_mytarget_anyptr node:$src),
                   [{ return true; // C++ code }]> {
}
--------------------------------------------------------------------------------

(file
  (statement
    (def
      (value
        (identifier))
      (parent_class_list
        (identifier)
        (argument_list
          (value
            (dag_arg
              (value
                (identifier)))
            (dag_arg
              (value
                (identifier))
              (var)))
          (value
            (dag_arg
              (value
                (identifier)))
            (dag_arg
              (value
                (identifier))
              (var)))
          (value
            (code_string))))
      (record_body))))

================================================================================
named argument
================================================================================
def OpAddArguments : OpenMP_Op<"op_add_arguments",
    traits=[AttrSizedOperandSegments], clauses=[ReqClause, OptClause]> {
}
--------------------------------------------------------------------------------

(file
  (statement
    (def
      (value
        (identifier))
      (parent_class_list
        (identifier)
        (argument_list
          (value
            (string_string))
          (identifier)
          (value
            (value
              (identifier)))
          (identifier)
          (value
            (value
              (identifier))
            (value
              (identifier)))))
      (record_body))))

================================================================================
Arguments with arguments
================================================================================
def OpSkipArguments : OpenMP_Op<"op_skip_arguments",
    traits=[TraitThree], clauses=[OptClauseSkip<arguments=true>]> {
}
--------------------------------------------------------------------------------

(file
  (statement
    (def
      (value
        (identifier))
      (parent_class_list
        (identifier)
        (argument_list
          (value
            (string_string))
          (identifier)
          (value
            (value
              (identifier)))
          (identifier)
          (value
            (value
              (identifier)
              (value_suffix
                (argument_list
                  (identifier)
                  (value)))))))
      (record_body))))

================================================================================
dump
================================================================================
dump "Debug message";
dump "The Value of A is: \n" # !repr(a);
dump "got a pair of values [" # !repr(value_A) # " : " # !repr(value_B) # "], " # "and an empty record:\n" # !repr(X);

multiclass MC<dag s> {
  dump "s = " # !repr(s);
  dump "args[0] = " # !repr(!getdagarg<A>(s,0));
  def A;
}
--------------------------------------------------------------------------------

(file
  (statement
    (dump
      (value
        (string_string))))
  (statement
    (dump
      (value
        (value
          (string_string))
        (value
          (operator
            (operator_keyword)
            (value
              (identifier)))))))
  (statement
    (dump
      (value
        (value
          (value
            (value
              (value
                (value
                  (value
                    (string_string))
                  (value
                    (operator
                      (operator_keyword)
                      (value
                        (identifier)))))
                (value
                  (string_string)))
              (value
                (operator
                  (operator_keyword)
                  (value
                    (identifier)))))
            (value
              (string_string)))
          (value
            (string_string)))
        (value
          (operator
            (operator_keyword)
            (value
              (identifier)))))))
  (statement
    (multiclass
      (identifier)
      (template_args
        (template_arg
          (type)
          (identifier)))
      (multiclass_body
        (multiclass_statement
          (dump
            (value
              (value
                (string_string))
              (value
                (operator
                  (operator_keyword)
                  (value
                    (identifier)))))))
        (multiclass_statement
          (dump
            (value
              (value
                (string_string))
              (value
                (operator
                  (operator_keyword)
                  (value
                    (operator
                      (operator_keyword)
                      (type
                        (identifier))
                      (value
                        (identifier))
                      (value
                        (number)))))))))
        (multiclass_statement
          (def
            (value
              (identifier))
            (record_body)))))))

================================================================================
deftype
================================================================================
deftype Integer        = int;
deftype IntList        = list<int>;
--------------------------------------------------------------------------------

(file
  (statement
    (deftype
      (identifier)
      (type)))
  (statement
    (deftype
      (identifier)
      (type
        (type)))))

================================================================================
slice
================================================================================
def Rec11 {
  list<int> rr_ = rev[rev,];
}
--------------------------------------------------------------------------------

(file
  (statement
    (def
      (value
        (identifier))
      (record_body
        (body_item
          (instruction
            (type
              (type))
            (identifier)
            (value
              (identifier)
              (value_suffix
                (value
                  (identifier))))))))))
