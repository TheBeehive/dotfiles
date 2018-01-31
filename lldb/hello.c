#include <stdio.h>
#include <stdlib.h>

typedef struct node_t {
  int part1;
  int part2;
} node_t;

int func1(int var1) {
  node_t *node1;
  node1 = malloc(sizeof(node_t));
  int item = var1;
  node1->part1 = item;
  printf("this new item %i\n", item);
  return item;
}

int func2(int var2) {
  int item = var2;
  printf("this item %i\n", item);
  return item;
}

int main(int argc, char **argv) {
  int newval = func1(9);
  newval = newval + 10;
  int subtractme = func2(10);
  newval = newval - subtractme;
  return 0;
}
