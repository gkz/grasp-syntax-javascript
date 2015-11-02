{each, keys, difference, intersection} = require 'prelude-ls'

syntax =
  Misc:
    Program:
      alias: 'program'
      node-arrays: <[ body ]>
      note: "The root node of a JavaScript program's AST."
    Identifier:
      alias: 'ident'
      primitives: <[ name ]>
      example: 'x'
    Literal:
      alias: 'literal'
      primitives: <[ value ]>
      example: ['true', '1', '"string"']
    RegExpLiteral:
      alias: 'regex'
      primitives: <[ regex ]> # object primitive?
      example: '/^sh+/gi'
    Property:
      alias: 'prop'
      nodes: <[ key value ]>
      primitives: <[ kind ]>
      syntax: '*key*: *value*'
      example: 'a: 1'
      note: 'An object expression (obj) has a list of properties, each being a property.'
    SpreadElement:
      alias: 'spread'
      nodes: <[ argument ]>
    TemplateElement:
      alias: 'template-element'
      primitives: <[ tail value ]> # value is obj primitive
  Statements:
    EmptyStatement:
      alias: 'empty'
      example: ';'
    BlockStatement:
      alias: 'block'
      node-arrays: <[ body ]>
      syntax: '''
              {
                *statement_1*
                *statement_2*
                *...*
                *statement_n*
              }
              '''
      example: '''
               {
                 x = 1;
                 f();
                 x++;
               }
               '''
    ExpressionStatement:
      alias: 'exp-statement'
      nodes: <[ expression ]>
      syntax: '*expression*;'
      example: '2;'
      note: 'When an expression is used where a statement should be, it is wrapped in an expression statement.'
    IfStatement:
      alias: 'if'
      nodes: <[ test consequent alternate ]>
      syntax: '''
              if (*test*)
                *consequent*
              [else
                *alternate*]
              '''
      example:
        '''
        if (even(x)) {
          f(x);
        }
        '''
        '''
        if (x === 2) {
          x++;
        } else {
          f(x);
        }
        '''
    LabeledStatement:
      alias: 'label'
      nodes: <[ label body ]>
      syntax: '*label*: *body*;'
      example: '''
               outer:
               for (i = 0; i < xs.length; i++) {
                 for (j = 0; j < ys.length; j++) {
                   if (xs[i] === ys[j]) {
                     break outer;
                   }
                 }
               }
               '''
    BreakStatement:
      alias: 'break'
      nodes: <[ label ]>
      syntax: 'break [*label*];'
      example: ['break;', 'break outer;']
    ContinueStatement:
      alias: 'continue'
      nodes: <[ label ]>
      syntax: 'continue [*label*];'
      example: ['continue;', 'continue outerLoop;']
    WithStatement:
      alias: 'with'
      nodes: <[ object body ]>
      syntax: '''
              with (*object*)
                *body*
              '''
      example: '''
               with ({x: 42}) {
                 f(x);
               }
               '''
    SwitchStatement:
      alias: 'switch'
      nodes: <[ discriminant ]>
      node-arrays: <[ cases ]>
      syntax: '''
              switch (*discriminant*) {
                *case_1*
                *case_2*
                *...*
                *case_n*
              }
              '''
      example: '''
               switch (num) {
                 case 1:
                   f('one');
                   break;
                 case 2:
                   f('two');
                   break;
                 default:
                   f('too many');
               }
               '''
    ReturnStatement:
      alias: 'return'
      nodes: <[ argument ]>
      syntax: 'return *argument*;'
      example: 'return f(2);'
    ThrowStatement:
      alias: 'throw'
      nodes: <[ argument ]>
      syntax: 'throw *argument*;'
      example: 'throw new Error("oops");'
    TryStatement:
      alias: 'try'
      nodes: <[ block handler finalizer ]>
      syntax: '''
              try
                *block*
              [*handler*]
              [finally
                 *finalizer*]
              '''
      example: '''
               try {
                 result = parse(input);
               } catch (error) {
                 console.error(error.message);
                 result = '';
               } finally {
                 g(result);
               }
               '''
    WhileStatement:
      alias: 'while'
      nodes: <[ test body ]>
      syntax: '''
              while (*test*)
                *body*
              '''
      example: '''
               while (x < 2) {
                 f(x);
                 x++;
               }
               '''
    DoWhileStatement:
      alias: 'do-while'
      nodes: <[ test body ]>
      syntax: '''
              do
                *body*
              while (*test*);
              '''
      example: '''
               do {
                 f(x);
                 x++;
               } while (x < 2);
               '''
    ForStatement:
      alias: 'for'
      nodes: <[ init test update body ]>
      syntax: '''
              for ([*init*]; [*test*]; [*update*])
                *body*
              '''
      example: '''
               for (let x = 0; x < 2; x++) {
                 f(x);
               }
               '''
    ForInStatement:
      alias: 'for-in'
      nodes: <[ left right body ]>
      syntax: '''
              for (*left* in *right*)
                *body*
              '''
      example: '''
               for (let prop in object) {
                 f(object[prop]);
               }
               '''
    ForOfStatement:
      alias: 'for-of'
      nodes: <[ left right body ]>
      syntax: '''
              for (*left* of *right*)
                *body*
              '''
      example: '''
               for (let val of list) {
                 f(val);
               }
               '''
    DebuggerStatement:
      alias: 'debugger'
      syntax: 'debugger;'
      example: 'debugger;'
  Declarations:
    FunctionDeclaration:
      alias: 'func-dec'
      nodes: <[ id body ]>
      node-arrays: <[ params ]>
      primitives: <[ generator ]>
      syntax: '''
              function *id*([*param_1*], [*param_2*], [..., *param_3*])
                *body*
              '''
      example: '''
               function f(x, y) {
                 return x * y;
               }
               '''
      note: 'A function declaration contrasts with a function expression (func-exp).'
    VariableDeclaration:
      alias: 'var-decs'
      node-arrays: <[ declarations ]>
      primitives: <[ kind ]>
      syntax: 'var *declaration_1*[, *declaration_2*, ..., *declaration_n*]'
      example: 'var x = 1, y = 2;'
      note: 'Each declaration is a variable declarator (var-dec).'
    VariableDeclarator:
      alias: 'var-dec'
      nodes: <[ id init ]>
      syntax: '*id* = *init*'
      example: 'var x = 2'
  Expressions:
    ThisExpression:
      alias: 'this'
      example: 'this'
    Super:
      alias: 'super'
      example: 'super(x, y)'
    ArrayExpression:
      alias: 'arr'
      node-arrays: <[ elements ]>
      syntax: '[*element_0*, *element_1*, *...*, *element_n*]'
      example:
        '[1, 2, 3]'
        '[]'
    ObjectExpression:
      alias: 'obj'
      node-arrays: <[ properties ]>
      syntax: '''
              {
                *property_1*,
                *property_2*,
                *...*,
                *property_n*
              }
              '''
      example:
        '{a: 1, b: 2}'
        '{}'
    FunctionExpression:
      alias: 'func-exp'
      nodes: <[ id body ]>
      node-arrays: <[ params ]>
      primitives: <[ generator ]>
      syntax: '''
              function [*id*]([*param_1*], [*param_2*], [..., *param_3*])
                *body*
              '''
      example: '''
               let f = function(x, y) {
                 return x * y;
               }
               '''
      note: 'A function expression contrasts with a function declaration (func-dec).'
    ArrowFunctionExpression:
      alias: 'arrow'
      nodes: <[ id body ]>
      node-arrays: <[ params ]>
      primitives: <[ generator expression ]>
      syntax: '''
              ([*param_1*], [*param_2*], [..., *param_3*]) => *body*
              '''
      example: '''
               (x, y) => x * y
               '''
    SequenceExpression:
      alias: 'seq'
      node-arrays: <[ expressions ]>
      syntax: '*expression_1*, *expression_2*, *...*, *expression_n*'
      example: 'a, b, c'
    YieldExpression:
      alias: 'yield'
      nodes: <[ argument ]>
      primitive: <[ delegate ]>
      syntax: 'yield *argument*'
      example:
        'yield x'
    UnaryExpression:
      alias: 'unary'
      nodes: <[ argument ]>
      primitive: <[ operator prefix ]>
      syntax: '*operator**argument*'
      example:
        '+x'
        'typeof x'
    BinaryExpression:
      alias: 'bi'
      nodes: <[ left right ]>
      primitives: <[ operator ]>
      syntax: '*left* *operator* *right*'
      example: 'x === z'
    AssignmentExpression:
      alias: 'assign'
      nodes: <[ left right ]>
      primitives: <[ operator ]>
      syntax: '*left* *operator* *right*'
      example: '(y = 2)'
    UpdateExpression:
      alias: 'update'
      nodes: <[ argument ]>
      primitives: <[ operator prefix ]>
      syntax: '''
              *argument**operator*

              *or, if prefix*

              *operator**argument*
              '''
      example:
        '++x'
        'x--'
    LogicalExpression:
      alias: 'logic'
      nodes: <[ left right ]>
      primitives: <[ operator ]>
      syntax: '*left* *operator* *right*'
      example: 'x && y'
    ConditionalExpression:
      alias: 'cond'
      nodes: <[ test consequent alternate ]>
      syntax: '*test* ? *consequent* : *alternate*'
      example: 'x % 2 ? "odd" : "even"'
    NewExpression:
      alias: 'new'
      nodes: <[ callee ]>
      node-arrays: <[ arguments ]>
      syntax: 'new *callee*(*argument_1*, *argument_2*, *...*, *argument_n*)'
      example: 'new Date(2011, 11, 11)'
    CallExpression:
      alias: 'call'
      nodes: <[ callee ]>
      node-arrays: <[ arguments ]>
      syntax: '*callee*(*argument_1*, *argument_2*, *...*, *argument_n*)'
      example: 'f(1,2,3)'
    MemberExpression:
      alias: 'member'
      nodes: <[ object property ]>
      primitives: <[ computed ]>
      syntax: '*object*.*property*'
      example: 'Math.PI'
    TemplateLiteral:
      alias: 'template-literal'
      node-arrays: <[ quasis expressions ]>
    TaggedTemplateExpression:
      alias: 'tagged-template-exp'
      nodes: <[ tag quasi ]>
  Clauses:
    SwitchCase:
      alias: 'switch-case'
      nodes: <[ test ]>
      node-arrays: <[ consequent ]>
      syntax: '''
              case *test* | default :
                *consequent*
              '''
      example:
        '''
        case 1:
          z = 'one';
          break;
        '''
        '''
        default:
          z = 'two'
        '''
    CatchClause:
      alias: 'catch'
      nodes: <[ param body ]>
      syntax: '''
              catch (*param*)
                *body*
              '''
      example: '''
               catch (e) {
                 console.error(e.message);
               }
               '''
  Patterns:
    AssignmentProperty:
      alias: 'assign-prop'
      nodes: <[ key value ]>
      primitives: <[ kind method ]>
    ObjectPattern:
      alias: 'obj-pattern'
      node-arrays: <[ properties ]>
    ArrayPattern:
      alias: 'array-pattern'
      node-arrays: <[ elements ]>
    RestElement:
      alias: 'rest-element'
      nodes: <[ argument ]>
    AssignmentPattern:
      alias: 'assign-pattern'
      nodes: <[ left right ]>
  Classes:
    ClassBody:
      alias: 'class-body'
      node-arrays: <[ body ]>
    MethodDefinition:
      alias: 'method'
      nodes: <[ key value ]>
      primitives: <[ kind computed static ]>
    ClassDeclaration:
      alias: 'class-dec'
      nodes: <[ id superClass body ]>
    ClassExpression:
      alias: 'class-exp'
      nodes: <[ id superClass body ]>
    MetaProperty:
      alias: 'meta-property'
      nodes: <[ meta property ]>
  Modules:
    ModuleDeclaration:
      alias: 'module-dec'
    ModuleSpecifier:
      alias: 'module-specifier'
      nodes: <[ local ]>
  Imports:
    ImportDeclaration:
      alias: 'import-dec'
      nodes: <[ specifiers source ]>
    ImportSpecifier:
      alias: 'import-specifier'
      nodes: <[ local imported ]>
    ImportDefaultSpecifier:
      alias: 'import-default-specifier'
      nodes: <[ local ]>
    ImportNamespaceSpecifier:
      alias: 'import-namespace-specifier'
      nodes: <[ local ]>
  Exports:
    ExportNamedDeclaration:
      alias: 'export-named-dec'
      nodes: <[ declaration specifiers source ]>
    ExportSpecifier:
      alias: 'export-specifier'
      nodes: <[ local exported ]>
    ExportDefaultDeclaration:
      alias: 'export-default-specifier'
      nodes: <[ declaration ]>
    ExportAllDeclarationSpecifier:
      alias: 'export-namespace-specifier'
      nodes: <[ source ]>

