#include <unistd.h>

void dump(unsigned long long value) {
  char buf[32];
  unsigned int buf_size = 0;
  unsigned int index = 31; // point to last because we fill the buffer by its end

  // Start by adding \n
  buf[index] = '\n';
  index --;
  buf_size ++;

  do {
    buf[index] = (value % 10) + '0';
    value /= 10;
    buf_size ++;
    index--;
  } while (value);

  write(1, &buf[index + 1], buf_size);
}

int main() {
  dump(1234);
  dump(0);
  return 0;
}
