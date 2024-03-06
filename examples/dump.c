#include <unistd.h>

void dump(long long value) {
  char buf[32];
  unsigned int buf_size = 0;
  unsigned int index = 31; // we fill the buffer by its end
  long long absv;

  // Start by adding \n
  buf[index] = '\n';
  index--;
  buf_size++;

  if (value < 0) {
    absv = -value;
  } else {
    absv = value;
  }

  do {
    buf[index] = (absv % 10) + '0';
    absv /= 10;
    buf_size++;
    index--;
  } while (absv);

  if (value < 0) {
    buf[index] = '-';
    buf_size++;
    index--;
  }

  write(1, &buf[index + 1], buf_size);
}

int main() {
  dump(1234);
  dump(0);
  dump(-4321);
  return 0;
}
