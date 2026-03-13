# Git Exercises
### master
```bash
git verify
```
***
### commit-one-file
```bash
git add A.txt
git commit -m "initial commit"
git verify
```
***
### commit-one-file-staged
```bash
git restore --staged A.txt
git commit -m "initial commit"
git verify
```
***
### ignore-them
```bash
touch .gitignore
vim .gitignore
```
edited .gitignore to be
```
*.exe
*.o
*.jar
libraries/
```
and then ran 
```bash
git add .
git commit -m "initial commit"
git verify
```
***
### chase-branch
```bash
git checkout chase-branch
git merge escaped
git verify
```
***
### merge-conflict
```bash
git merge another-piece-of-work
vim equation.txt           
```
and equation.txt initially looks like 
```txt
<<<<<<< HEAD
2 + ? = 5
=======
? + 3 = 5
>>>>>>> another-piece-of-work
```
which is changed to 
```
2 + 3 = 5
```
#and then continue with 
```bash
git add .
git commit -m "Initial commit"
git verify
```
***
### save-your-work
```bash
git stash
vim bug.txt
#and removing the line with BUG
git add .
git commit -m "Initial commit"
git stash pop
vim bug.txt
```
adding the "finally finished it" line
```bash
git add .
git commit -m "Initial commit"
git verify
```
***
### change-branch-history
```bash
git rebase hot-bugfix
git verify
```
***
### remove-ignored
```bash
git rm ignored.txt
git status
git commit -m "Initial commit"
git verify
```
***
### case-sensitive-filename
```bash
git mv File.txt file.txt
git commit -m "Initial commit"
git verify
```
***
### fix-typo
```bash
vim file.txt
# change "Wordl" to "World" in file.txt
git add .
git commit --amend
```
change the commit message from `Add Hello Wordl` to `Add Hello World`
***
### forge-date
```bash
git reset --mixed HEAD~1
git add .
git commit -m "work on time" --date "Fri Mar 13 16:54:02 1987 +0100"
git verify
```
***
### fix-old-typo
```bash
git rebase -i HEAD~2
# change the file from first commit from "pick" to "edit"
vim file.txt
# change the "Wordl" to "World"
git add .
git commit --amend
git rebase --continue
# resolve merge conflict
vim file.txt
git add .
git rebase --continue
git verify
```