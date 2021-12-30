module.exports = grammar({
  name: 'tablegen',

  conflicts: $ => [
    [$.value], [$._value_concat], [$._simple_value],
  ],

  externals: $ => [
    $.multiline_comment,
  ],

  extras: $ => [
    /\s+/,
    $.comment,
    $.multiline_comment,
    $.preprocessor,
  ],

  word: $ => $.identifier,

  rules: {
    file: $ => repeat($.statement),

    comment: $ => /\/\/[^\n\r]*/,

    number: $ => /[+-]?\d+|0x[\da-fA-F]+|0b[01]+/,
    identifier: $ => /[a-zA-Z_0-9]*[a-zA-Z_][a-zA-Z_0-9]*/,
    string_string: $ => /"(\\\\|\\'|\\"|\\t|\\n|[^\\"])*"/,
    code_string: $ => /\[\{([^}]|\}+[^}\]])*\}\]/,
    var: $ => /\$[a-zA-Z_][a-zA-Z_0-9]*/,

    include: $ => seq('include', $.string_string),
    preprocessor: $ => token(choice(
      seq(choice('#define', '#ifdef', '#ifndef'), /\s+/, field('macro_name', /[a-zA-Z_][a-zA-Z_0-9]*/)),
      '#else',
      '#endif',
    )),

    statement: $ => choice(
      $.assert,
      $.class,
      $.def,
      $.defm,
      $.defset,
      $.defvar,
      $.foreach,
      $.if,
      $.let,
      $.multiclass,
      $.include,
    ),

    statement_or_block: $ => choice(
      $.statement,
      seq('{', repeat($.statement), '}'),
    ),

    class: $ => seq(
      'class',
      field('name', $.identifier),
      optional($.template_args),
      optional($.parent_class_list),
      field('body', $.record_body),
    ),

    parent_class_list: $ => seq(
      ':',
      commaSep1(seq($.identifier, optional(seq('<', commaSep(field('argument', $.value)), '>')))),
    ),

    template_args: $ => seq('<', commaSep(field('argument', $.template_arg)), '>'),

    template_arg: $ => seq($.type, $.identifier, optional(seq('=', $.value))),

    record_body: $ => choice(';', seq('{', repeat($.body_item), '}')),

    body_item: $ => choice(
      $.instruction,
      $.let_inst,
      $.def_var,
      $.assert,
    ),

    instruction: $ => seq(
      optional('field'), // deprecated
      choice($.type, 'code'),
      $.identifier,
      optional(seq('=', $.value)),
      ';',
    ),

    let_inst: $ => seq(
      'let',
      $.identifier,
      optional(seq('{', commaSep($.value), '}')),
      '=',
      $.value,
      ';',
    ),

    def_var: $ => seq(
      'defvar',
      $.identifier,
      '=',
      $.value,
      ';',
    ),

    def: $ => seq(
      'def',
      optional($.value),
      optional($.parent_class_list),
      field('body', $.record_body),
    ),

    let: $ => seq(
      'let',
      commaSep1($.let_item),
      'in',
      choice($.statement, seq('{', repeat($.statement), '}')),
    ),

    let_item: $ => seq(
      $.identifier,
      optional(seq('<', commaSep($.value), '>')),
      '=',
      $.value,
    ),

    multiclass: $ => seq(
      'multiclass',
      $.identifier,
      optional($.template_args),
      optional($.parent_class_list),
      field('body', $.multiclass_body),
    ),

    multiclass_body: $ => choice(';', seq('{', repeat($.multiclass_statement), '}')),

    multiclass_statement: $ => choice(
      $.assert,
      $.def,
      $.defm,
      $.defvar,
      $.foreach,
      $.if,
      $.let,
    ),

    defm: $ => seq(
      'defm',
      optional($.value),
      $.parent_class_list,
      ';',
    ),

    defset: $ => seq(
      'defset',
      $.type,
      $.identifier,
      '=',
      '{',
      repeat($.statement),
      '}',
    ),

    defvar: $ => seq(
      'defvar',
      $.identifier,
      '=',
      $.value,
      ';',
    ),

    foreach: $ => seq(
      'foreach',
      $.identifier,
      '=',
      $.value,
      'in',
      $.statement_or_block,
    ),

    if: $ => prec.left(seq(
      'if',
      $.value,
      'then',
      $.statement_or_block,
      optional(seq(
        'else',
        $.statement_or_block,
      ))
    )),

    assert: $ => seq(
      'assert',
      $.value,
      ',',
      $.value,
      ';',
    ),

    type: $ => choice(
      'bit',
      'int',
      'string',
      'dag',
      seq('bits', '<', $.number, '>'),
      seq('list', '<', $.type, '>'),
      $.identifier, // class
    ),

    value: $ => choice(
      seq(
        $._simple_value,
        repeat($.value_suffix),
      ),
      $._value_concat,
    ),

    _value_concat: $ => seq(
      $.value,
      repeat1(prec.left(seq('#', optional($.value)))),
    ),

    _simple_value: $ => choice(
      $.number,
      $.identifier,
      $.string_string,
      $._repeated_string,
      $.code_string,
      'true',
      'false',
      '?',
      seq('{', commaSep($.value), optional(','), '}'),
      seq('[', commaSep($.value), optional(','), ']', optional(seq('<', $.type, '>'))),
      seq('(', $.dag_arg, commaSep($.dag_arg), ')'),
      seq($.identifier, '<', commaSep(field('argument', $.value)), '>'),
      $.operator,
    ),

    _repeated_string: $ => repeat1($.string_string),

    operator: $ => choice(
      seq($.operator_keyword, optional(seq('<', $.type, '>')), '(', commaSep(field('argument', $.value)), optional(','), ')'),
      seq('!cond', '(', commaSep(field('argument', seq($.value, ':', $.value))), optional(','), ')'),
    ),

    dag_arg: $ => choice(
      seq($.value, optional(seq(':', $.var))),
      $.var,
    ),

    value_suffix: $ => prec(1, choice(
      seq('{', commaSep($.value), '}'),
      seq('[', commaSep($.value), ']'),
      seq('.', $.identifier),
      seq(choice('...', '-'), $.value),
    )),

    // Not including !cond
    operator_keyword: $ => seq(
      '!',
      token.immediate(choice(
        'add',
        'and',
        'cast',
        'con',
        'dag',
        'empty',
        'eq',
        'filter',
        'find',
        'foldl',
        'foreach',
        'ge',
        'getdagop',
        'gt',
        'head',
        'if',
        'interleave',
        'isa',
        'le',
        'listconcat',
        'listsplat',
        'lt',
        'mul',
        'ne',
        'not',
        'or',
        'setdagop',
        'shl',
        'size',
        'sra',
        'srl',
        'strconcat',
        'sub',
        'subst',
        'substr',
        'tail',
        'xor',
      )),
    ),
  },
});

function commaSep(rule) {
  return optional(commaSep1(rule));
}

function commaSep1(rule) {
  return seq(rule, repeat(seq(',', rule)));
}
