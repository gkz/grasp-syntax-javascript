j = require '..'
{strict-equal: equal}:assert = require 'assert'
{keys} = require 'prelude-ls'

suite 'tests' ->
  test 'syntax' ->
    equal 'Object', typeof! j.syntax
    assert <| keys j.syntax .length

    for , category of j.syntax
      equal 'Object', typeof! category
      assert <| keys category .length

      for , node of category
        equal 'Object', typeof! node

  test 'syntax-flat' ->
    equal 'Object', typeof! j.syntax-flat
    assert <| keys j.syntax-flat .length

    for , node of j.syntax-flat
      equal 'Object', typeof! node

  test 'complex-type-map' ->
    equal 'Object', typeof! j.complex-type-map
    assert <| keys j.complex-type-map .length

  test 'alias-map' ->
    equal 'Object', typeof! j.alias-map
    assert <| keys j.alias-map .length

  test 'matches-map' ->
    equal 'Object', typeof! j.matches-map
    assert <| keys j.matches-map .length

    for , value of j.matches-map
      equal 'Array' typeof! value
      assert value.length

  test 'matches-alias-map' ->
    equal 'Object', typeof! j.matches-alias-map
    assert <| keys j.matches-alias-map .length

  test 'literal-map' ->
    equal 'Object', typeof! j.literal-map
    assert <| keys j.literal-map .length

  test 'attr-map' ->
    equal 'Object', typeof! j.attr-map
    assert <| keys j.attr-map .length

  test 'attr-map-inverse' ->
    equal 'Object', typeof! j.attr-map-inverse
    assert <| keys j.attr-map .length

  test 'primitive-only-attributes' ->
    equal 'Array', typeof! j.primitive-only-attributes
    assert j.primitive-only-attributes.length

  test 'either-attributes' ->
    equal 'Array', typeof! j.either-attributes
    assert j.either-attributes.length
