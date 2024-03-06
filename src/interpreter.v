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
			False {
				s.push(tok.v)
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
				s.push(tok.v)
			}
		}
	}
}
