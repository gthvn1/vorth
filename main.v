fn main() {
	prog := [Ops(Push{12}), Ops(Push{30}), Ops(Add{}), Ops(Pop{})]
	prog.run()
}
