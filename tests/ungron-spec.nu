export def "test primitive gron is ungron-able" [] {
  use ../gron.nu
  use std assert
  let gronned = [
    [ key value ];
    [ null, "nothing fancy" ]
  ]

  let ungronned = gron --ungron $gronned

  assert equal "nothing fancy" $ungronned
}

export def "test degenerate record gron is ungron-able" [] {
  use ../gron.nu
  use std assert
  let gronned = [
    [ key value ];
    [ null, {} ]
  ]

  let ungronned = gron --ungron $gronned

  assert equal {} $ungronned
}

export def "test record gron is ungron-able" [] {
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

export def "test record gron with regexish key is ungron-able" [] {
  use ../gron.nu
  use std assert
  let gronned = [
    [ key value ];
    [ null {} ]
    [ "[a-z]+" {} ]
    [ "[a-z]+.a" A ]
  ]

  let ungronned = gron --ungron $gronned

  assert equal A $ungronned."[a-z]+".a
}


export def "test degenerate list gron is ungron-able" [] {
  use ../gron.nu
  use std assert
  let gronned = [
    [ key value ];
    [ null, [] ]
  ]

  let ungronned = gron --ungron $gronned

  assert equal [] $ungronned
}

export def "test list gron is ungron-able" [] {
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

export def "test nested record gron is ungron-able" [] {
  use ../gron.nu
  use std assert
  let gronned = [
    [ key value ];
    [ null, {} ]
    [ "child", {} ]
    [ "child.a", A ]
  ]

  let ungronned = gron --ungron $gronned

  assert ($ungronned | columns | all {|key| $key != "child.a"})
  assert equal A $ungronned.child.a
}

export def "test nested list gron is ungron-able" [] {
  use ../gron.nu
  use std assert
  let gronned = [
    [ key value ];
    [ null, [] ]
    [ "[0]", [] ]
    [ "[0].[0]", A ]
  ]

  let ungronned = gron --ungron $gronned

  assert equal A $ungronned.0.0
}
