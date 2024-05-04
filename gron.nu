export def main [--prefix:any=null object] {
  match ($object | describe) {
    $record if $record =~ ^record => (gron-record $prefix $object),
    $list if $list =~ ^list => (gron-list $object),
    _ => (gron-primative $prefix $object),
  }
}

def gron-record [prefix record] {
  $record
  | transpose key value
  | each {|row|
    if $prefix != null {
      $"($prefix).($row.key)"
    } else {
      $row.key
    }
    | main --prefix $in $row.value
  }
  | flatten
  | prepend { key: $prefix, value: {} }
}

def gron-list [list] {
  $list
  | enumerate
  | each {|row|
    {
      key: $"[($row.index)]",
      value: $row.item
    }
  }
  | prepend { value: [] }
}

def gron-primative [prefix primative] {
  [ [key value]; [$prefix $primative] ]
}
