export def "test degenerate record gron is ungronable" [] {
  use ../gron.nu
  use std assert
  let gronned = [
    [ key value ];
    [ null, {} ]
  ]

  let ungronned = gron --ungron $gronned

  assert equal {} $ungronned
}

export def "test record gron is ungronable" [] {
  use ../gron.nu
  use std assert
  let gronned = [
    [ key value ];
    [ null, {} ]
    [ a, A ]
    [ b, B ]
  ]

  let ungronned = gron --ungron $gronned

  assert equal A $ungronned.a
  assert equal B $ungronned.b
}

export def "test degenerate list gron is ungronable" [] {
  use ../gron.nu
  use std assert
  let gronned = [
    [ key value ];
    [ null, [] ]
  ]

  let ungronned = gron --ungron $gronned

  assert equal [] $ungronned
}

export def "test list gron is ungronable" [] {
  use ../gron.nu
  use std assert
  let gronned = [
    [ key value ];
    [ null, [] ]
    [ "[0]", A ]
    [ "[1]", B ]
  ]

  let ungronned = gron --ungron $gronned

  assert equal A $ungronned.0
  assert equal B $ungronned.1
}
