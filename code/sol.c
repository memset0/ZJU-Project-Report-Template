#include <math.h>
#include <stdio.h>
#include <string.h>

int main() {
  int T, a, b;
  scanf("%d", &T);
  while (T--) {
    scanf("%d%d", &a, &b);
    printf("%d\n", a + b); // Here is the comment.
  }
  return 0;
}