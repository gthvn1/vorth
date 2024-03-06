# Implement a concatenative language

- Influenced by:
    - [Tsoding Porth](https://www.youtube.com/playlist?list=PLpM-Dvs8t0VbMZA7wW9aR3EtBqe2kinu4)
    - [Forth](https://forth-standard.org/)
    - [Uxn](https://wiki.xxiivv.com/site/uxn.html)

- run: `v run . -c -i examples/test1.fs`
    - `-c` is to compile the code. That means you can run the test: `./examples/test1`

## Changelog

- Generate code for `+`, `-`, `.`.
    - So we can print result of addition and substraction
- Compile an hello world program
- Add a minimal help
- Read the code from `test1.fs` and print the result
- Replace `Pop` by `Dot` to be more like Forth and translate string to ops
- Add operations: `Add`, `Sub`, `Push` and `Pop`
- First implement a stack in [V](https://github.com/vlang/v/blob/master/doc/docs.md)
