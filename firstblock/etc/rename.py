import sys
import os 
def renamefiles(origname, finalname):
    for file1 in os.listdir('.'):
        if origname in file1:
            f = open(file1,'r')
            contents = f.read()
            contents.replace(origname, finalname)
            f.close()
            f = open(file1,'w')
            f.write(contents)
            f.close()
            os.rename(file1, file1.replace(origname,finalname))

renamefiles(sys.argv[1], sys.argv[2])
