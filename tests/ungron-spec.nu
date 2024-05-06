export def "test degenerate gron is ungronable" [] {
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
