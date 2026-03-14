# Bandit Wargame
### Level 0 - Level 1
```bash
ssh bandit0@bandit.labs.overthewire.org -p 2220
# and type the password "bandit0" to pass
```
password: `ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If`
### Level 1 - Level 2
```bash
ls
cat ./-
```
password: `263JGJPfgU6LtdEvgfWU1XP5yac29mFx`
### Level 2 - Level 3
```bash
ls
cat ./"--spaces in this filename--"
```
password: `MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx`
### Level 3 - Level 4
```bash
ls
cd inhere/
ls -a
cat ...Hiding-From-You
```
password: `2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ`
### Level 4 - Level 5
```bash
ls
cd inhere/
for i in {0..9}; do echo "file0$i :"; cat ./"-file0$i"; echo "" ; done
```
it returns 
```
file00 :
?=
I?? ??V`n?5???ѳ??*?G^7؅cO?
file01 :
???0?w?8???q????Y???d??ZCF??+
file02 :
???	L????Q?.??`/??r
?P{
file03 :
???????1'?JV????,??2??
                      f?=????
file04 :
??us???*??w??Z ??Ї|??@?Sq-
file05 :
W?cF???[Q
?
 ??a~??\0?ed(??ڨW
file06 :
?z=J"??oyv>aC???	;?
file07 :
4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw

file08 :
Z???I??$ȩ?D??d???B~o?
file09 :
BG????`@J??eD֍?l?\???`?
```
password: `4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw`
### Level 5 - Level 6
```bash
ls
cd inhere/
```
```bash
for i in {00..19}
do
    echo "maybehere$i"
    cd "maybehere$i"/
    ls -l -a
    cd ..
    echo
done
```
in the output we can find 
`-rw-r-----  1 root bandit5 1033 Oct 14 09:26 .file2`

password:
`HWasnPhtq9AVKe0dmk45nxy20cvUa6EG`
### Level 6 - Level 7
```bash
ls -l -a
cd /
find . -user bandit7 -group bandit6 -size 33c
```
there we find a `./var/lib/dpkg/info/bandit7.password` which has password
```bash
cat ./var/lib/dpkg/info/bandit7.password
```
password: `morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj`
### Level 7 - Level 8
```bash
ls -l -a
grep "millionth" data.txt 
```
asnwer comes out to be `millionth	dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc`
password:
`dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc`
### Level 8 - Level 9
```bash
ls -l -a
cat data.txt | sort | uniq -u
```
password: `4CKMh1JI91bUIZZPXDqGanal4xvAg0JM`
### Level 9 - Level 10
```bash
ls -l -a
vim data.txt
# found the password manually (ik not the intended soltion)
```
```bash
grep --binary-files=text "==" data.txt
# intended solutiom
```
password: `FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey`
### Level 10 - Level 11
```bash
cat data.txt | base64 -d 
```
output:- 
```
The password is dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr
```
### Level 11 - Level 12
```bash
cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
```
output :- 
```bash
The password is 7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4
```
### Level 12 - Level 13
```bash
mktemp-d
# creates /tmp/tmp.u1AdRsURZL
touch "/tmp/tmp.u1AdRsURZL/hexdumprevert"
xxd -r data.txt > "/tmp/tmp.u1AdRsURZL/hexdumprevert"
cat "/tmp/tmp.u1AdRsURZL/hexdumprevert"
file "/tmp/tmp.u1AdRsURZL/hexdumprevert"
# gives that its a gzip compressed file
mv "/tmp/tmp.u1AdRsURZL/hexdumprevert" "/tmp/tmp.u1AdRsURZL/hexdumprevert.gz"
gunzip "/tmp/tmp.u1AdRsURZL/hexdumprevert.gz"
cd "/tmp/tmp.u1AdRsURZL"
ls
file hexdumprevert
# gives that its a bzip2 compressed file
mv hexdumprevert hexdumprevert.bz2
bunzip2 hexdumprevert.bz2 
ls
file hexdumprevert 
# gives that its a gzip compressed file
mv hexdumprevert hexdumprevert.gz
gunzip hexdumprevert.gz
file hexdumprevert 
# gives that its a tar compressed file
mv hexdumprevert hexdumprevert.tar
tar -xf hexdumprevert.tar 
ls
file data5.bin 
# gives that its a tar compressed file
cp data5.bin data5.tar
tar -xf data5.tar 
ls
file data6.bin 
# gives that its a bzip2 compressed file
mv data6.bin data6.bz2
bunzip2 data6.bz2 
ls
file data6
# gives that its a tar compressed file
mv data6 data6.tar
tar -xf data6.tar 
ls
file data8.bin
# gives that its a gzip compressed file
mv data8.bin data8.gz
gunzip data8.gz
ls
file data8
# gives that its a ASCII text
cat data8
```
output :- 
```
The password is FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn
```
### Level 13 - Level 14
```bash
ls
cat sshkey.private
# copy the contents and paste in local
exit
touch sshkey.private
vim sshkey.private
chmod 600 sshkey.private 
ssh -i sshkey.private bandit14@bandit.labs.overthewire.org -p 2220
```
### Level 14 - Level 15
password for this level : `MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS`
```bash
nc localhost 30000
```
submit password for this level and get passwrod for this level 
password: `8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo`
### Level 15 - Level 16
```bash
openssl s_client -connect localhost:30001
```
password: `kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx`
### Level 16 - Level 17
```bash
for i in {31000..32000}; do 
    nc -z localhost $i
    if [$? == 0]; then
        echo $i
    fi
done
```
it gave me ports 
`31046, 31518, 31691, 31790, 31960`
for each try `openssl s_client -ign_eof localhost:port`
for 31790 it gives an RSA key
store it in a file and chmod 600 it
`ssh -i key bandit17@bandit.labs.overthewire.org -p 2220
`
### Level 17 - Level 18
```bash
diff --normal passwords.new  passwords.old 
```
output :-
```
42c42
< x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO
---
> pGozC8kOHLkBMOaL0ICPvLV1IjQ5F1VA
```
password for next level is: `x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO`
### Level 18 - Level 19
```bash
scp -P 2220 bandit18@bandit.labs.overthewire.org:/home/bandit18/readme .
cat readme 
```
password: `cGWpMaKXVwDUNgPAVJbWYuGHVn9zl3j8`
### Level 19 - Level 20
```bash
./bandit20-do cat /etc/bandit_pass/bandit20
```
password: `0qXahG8ZjOVMN9Ghs7iOWsCfZyXOUbYO`