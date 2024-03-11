const false_value = i64(0) // all bits set to 0
const true_value = i64(0xffffffffffffffff) // all bits set to 1

struct Add {}

struct Divmod {}

struct Dot {}

struct Dup {}

struct Eq {}

// Greater than
struct Gth {}

// Lower than
struct Lth {}

struct False {}

struct Neq {}

struct Not {}

struct Mul {}

struct Push {
	v i64
}

struct Sub {}

struct Swap {}

struct True {}

type Token = Add
	| Divmod
	| Dot
	| Dup
	| Eq
	| False
	| Gth
	| Lth
	| Mul
	| Neq
	| Not
	| Push
	| Sub
	| Swap
	| True
