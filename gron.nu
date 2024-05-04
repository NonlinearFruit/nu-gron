export def main [object] {
  match ($object | describe) {
    "string" => ([ [value]; [$object] ]),
    "int" => [ [value]; [$object] ],
    _ => ($object | transpose key value | prepend { value: {} })
  }
}
