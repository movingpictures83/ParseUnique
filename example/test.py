def test(file1, file2):
   firstfile = open(file1, 'r')
   secondfile = open(file2, 'r')
   lines1 = []
   lines2 = []
   for line in firstfile:
      lines1.append(line)
   for line in secondfile:
      lines2.append(line)

   if len(lines1) != len(lines2):
      return False

   for i in range(0, len(lines1)):
      if (lines1[i] not in lines2):
            print(lines1[i])
            return False

   return True    
