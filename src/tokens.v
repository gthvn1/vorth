const false_value = i64(0) // all bits set to 0
const true_value = i64(0xffffffffffffffff) // all bits set to 1

struct Add {}

struct Dot {}

struct False {
	v i64
}

struct Push {
	v i64
}

struct Sub {}

struct True {
	v i64
}

type Token = Add | Dot | False | Push | Sub | True
