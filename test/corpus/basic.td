================================================================================
Basic example
================================================================================
def ADD32rr {   // Instruction X86Inst I
  string Namespace = "X86";
  dag OutOperandList = (outs GR32:$dst);
  dag InOperandList = (ins GR32:$src1, GR32:$src2);
  string AsmString = "add{l}\t{$src2, $dst|$dst, $src2}";
  list<dag> Pattern = [(set GR32:$dst, (add GR32:$src1, GR32:$src2))];
  list<Register> Uses = [];
  list<Register> Defs = [EFLAGS];
  list<Predicate> Predicates = [];
  bit hasSideEffects = 0;
  InstrItinClass Itinerary = NoItinerary;
  string DisableEncoding = "";
  bits<8> Opcode = { 0, 0, 0, 0, 0, 0, 0, 1 };
  Format Form = MRMDestReg;
  ImmType ImmT = NoImm;
  FPFormat FPForm = ?;
}
--------------------------------------------------------------------------------

(file
  (statement
    (def
      (value
        (identifier))
      (record_body
        (comment)
        (body_item
          (instruction
            (type)
            (identifier)
            (value
              (string_string))))
        (body_item
          (instruction
            (type)
            (identifier)
            (value
              (dag_arg
                (value
                  (identifier)))
              (dag_arg
                (value
                  (identifier))
                (var)))))
        (body_item
          (instruction
            (type)
            (identifier)
            (value
              (dag_arg
                (value
                  (identifier)))
              (dag_arg
                (value
                  (identifier))
                (var))
              (dag_arg
                (value
                  (identifier))
                (var)))))
        (body_item
          (instruction
            (type)
            (identifier)
            (value
              (string_string))))
        (body_item
          (instruction
            (type
              (type))
            (identifier)
            (value
              (value
                (dag_arg
                  (value
                    (identifier)))
                (dag_arg
                  (value
                    (identifier))
                  (var))
                (dag_arg
                  (value
                    (dag_arg
                      (value
                        (identifier)))
                    (dag_arg
                      (value
                        (identifier))
                      (var))
                    (dag_arg
                      (value
                        (identifier))
                      (var))))))))
        (body_item
          (instruction
            (type
              (type
                (identifier)))
            (identifier)
            (value)))
        (body_item
          (instruction
            (type
              (type
                (identifier)))
            (identifier)
            (value
              (value
                (identifier)))))
        (body_item
          (instruction
            (type
              (type
                (identifier)))
            (identifier)
            (value)))
        (body_item
          (instruction
            (type)
            (identifier)
            (value
              (number))))
        (body_item
          (instruction
            (type
              (identifier))
            (identifier)
            (value
              (identifier))))
        (body_item
          (instruction
            (type)
            (identifier)
            (value
              (string_string))))
        (body_item
          (instruction
            (type
              (number))
            (identifier)
            (value
              (value
                (number))
              (value
                (number))
              (value
                (number))
              (value
                (number))
              (value
                (number))
              (value
                (number))
              (value
                (number))
              (value
                (number)))))
        (body_item
          (instruction
            (type
              (identifier))
            (identifier)
            (value
              (identifier))))
        (body_item
          (instruction
            (type
              (identifier))
            (identifier)
            (value
              (identifier))))
        (body_item
          (instruction
            (type
              (identifier))
            (identifier)
            (value)))))))

================================================================================
class
================================================================================
class Foo {
  int Bar = 5;
  int Baz = Bar;
}
--------------------------------------------------------------------------------

(file
  (statement
    (class
      (identifier)
      (record_body
        (body_item
          (instruction
            (type)
            (identifier)
            (value
              (number))))
        (body_item
          (instruction
            (type)
            (identifier)
            (value
              (identifier))))))))

================================================================================
multiclass
================================================================================
multiclass Foo <int Bar> {
  def : SomeClass<Bar>;
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
      (multiclass_body
        (multiclass_statement
          (def
            (parent_class_list
              (identifier)
              (argument_list
                (value
                  (identifier))))
            (record_body)))))))

