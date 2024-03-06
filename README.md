# Implement a concatenative language

## Description

- Influenced by:
    - [Tsoding Porth](https://www.youtube.com/playlist?list=PLpM-Dvs8t0VbMZA7wW9aR3EtBqe2kinu4)
    - [Forth](https://forth-standard.org/)
    - [Uxn](https://wiki.xxiivv.com/site/uxn.html)

- run: `v run . -c -i examples/test1.fs`
    - `-c` is to compile the code. That means you can run the test: `./examples/test1`
- or with debug logs: `v run . -c -i -d 5 examples/test1.fs`

```v
~/devel/vlang-forth master*
❯ v run . -c -i -d 5 examples/test1.fs
log level is set to 5
2024-03-06 18:00:33.977985 [DEBUG] ==== LOADING PROGRAM
2024-03-06 18:00:33.978006 [DEBUG] 12 30 + .
2024-03-06 18:00:33.978010 [DEBUG] 9 6 + .
2024-03-06 18:00:33.978015 [DEBUG] ? =
2024-03-06 18:00:33.978019 [DEBUG] true false
2024-03-06 18:00:33.978023 [DEBUG]
2024-03-06 18:00:33.978026 [DEBUG] ==== PROGRAM LOADED
2024-03-06 18:00:33.978034 [WARN ] Cannot not found token for < ? >
2024-03-06 18:00:33.978037 [WARN ] Cannot not found token for < = >
2024-03-06 18:00:33.978043 [WARN ] Found identifier < true > but it is not yet implemented
2024-03-06 18:00:33.978047 [WARN ] Found identifier < false > but it is not yet implemented
42
15
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
