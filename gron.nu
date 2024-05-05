export def main [--prefix:any=null object] {
  match ($object | describe) {
    $record if $record =~ ^record => (gron-record $prefix $object),
    $list if $list =~ ^list or $list =~ ^table => (gron-list $prefix $object),
    _ => (gron-primative $prefix $object),
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

def gron-primative [prefix primative] {
  [ [key value]; [$prefix $primative] ]
}
