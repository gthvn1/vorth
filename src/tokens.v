const false_value = i64(0) // all bits set to 0
const true_value = i64(0xffffffffffffffff) // all bits set to 1

struct Add {}

struct Divmod {}

struct Dot {}

struct Dup {}

struct Eq {}

struct False {}

struct Mul {}

struct Push {
	v i64
}

struct Sub {}

struct Swap {}

struct True {}

type Token = Add | Divmod | Dot | Dup | Eq | False | Mul | Push | Sub | Swap | True
