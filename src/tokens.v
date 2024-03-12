const false_value = i64(0) // all bits set to 0
const true_value = i64(0xffffffffffffffff) // all bits set to 1

struct Add {}

struct Divmod {}

struct Do {
mut:
	out int
}

struct Done {
mut:
	begin int
}

struct Dot {}

struct Dup {}

struct Else {
mut:
	out int
}

struct Eq {}

// End of a block
struct End {}

// Greater than
struct Gth {}

struct If {
mut:
	out int
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

struct While {}

type Token = Add
	| Divmod
	| Do
	| Done
	| Dot
	| Dup
	| Else
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
	| While

fn (t Token) str() string {
	return match t {
		Add { 'add' }
		Divmod { 'divmod' }
		Do { 'do:${t.out}' }
		Done { 'done:${t.begin}' }
		Dot { 'dot' }
		Dup { 'dup' }
		Else { 'else:${t.out}' }
		End { 'end' }
		Eq { 'eq' }
		False { 'false' }
		Gth { 'gth' }
		If { 'if:${t.out}' }
		Lth { 'lth' }
		Mul { 'mul' }
		Neq { 'neq' }
		Not { 'not' }
		Push { 'push:${t.v}' }
		Sub { 'sub' }
		Swap { 'swap' }
		True { 'true' }
		While { 'while' }
	}
}
