export def main [object] {
  match ($object | describe) {
    $record if $record =~ ^record => ($object | transpose key value | prepend { value: {} }),
    _ => [ [value]; [$object] ],
  }
}
