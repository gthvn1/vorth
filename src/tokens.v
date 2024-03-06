struct Add {}

struct Dot {}

struct False {
	v int
}

struct Push {
	v int
}

struct Sub {}

struct True {
	v int
}

type Token = Add | Dot | False | Push | Sub | True
