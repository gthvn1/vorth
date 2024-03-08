# Implement a concatenative language

## Description

- Influenced by:
    - [Tsoding Porth](https://www.youtube.com/playlist?list=PLpM-Dvs8t0VbMZA7wW9aR3EtBqe2kinu4)
    - [Forth](https://forth-standard.org/)
    - [Uxn](https://wiki.xxiivv.com/site/uxn.html)

- run: `v run . -c -i examples/arithmetic.vforth`
    - `-c` is to compile the code. That means you can run the test: `./examples/arithmetic`
- or with debug logs: `v run . -c -i -d 5 examples/arithmetic.vforth`

- List of operators

| Operators | stack state            |
| --------- | ---------------------- |
| +         | a b -- (a + b)         |
| divmod    | a b -- (a / b) (a % b) |
| dot       | a --                   |
| dup       | a -- a a               |
| =         | a b -- Flag            |
| *         | a b -- (a * b)         |
| <integer> | -- a                   |
| -         | a b -- (a - b)         |
| swap      | a b -- b a             |

```v
~/devel/vlang-forth master*
❯ v run . -c -i -d 5 examples/arithmetic.vforth
log level is set to 5
2024-03-08 22:05:41.692216 [DEBUG] ==== LOADING PROGRAM
2024-03-08 22:05:41.692242 [DEBUG] // arithmetic.vforth
2024-03-08 22:05:41.692245 [DEBUG]
2024-03-08 22:05:41.692249 [DEBUG] 12 30 + .      // should print 42
2024-03-08 22:05:41.692251 [DEBUG] 6 9 - .        // should print -3
2024-03-08 22:05:41.692254 [DEBUG] 12 dup + .     // should print 24
2024-03-08 22:05:41.692256 [DEBUG] 15 10 - .      // should print 5
2024-03-08 22:05:41.692258 [DEBUG] 15 10 swap - . // should print -5
2024-03-08 22:05:41.692261 [DEBUG] 5 dup mul .    // it is the square operation, 25
2024-03-08 22:05:41.692264 [DEBUG] 8 0 3 - * .    // should print -24
2024-03-08 22:05:41.692267 [DEBUG] 117 17 divmod . . // 117 17 -- 6 15
2024-03-08 22:05:41.692270 [DEBUG]                   // where 6 is the quotient and 15 the reminder
2024-03-08 22:05:41.692275 [DEBUG]                   // So should print 15 6
2024-03-08 22:05:41.692278 [DEBUG]
2024-03-08 22:05:41.692287 [DEBUG] ==== PROGRAM LOADED
42
-3
24
5
-5
25
-24
15
6

~/devel/vlang-forth master*
❯ ./examples/arithmetic
42
-3
24
5
-5
25
-24
15
6
```

- others examples are not all ready. Check comments in the files.

## Goals

- [x] start with simples instructions to do arithmetic
- [x] compile code
- [x] update lexer to recognize `true`, `false`, `eq`, `neq`
- [ ] implement new tokens ^^
- [x] allow comments
- [ ] add if
- [ ] add loop
- [ ] what else to be Turing complete?
    - [ ] Run [Game Of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life) to prove the Turing completeness

## Changelog

### 2024-03-07
- Add `Eq`, `Dup`, `Swap`, `Mul`, `Divmod`

### 2024-03-06
- Add `False` and `True`
- Update lexer to recognize identifiers
- Generate code for `+`, `-`, `.`.
    - So we can print result of addition and substraction
- Compile an hello world program

### 2024-03-05
- Add a minimal help
- Read the code from `arithmetic.vforth` and print the result
- Replace `Pop` by `Dot` to be more like Forth and translate string to ops
- Add operations: `Add`, `Sub`, `Push` and `Pop`
- First implement a stack in [V](https://github.com/vlang/v/blob/master/doc/docs.md)
