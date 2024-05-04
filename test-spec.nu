export def "test basic record is gron-able" [] {
  use std assert
  use gron.nu
  let nuon = {
    single: basic-property
  }

  let result = gron $nuon

  assert equal 2 ($result | length)
  assert equal null ($result.0.key?)
  assert equal {} ($result.0.value)
  assert equal single ($result.1.key)
  assert equal basic-property ($result.1.value)
}

export def "test multi-propertied record is gron-able" [] {
  use std assert
  use gron.nu
  let nuon = {
    important: data
    with: multiple-values
  }

  let result = gron $nuon

  assert equal 3 ($result | length)
  assert equal important ($result.1.key)
  assert equal data ($result.1.value)
}

export def "test null is gron-able" [] {
  use std assert
  use gron.nu
  let nuon = null

  let result = gron $nuon

  assert equal 1 ($result | length)
  assert equal null ($result.0.key?)
  assert equal $nuon ($result.0.value)
}

export def "test strings are gron-able" [] {
  use std assert
  use gron.nu
  let nuon = "a string"

  let result = gron $nuon

  assert equal null ($result.0.key?)
  assert equal $nuon ($result.0.value)

  let nuon2 = 314

  let result2 = gron $nuon2

  assert equal null ($result2.0.key?)
  assert equal $nuon2 ($result2.0.value)
}

export def "test integers are gron-able" [] {
  use std assert
  use gron.nu
  let nuon = 314

  let result = gron $nuon

  assert equal null ($result.0.key?)
  assert equal $nuon ($result.0.value)
}

export def "test decimals are gron-able" [] {
  use std assert
  use gron.nu
  let nuon = 3.14

  let result = gron $nuon

  assert equal null ($result.0.key?)
  assert equal $nuon ($result.0.value)
}

export def "test booleans are gron-able" [] {
  use std assert
  use gron.nu
  let nuon = false

  let result = gron $nuon

  assert equal null ($result.0.key?)
  assert equal $nuon ($result.0.value)
}

export def "test file sizes are gron-able" [] {
  use std assert
  use gron.nu
  let nuon = 64mb

  let result = gron $nuon

  assert equal null ($result.0.key?)
  assert equal $nuon ($result.0.value)
}

export def "test durations are gron-able" [] {
  use std assert
  use gron.nu
  let nuon = 2min

  let result = gron $nuon

  assert equal null ($result.0.key?)
  assert equal $nuon ($result.0.value)
}

export def "test dates are gron-able" [] {
  use std assert
  use gron.nu
  let nuon = "2024-01-01" | into datetime

  let result = gron $nuon

  assert equal null ($result.0.key?)
  assert equal $nuon ($result.0.value)
}

export def "test ranges are gron-able" [] {
  use std assert
  use gron.nu
  let nuon = 0..100

  let result = gron $nuon

  assert equal null ($result.0.key?)
  assert equal $nuon ($result.0.value)
}

export def "test binary is gron-able" [] {
  use std assert
  use gron.nu
  let nuon = "abc" | into binary

  let result = gron $nuon

  assert equal null ($result.0.key?)
  assert equal $nuon ($result.0.value)
}