syntax-flat = {}
for , category of syntax
  for node-name, node of category
    syntax-flat[node-name] = node

complex-types =
  iife: 'ImmediatelyInvokedFunctionExpression'

complex-type-map = {}
for key, val of complex-types
  complex-type-map[key] = val
  complex-type-map[val] = val

alias-map = {}
for node-name, node of syntax-flat
  alias-map[node.alias] = node-name

matches-map =
  Statement: keys syntax.Statements
  Declaration: keys syntax.Declarations
  Expression: keys syntax.Expressions
  Clause: keys syntax.Clauses

  BiOp: <[ BinaryExpression LogicalExpression AssignmentExpression ]>
  Function: <[ FunctionDeclaration FunctionExpression ]>
  ForLoop: <[ ForStatement ForInStatement ForOfStatement ]>
  WhileLoop: <[ DoWhileStatement WhileStatement ]>
  Class: <[ ClassExpression ClassExpression ]>
  Loop: <[ ForStatement ForInStatement ForOfStatement DoWhileStatement WhileStatement ]>

matches-alias-map =
  statement: 'Statement'
  dec: 'Declaration'
  exp: 'Expression'
  clause: 'Clause'

  biop: 'BiOp'
  func: 'Function'
  'for-loop': 'ForLoop'
  'while-loop': 'WhileLoop'
  loop: 'Loop'
  class: 'Class'

