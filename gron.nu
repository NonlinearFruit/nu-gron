export def main [--ungron --prefix:any=null object] {
  if ($ungron) {
    ungron $object
  } else {
    gron $prefix $object
  }
}

def gron [prefix object] {
  match ($object | describe) {
    $record if $record =~ ^record => (gron-record $prefix $object),
    $list if $list =~ ^list or $list =~ ^table => (gron-list $prefix $object),
    _ => (gron-primitive $prefix $object),
  }
}

def ungron [object] {
  let root = $object | where key == null | get value | first
  $object
  | where key != null
  | where key !~ '[.]'
  | reduce --fold $root {|it acc|
    if ($acc | describe | $in =~ ^record) {
      $acc
      | merge (ungron-record $it.key $it.value $object)
    } else {
      $acc ++ (ungron-list $it.key $it.value $object)
    }
  }
}

def gron-record [prefix record] {
  $record
  | items {|key value|
    if $prefix != null {
      $"($prefix).($key)"
    } else {
      $key
    }
    | main --prefix $in $value
  }
  | flatten
  | prepend { key: $prefix, value: {} }
}

def ungron-record [prefix value object] {
  let related_rows = $object | where key != null | where key =~ $'^($prefix)\.'
  if ($related_rows | length) == 0 {
    { $prefix: $value }
  } else {
    $related_rows
    | update key { str replace -r $'^($prefix)\.' '' }
    | prepend { key: null, value: $value }
    | ungron $in
    | {
      $prefix: $in
    }
  }
}

def gron-list [prefix list] {
  $list
  | enumerate
  | each {|row|
    if $prefix != null {
      $"($prefix).[($row.index)]"
    } else {
      $"[($row.index)]"
    }
    | main --prefix $in $row.item
  }
  | flatten
  | prepend { key: $prefix, value: [] }
}

def ungron-list [prefix value object] {
  let related_rows = $object | where key != null | where ($it.key | str starts-with $"($prefix).")
  if ($related_rows | length) == 0 {
    [ $value ]
  } else {
    $related_rows
    | update key { str substring ($"($prefix)." | str length).. }
    | prepend { key: null, value: $value }
    | ungron $in
    | [ $in ]
  }
}

def gron-primitive [prefix primitive] {
  [ [key value]; [$prefix $primitive] ]
}
