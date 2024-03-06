struct Push {
	v int
}

struct Add {}

struct Sub {}

struct Dot {}

type Token = Add | Dot | Push | Sub
