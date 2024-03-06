// https://forth-standard.org/standard/core
import log

fn (ops []Ops) interpret() {
	mut s := init_stack()

	for op in ops {
		match op {
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
			Dot { // a --
				if v := s.pop() {
					println(v)
				} else {
					log.error('Empty stack...')
				}
			}
			Push { // -- a
				s.push(op.v)
			}
		}
	}
}