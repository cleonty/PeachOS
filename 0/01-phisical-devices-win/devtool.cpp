#define WIN32_LEAN_AND_MEAN
#include <windows.h>

#include <iostream>

int main(int argc, char **argv)
{

  char physical[65536];
  char logical[65536];

  if (argc > 1)
  {
    for (int i = 1; i < argc; i++)
    {
      QueryDosDevice(argv[i], logical, sizeof(logical));
      std::cout << argv[i] << " : \t" << logical << std::endl;
    }
    return 0;
  }

  QueryDosDevice(NULL, physical, sizeof(physical));

  std::cout << "devices: " << std::endl;

  for (char *pos = physical; *pos; pos += strlen(pos) + 1)
  {
    QueryDosDevice(pos, logical, sizeof(logical));
    std::cout << pos << " : \t" << logical << std::endl;
  }

  return 0;
}