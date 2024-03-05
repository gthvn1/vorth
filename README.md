# Implement a concatenative language

- run: `v run . -i src/test1.fs`

**Changelog**

- Add a minimal help
- Read the code from `test1.fs` and print the result
- Replace `Pop` by `Dot` to be more like Forth and translate string to ops
- Add operations: `Add`, `Sub`, `Push` and `Pop`
- First implement a stack in [V](https://github.com/vlang/v/blob/master/doc/docs.md)
