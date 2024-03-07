const false_value = i64(0) // all bits set to 0
const true_value = i64(0xffffffffffffffff) // all bits set to 1

struct Add {}

struct Dot {}

struct Eq {}

struct False {}

struct Push {
	v i64
}

struct Sub {}

struct True {}

type Token = Add | Dot | Eq | False | Push | Sub | True