================================================================================
template class
================================================================================
class A <dag d> {
  dag the_dag = d;
}

def rec1 : A<(ops rec1)>;
--------------------------------------------------------------------------------

(file
  (statement
    (class
      (identifier)
      (template_args
        (template_arg
          (type)
          (identifier)))
      (record_body
        (body_item
          (instruction
            (type)
            (identifier)
            (value
              (identifier)))))))
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
                (identifier))))))
      (record_body))))

================================================================================
let in
================================================================================
let isTerminator = true, isReturn = true, isBarrier = true, hasCtrlDep = true in
  def RET : I<0xC3, RawFrm, (outs), (ins), "ret", [(X86retflag 0)]>;

let isCall = true in
  // All calls clobber the non-callee saved registers...
  let Defs = [EAX, ECX, EDX, FP0, FP1, FP2, FP3, FP4, FP5, FP6, ST0,
              MM0, MM1, MM2, MM3, MM4, MM5, MM6, MM7, XMM0, XMM1, XMM2,
              XMM3, XMM4, XMM5, XMM6, XMM7, EFLAGS] in {
    def CALLpcrel32 : Ii32<0xE8, RawFrm, (outs), (ins i32imm:$dst, variable_ops),
                           "call\t${dst:call}", []>;
    def CALL32r     : I<0xFF, MRM2r, (outs), (ins GR32:$dst, variable_ops),
                        "call\t{*}$dst", [(X86call GR32:$dst)]>;
    def CALL32m     : I<0xFF, MRM2m, (outs), (ins i32mem:$dst, variable_ops),
                        "call\t{*}$dst", []>;
  }
--------------------------------------------------------------------------------

(file
  (statement
    (let
      (let_item
        (identifier)
        (value))
      (let_item
        (identifier)
        (value))
      (let_item
        (identifier)
        (value))
      (let_item
        (identifier)
        (value))
      (statement
        (def
          (value
            (identifier))
          (parent_class_list
            (identifier)
            (argument_list
              (value
                (number))
              (value
                (identifier))
              (value
                (dag_arg
                  (value
                    (identifier))))
              (value
                (dag_arg
                  (value
                    (identifier))))
              (value
                (string_string))
              (value
                (value
                  (dag_arg
                    (value
                      (identifier)))
                  (dag_arg
                    (value
                      (number)))))))
          (record_body)))))
  (statement
    (let
      (let_item
        (identifier)
        (value))
      (comment)
      (statement
        (let
          (let_item
            (identifier)
            (value
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))
              (value
                (identifier))))
          (statement
            (def
              (value
                (identifier))
              (parent_class_list
                (identifier)
                (argument_list
                  (value
                    (number))
                  (value
                    (identifier))
                  (value
                    (dag_arg
                      (value
                        (identifier))))
                  (value
                    (dag_arg
                      (value
                        (identifier)))
                    (dag_arg
                      (value
                        (identifier))
                      (var))
                    (dag_arg
                      (value
                        (identifier))))
                  (value
                    (string_string))
                  (value)))
              (record_body)))
          (statement
            (def
              (value
                (identifier))
              (parent_class_list
                (identifier)
                (argument_list
                  (value
                    (number))
                  (value
                    (identifier))
                  (value
                    (dag_arg
                      (value
                        (identifier))))
                  (value
                    (dag_arg
                      (value
                        (identifier)))
                    (dag_arg
                      (value
                        (identifier))
                      (var))
                    (dag_arg
                      (value
                        (identifier))))
                  (value
                    (string_string))
                  (value
                    (value
                      (dag_arg
                        (value
                          (identifier)))
                      (dag_arg
                        (value
                          (identifier))
                        (var))))))
              (record_body)))
          (statement
            (def
              (value
                (identifier))
              (parent_class_list
                (identifier)
                (argument_list
                  (value
                    (number))
                  (value
                    (identifier))
                  (value
                    (dag_arg
                      (value
                        (identifier))))
                  (value
                    (dag_arg
                      (value
                        (identifier)))
                    (dag_arg
                      (value
                        (identifier))
                      (var))
                    (dag_arg
                      (value
                        (identifier))))
                  (value
                    (string_string))
                  (value)))
              (record_body))))))))

