import log

const memory_size = 1024

fn (tokens []Token) interpret() ! {
	mut s := init_stack()
	mut mem := [memory_size]i64{}

	mut token_idx := 0

	for {
		tok := tokens[token_idx]

		match tok {
			Add { // a b -- (a + b)
				b := s.pop() or { return error('Add: first pop failed') }
				a := s.pop() or { return error('Add: second pop failed') }
				s.push(a + b)
			}
			Divmod { // a b -- (a / b) (a % b)
				b := s.pop() or { return error('Divmod: first pop failed') }
				if b == 0 {
					return error('Divmod: Cannot divide by 0')
				}
				a := s.pop() or { return error('Divmod: second pop failed') }
				s.push(a / b)
				s.push(a % b)
			}
			Do {
				// flag --
				f := s.pop() or { return error('Do: empty stack') }
				if f == false_value {
					token_idx = tok.out + 1 // jump right after the end
					continue
				}
			}
			Done {
				token_idx = tok.begin // into the while
				continue
			}
			Dot { // a --
				if v := s.pop() {
					println(v)
				} else {
					log.warn('Empty stack...')
				}
			}
			Dup { // a -- a a
				a := s.pop() or { return error('Dup: empty stack') }
				s.push(a)
				s.push(a)
			}
			Else {
				// --
				// we just need to skip the else part
				token_idx = tok.out // jump at the end that does nothing so don't
				// need to jump after
				continue
			}
			Eq {
				// a b -- Flag
				// (True if a == b, False otherwise)
				b := s.pop() or { return error('Eq: first pop failed') }
				a := s.pop() or { return error('Eq: second pop failed') }
				if a == b {
					s.push(true_value)
				} else {
					s.push(false_value)
				}
			}
			End {
				// --
				// Nothing to do. It is just a label for the IF or ELSE block
			}
			False {
				s.push(false_value)
			}
			Gth {
				// a b -- Flag
				// (True if a > b, False otherwise)
				b := s.pop() or { return error('Gth: first pop failed') }

				a := s.pop() or { return error('Gth: second pop failed') }

				if a > b {
					s.push(true_value)
				} else {
					s.push(false_value)
				}
			}
			If {
				// flag --
				f := s.pop() or { return error('If: empty stack') }
				if f == false_value {
					token_idx = tok.out + 1 // jump right after the end
					continue
				}
			}
			Load {
				// addr -- mem[addr]
				addr := s.pop() or { return error('Store: failed to read address') }
				s.push(mem[addr])
			}
			Lth {
				// a b -- Flag
				// (True if a < b, False otherwise)
				b := s.pop() or { return error('Lth: first pop failed') }

				a := s.pop() or { return error('Lth: second pop failed') }

				if a < b {
					s.push(true_value)
				} else {
					s.push(false_value)
				}
			}
			Mul { // a b -- (a * b)
				b := s.pop() or { return error('Mul: first pop failed') }
				a := s.pop() or { return error('Mul: second pop failed') }
				s.push(a * b)
			}
			Not {
				// Flag -- not Flag
				f := s.pop() or { return error('Neg: empty stack') }
				if f == false_value {
					s.push(true_value)
				} else if f == true_value {
					s.push(false_value)
				} else {
					log.error('Neg: not a flag')
					break
				}
			}
			Neq {
				// a b -- Flag
				// (True if a != b, False otherwise)
				b := s.pop() or { return error('Neq: first pop failed') }
				a := s.pop() or { return error('Neq: second pop failed') }
				if a != b {
					s.push(true_value)
				} else {
					s.push(false_value)
				}
			}
			Push { // -- a
				s.push(tok.v)
			}
			Store {
				// val addr --
				addr := s.pop() or { return error('Store: failed to read address') }
				val := s.pop() or { return error('Store: failed to read value') }
				if addr >= memory_size {
					return error('memory overflow')
				}
				mem[addr] = val
			}
			Sub { // a b -- (a - b)
				b := s.pop() or { return error('Sub: first pop failed') }
				a := s.pop() or { return error('Sub: second pop failed') }
				s.push(a - b)
			}
			Swap { // a b -- b a
				b := s.pop() or { return error('Swap: empty stack') }
				a := s.pop() or { return error('Swap: missing second argument') }
				s.push(b)
				s.push(a)
			}
			True {
				s.push(true_value)
			}
			While {
				// --
				// Nothing to do. It is an anchor for the done
			}
		}

		token_idx += 1
		if token_idx >= tokens.len {
			break
		}
	}
}
