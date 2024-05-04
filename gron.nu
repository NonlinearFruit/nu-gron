export def main [object] {
  match ($object | describe) {
    $record if $record =~ ^record => (gron-record $object),
    $list if $list =~ ^list => (gron-list $object),
    _ => (gron-primative $object),
  }
}

def gron-record [record] {
  $record
  | transpose key value
  | prepend { value: {} }
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

def gron-primative [primative] {
  [ [value]; [$primative] ]
}
