# Implement a concatenative language

## Description

- Influenced by:
    - [Tsoding Porth](https://www.youtube.com/playlist?list=PLpM-Dvs8t0VbMZA7wW9aR3EtBqe2kinu4)
    - [Forth](https://forth-standard.org/)
    - [Uxn](https://wiki.xxiivv.com/site/uxn.html)

- run: `v run . -c -i examples/test1.fs`
    - `-c` is to compile the code. That means you can run the test: `./examples/test1`
- or with debug logs: `v run . -c -i -d 5 examples/test1.fs`

```sh
~/devel/vlang-forth master
❯ v run . -c -i -d 5 examples/test1.fs
log level is set to 5
2024-03-06 21:59:58.202098 [DEBUG] ==== LOADING PROGRAM
2024-03-06 21:59:58.202119 [DEBUG] 12 30 + .
2024-03-06 21:59:58.202123 [DEBUG] 9 6 + .
2024-03-06 21:59:58.202127 [DEBUG] ? =
2024-03-06 21:59:58.202130 [DEBUG] true false . .
2024-03-06 21:59:58.202132 [DEBUG]
2024-03-06 21:59:58.202134 [DEBUG] ==== PROGRAM LOADED
2024-03-06 21:59:58.202141 [WARN ] Cannot not found token for < ? >
2024-03-06 21:59:58.202144 [WARN ] Cannot not found token for < = >
42
15
0
-1

~/devel/vlang-forth master
❯ ./examples/test1
42
15
0
-1
```
## Goals

- [x] start with simples instructions to do arithmetic
- [x] compile code
- [x] update lexer to recognize `true`, `false`, `eq`, `neq`
- [ ] implement new tokens ^^
- [ ] add if
- [ ] add loop
- [ ] what else to be Turing complete?
    - [ ] Run [Game Of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life) to prove the Turing completeness

## Changelog

### 2024-03-06
- Add `False` and `True`
- Update lexer to recognize identifiers
- Generate code for `+`, `-`, `.`.
    - So we can print result of addition and substraction
- Compile an hello world program

### 2024-03-05
- Add a minimal help
- Read the code from `test1.fs` and print the result
- Replace `Pop` by `Dot` to be more like Forth and translate string to ops
- Add operations: `Add`, `Sub`, `Push` and `Pop`
- First implement a stack in [V](https://github.com/vlang/v/blob/master/doc/docs.md)
