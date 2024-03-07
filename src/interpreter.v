// https://forth-standard.org/standard/core
import log

fn (tokens []Token) interpret() {
	mut s := init_stack()

	for tok in tokens {
		match tok {
			Add { // a b -- a + b
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
			Dot { // a --
				if v := s.pop() {
					println(v)
				} else {
					log.error('Empty stack...')
				}
			}
			Eq { // a b -- Flag
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
			Push { // -- a
				s.push(tok.v)
			}
			Sub { // a b -- a - b
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
			True {
				s.push(true_value)
			}
		}
	}
}
