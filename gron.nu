export def main [object] {
  match ($object | describe) {
    $record if $record =~ ^record => ($object | transpose key value | prepend { value: {} }),
    $list if $list =~ ^list => ($object | enumerate | each {|row| { key: $"[($row.index)]", value: $row.item }} | prepend { value: [] }),
    _ => [ [value]; [$object] ],
  }
}