================================================================================
short def
================================================================================
def Imm;
--------------------------------------------------------------------------------

(file
  (statement
    (def
      (value
        (identifier))
      (record_body))))

================================================================================
defvar
================================================================================
defvar i = !add(i, 1);
--------------------------------------------------------------------------------

(file
  (statement
    (defvar
      (identifier)
      (value
        (operator
          (operator_keyword)
          (value
            (identifier))
          (value
            (number)))))))

================================================================================
foreach
================================================================================
foreach i = [0, 1, 2, 3] in {
  def R#i : Register<>;
  def F#i : Register<>;
}
--------------------------------------------------------------------------------

(file
  (statement
    (foreach
      (identifier)
      (value
        (value
          (number))
        (value
          (number))
        (value
          (number))
        (value
          (number)))
      (statement_or_block
        (statement
          (def
            (value
              (value
                (identifier))
              (value
                (identifier)))
            (parent_class_list
              (identifier)
              (argument_list))
            (record_body)))
        (statement
          (def
            (value
              (value
                (identifier))
              (value
                (identifier)))
            (parent_class_list
              (identifier)
              (argument_list))
            (record_body)))))))

================================================================================
class
================================================================================
class PersonName<string name> {
  assert !le(!size(name), 32), "person name is too long: " # name;
  string Name = name;
}

class Person<string name, int age> : PersonName<name> {
  assert !and(!ge(age, 1), !le(age, 120)), "person age is invalid: " # age;
  int Age = age;
}

def Rec20 : Person<"Donald Knuth", 60> {
}
--------------------------------------------------------------------------------

(file
  (statement
    (class
      (identifier)
      (template_args
        (template_arg
          (type)
          (identifier)))
      (record_body
        (body_item
          (assert
            (value
              (operator
                (operator_keyword)
                (value
                  (operator
                    (operator_keyword)
                    (value
                      (identifier))))
                (value
                  (number))))
            (value
              (value
                (string_string))
              (value
                (identifier)))))
        (body_item
          (instruction
            (type)
            (identifier)
            (value
              (identifier)))))))
  (statement
    (class
      (identifier)
      (template_args
        (template_arg
          (type)
          (identifier))
        (template_arg
          (type)
          (identifier)))
      (parent_class_list
        (identifier)
        (argument_list
          (value
            (identifier))))
      (record_body
        (body_item
          (assert
            (value
              (operator
                (operator_keyword)
                (value
                  (operator
                    (operator_keyword)
                    (value
                      (identifier))
                    (value
                      (number))))
                (value
                  (operator
                    (operator_keyword)
                    (value
                      (identifier))
                    (value
                      (number))))))
            (value
              (value
                (string_string))
              (value
                (identifier)))))
        (body_item
          (instruction
            (type)
            (identifier)
            (value
              (identifier)))))))
  (statement
    (def
      (value
        (identifier))
      (parent_class_list
        (identifier)
        (argument_list
          (value
            (string_string))
          (value
            (number))))
      (record_body))))

================================================================================
include
================================================================================
include "abc"
--------------------------------------------------------------------------------

(file
  (statement
    (include
      (string_string))))

================================================================================
preprocessor
================================================================================
#ifdef USE_NAMESPACE
  let Namespace = "TestNamespace" in {
#endif
#ifdef USE_NAMESPACE
  }
#endif
--------------------------------------------------------------------------------

(file
  (preprocessor)
  (statement
    (let
      (let_item
        (identifier)
        (value
          (string_string)))
      (preprocessor)
      (preprocessor)))
  (preprocessor))
