const false_value = i64(0) // all bits set to 0
const true_value = i64(0xffffffffffffffff) // all bits set to 1

struct Add {}

struct Divmod {}

struct Dot {}

struct Dup {}

struct Eq {}

// End of a block
struct End {}

// Greater than
struct Gth {}

struct If {
mut:
	out int // The position in the array of tokens of the end of the if block
}

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
	| End
	| Eq
	| False
	| Gth
	| If
	| Lth
	| Mul
	| Neq
	| Not
	| Push
	| Sub
	| Swap
	| True
