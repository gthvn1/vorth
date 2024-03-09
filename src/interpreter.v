// https://forth-standard.org/standard/core
import log

fn (tokens []Token) interpret() {
	mut s := init_stack()

	for tok in tokens {
		match tok {
			Add { // a b -- (a + b)
				b := s.pop() or {
					log.error('Add: first pop failed')
					break
				}
				a := s.pop() or {
					log.error('Add: second pop failed')
					break
				}
				s.push(a + b)
			}
			Divmod { // a b -- (a / b) (a % b)
				b := s.pop() or {
					log.error('Divmod: first pop failed')
					break
				}
				if b == 0 {
					log.error('Divmod: Cannot divide by 0')
					break
				}
				a := s.pop() or {
					log.error('Divmod: second pop failed')
					break
				}
				s.push(a / b)
				s.push(a % b)
			}
			Dot { // a --
				if v := s.pop() {
					println(v)
				} else {
					log.error('Empty stack...')
				}
			}
			Dup { // a -- a a
				a := s.pop() or {
					log.error('Dup: empty stack')
					break
				}
				s.push(a)
				s.push(a)
			}
			Eq {
				// a b -- Flag
				// (True if a == b, False otherwise)
				b := s.pop() or {
					log.error('Eq: first pop failed')
					break
				}
				a := s.pop() or {
					log.error('Eq: second pop failed')
					break
				}
				if a == b {
					s.push(true_value)
				} else {
					s.push(false_value)
				}
			}
			False {
				s.push(false_value)
			}
			Gth {
				// a b -- Flag
				// (True if a > b, False otherwise)
				b := s.pop() or {
					log.error('Gth: first pop failed')
					break
				}

				a := s.pop() or {
					log.error('Gth: second pop failed')
					break
				}

				if a > b {
					s.push(true_value)
				} else {
					s.push(false_value)
				}
			}
			Lth {
				// a b -- Flag
				// (True if a < b, False otherwise)
				b := s.pop() or {
					log.error('Lth: first pop failed')
					break
				}

				a := s.pop() or {
					log.error('Lth: second pop failed')
					break
				}

				if a < b {
					s.push(true_value)
				} else {
					s.push(false_value)
				}
			}
			Mul { // a b -- (a * b)
				b := s.pop() or {
					log.error('Mul: first pop failed')
					break
				}
				a := s.pop() or {
					log.error('Mul: second pop failed')
					break
				}
				s.push(a * b)
			}
			Push { // -- a
				s.push(tok.v)
			}
			Sub { // a b -- (a - b)
				b := s.pop() or {
					log.error('Sub: first pop failed')
					break
				}
				a := s.pop() or {
					log.error('Sub: second pop failed')
					break
				}
				s.push(a - b)
			}
			Swap { // a b -- b a
				b := s.pop() or {
					log.error('Swap: empty stack')
					break
				}
				a := s.pop() or {
					log.error('Swap: missing second argument')
					break
				}
				s.push(b)
				s.push(a)
			}
			True {
				s.push(true_value)
			}
		}
	}
}
