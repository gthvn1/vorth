# Implement a concatenative language

## Description

- Influenced by:
    - [Tsoding Porth](https://www.youtube.com/playlist?list=PLpM-Dvs8t0VbMZA7wW9aR3EtBqe2kinu4)
    - [Forth](https://forth-standard.org/)
    - [Uxn](https://wiki.xxiivv.com/site/uxn.html)

- run: `v run . -c -i examples/arithmetic.fs`
    - `-c` is to compile the code. That means you can run the test: `./examples/arithmetic`
- or with debug logs: `v run . -c -i -d 5 examples/arithmetic.fs`

```sh
~/devel/vlang-forth master*
❯ v run . -c -i -d 5 examples/arithmetic.fs
log level is set to 5
2024-03-08 18:02:11.195028 [DEBUG] ==== LOADING PROGRAM
2024-03-08 18:02:11.195047 [DEBUG] 12 30 + .
2024-03-08 18:02:11.195051 [DEBUG] 6 9 - .
2024-03-08 18:02:11.195054 [DEBUG]
2024-03-08 18:02:11.195057 [DEBUG] ==== PROGRAM LOADED
42
-3

~/devel/vlang-forth master*
❯ ./examples/arithmetic
42
-3
```

- others examples are not running yet.

## Goals

- [x] start with simples instructions to do arithmetic
- [x] compile code
- [x] update lexer to recognize `true`, `false`, `eq`, `neq`
- [ ] implement new tokens ^^
- [ ] allow comments
- [ ] add if
- [ ] add loop
- [ ] what else to be Turing complete?
    - [ ] Run [Game Of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life) to prove the Turing completeness

## Changelog

### 2024-03-07
- Add `Eq`

### 2024-03-06
- Add `False` and `True`
- Update lexer to recognize identifiers
- Generate code for `+`, `-`, `.`.
    - So we can print result of addition and substraction
- Compile an hello world program

### 2024-03-05
- Add a minimal help
- Read the code from `arithmetic.fs` and print the result
- Replace `Pop` by `Dot` to be more like Forth and translate string to ops
- Add operations: `Add`, `Sub`, `Push` and `Pop`
- First implement a stack in [V](https://github.com/vlang/v/blob/master/doc/docs.md)
