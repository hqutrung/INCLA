int CompareLists(List<int> list1, List<int> list2) {
  int point = 0;

  for (int index = 0; index < list1.length; index++) {
    if (list1[index] == list2[index]) point++;
  }

  return point;
}
