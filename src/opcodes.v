struct Push {
	v u8
}

struct Add {}

struct Sub {}

struct Dot {}

type Ops = Add | Dot | Push | Sub

fn get_ops(s string) []Ops {
	mut o := []Ops{}

	for word in s.split(' ') {
		// Skip white spaces
		if word.is_blank() {
			continue
		}

		// Otherwise check if it is a known opcode
		if word.is_int() {
			// An item on the stack is an u8 so assert that for now
			assert word.int() < 256
			o << Ops(Push{u8(word.int())})
		} else if word.compare('+') == 0 {
			o << Ops(Add{})
		} else if word.compare('.') == 0 {
			o << Ops(Dot{})
		} else {
			println('Cannot not found ops for ${word}')
		}
	}

	return o
}
