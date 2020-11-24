#include <cstdio>
#include <utility>

struct Number {
  int value_ = {};
};

class T {
public:
  T(const Number &n) : n_{n} {}

  T(const T &) { puts("Copy c'tor"); }

  Number get() { return n_; }

private:
  Number n_;
};

static T create(Number &&n) {
  return T{std::move(n)};
}

int main() {
  T x = create(Number{42});

  return x.get().value_;
}