literals =
  null: 'Null'
  bool: 'Boolean'
  num: 'Number'
  str: 'String'
  regex: 'RegExp'

literal-map = {}
for key, val of literals
  literal-map[key] = val
  literal-map[val] = val

attr-map =
  exp: 'expression'
  exps: 'expressions'
  then: 'consequent'
  alt: 'alternate'
  else: 'alternate'
  op: 'operator'
  l: 'left'
  r: 'right'
  arg: 'argument'
  args: 'arguments'
  els: 'elements'
  val: 'value'
  obj: 'object'
  prop: 'property'
  props: 'properties'
  decs: 'declarations'

attr-map-inverse = {}
for alias, name of attr-map
  attr-map-inverse[name] ?= []
  attr-map-inverse[name].push alias

primitive-attributes-set = {}
non-primitive-attributes-set = {}

for node-name, node of syntax-flat
  each (-> primitive-attributes-set[it] = true), that if node.primitives
  each (-> non-primitive-attributes-set[it] = true), that if node.nodes
  each (-> non-primitive-attributes-set[it] = true), that if node.node-arrays

non-primitive-attributes = keys non-primitive-attributes-set
primitive-attributes = keys primitive-attributes-set
either-attributes = intersection primitive-attributes, non-primitive-attributes
primitive-only-attributes = difference primitive-attributes, non-primitive-attributes

module.exports = {syntax, syntax-flat, complex-type-map, alias-map, matches-map, matches-alias-map, literal-map,  attr-map, attr-map-inverse, primitive-only-attributes, either-attributes}
