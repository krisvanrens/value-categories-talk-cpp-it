#include <cstdio>

#define LOG puts(__PRETTY_FUNCTION__)

struct T
{
  T()                     { LOG; }
  ~T()                    { LOG; }
  T(const T &)            { LOG; }
  T &operator=(const T &) { LOG; return *this; }
  T(T &&)                 { LOG; }
  T &operator=(T &&)      { LOG; return *this; }
};
