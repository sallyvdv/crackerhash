<<'SETUP'
Script to automate password cracking using hashcat. Best results from a good targeted wordlist.
The targeted list consists of previous passwords and specialized words associated with the organization..
Consider using DigiNinja's 'cewl' to generate a wordlist: https://github.com/digininja/CeWl
     cewl -d 3 --with-numbers -u "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; WOW64; Trident/6.0)" -w \
     targeted.txt -v http://company.com
Also consider adding: 
  1. Variations on the company name
  2. Current season and year e.g., Winter19
  3. Company city
  4. Account names
  5. Users first names
  6. Users last names
  7. Creds from public data breaches
  8. Local sports teams

Other Analysis Options
After running through the script feed the password list to PACK (Password Analysis and Cracking Kit)
  to generate masks based on most common password formats found.
  https://github.com/iphelix/pack
    example:
	Generate a mask stats from cracked passwords and then generate a list of masks sorted by occurrence
	 $ python statsgen.py acme-passwords.txt -o acme-passwords.masks
	 $ python maskgen.py acme-passwords.masks --outputmasks=acme.masks --occurrence
	 $ cat acme.masks
	 ?u?l?l?l?l?l?d?d?s
     ?u?l?l?l?l?l?d?d
	     <snipped>
     ?u?l?l?l?l?d?d?s
     ?u?l?l?l?l?l?l?d?d?s
You can use these masks in mask attacks like this:
$binary -O -a 3 --session $sess -m $hashtype $hashes -1 ?u?l ?u?1?1?1?1?1?a?a --potfile-path $potfile
SETUP

#Assign variables
wordlist1="/path/to/targeted.txt"
wordlist2="/path/to/wordlists/crackstation.txt"
hashes="/path/to/company-hashes.ntds"
potfile="/path/to/company.pot"
sess="session1"
binary="/path/to/hashcat64.bin" 
hashtype="1000"

# When finished cracking grab usernames and passwords together:
# $binary -m $hashtype --show --username --potfile-path $potfile  $hashes | cut -f1,3 -d":"
<<'LM_Hashes'
# Uncomment if you have LM hashes
# First crack any LM hashes
$binary -O -a 3 --session $sess -m 3000 $hashes ?a?a?a?a?a?a?a --increment --potfile-path $potfile
LM_Hashes
# Wordlist Attack and Hybrid Attack - Wordlist1
# Try each word from wordlist1 (targeted wordlist)
# Try 1,2,3 characters at end of word.
# Try 1,2,3 characters at the beginning of the word
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --potfile-path $potfile
$binary -O -a 6 --session $sess -m $hashtype $hashes $wordlist1 ?a?a?a --increment --potfile-path $potfile
$binary -O -a 7 --session $sess -m $hashtype $hashes ?a?a?a $wordlist1 --increment --potfile-path $potfile

# Rule Attack
# Try wordlist1 with all the rules
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/dive.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/d3ad0ne.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/best64.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/generated2.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/generated.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles1.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/leetspeak.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/Incisive-leetspeak.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/unix-ninja-leetspeak.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles2.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles3.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles4.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles5.rule --potfile-path $potfile

# Rule Attack
# Try the targeted wordlist with each rule + toggles1
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/dive.rule --rules ~/tools/rules/toggles1.rule  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/d3ad0ne.rule --rules ~/tools/rules/toggles1.rule  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/best64.rule --rules ~/tools/rules/toggles1.rule  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/generated2.rule --rules ~/tools/rules/toggles1.rule  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/generated.rule --rules ~/tools/rules/toggles1.rule  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles1.rule --rules ~/tools/rules/toggles1.rule   --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/leetspeak.rule --rules ~/tools/rules/toggles1.rule  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/Incisive-leetspeak.rule --rules ~/tools/rules/toggles1.rule  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/unix-ninja-leetspeak.rule --rules ~/tools/rules/toggles1.rule  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles2.rule --rules ~/tools/rules/toggles1.rule  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles3.rule --rules ~/tools/rules/toggles1.rule  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles4.rule --rules ~/tools/rules/toggles1.rule  --potfile-path $potfile

# Try the targeted wordlist with each rule + toggles2
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/dive.rule --rules ~/tools/rules/toggles2.rule  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/d3ad0ne.rule --rules ~/tools/rules/toggles2.rule  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/best64.rule --rules ~/tools/rules/toggles2.rule  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/generated2.rule --rules ~/tools/rules/toggles2.rule  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/generated.rule --rules ~/tools/rules/toggles2.rule  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles1.rule --rules ~/tools/rules/toggles2.rule   --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/leetspeak.rule --rules ~/tools/rules/toggles2.rule  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/Incisive-leetspeak.rule --rules ~/tools/rules/toggles2.rule  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/unix-ninja-leetspeak.rule --rules ~/tools/rules/toggles2.rule  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles2.rule --rules ~/tools/rules/toggles2.rule  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles3.rule --rules ~/tools/rules/toggles2.rule  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles4.rule --rules ~/tools/rules/toggles2.rule  --potfile-path $potfile

# Try the targeted wordlist with each rule + toggles1 and add an exclamation point at the end of each guess
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/dive.rule --rules ~/tools/rules/toggles1.rule -j '$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/d3ad0ne.rule --rules ~/tools/rules/toggles1.rule -j '$!'  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/best64.rule --rules ~/tools/rules/toggles1.rule  -j '$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/generated2.rule --rules ~/tools/rules/toggles1.rule  -j '$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/generated.rule --rules ~/tools/rules/toggles1.rule  -j '$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles1.rule --rules ~/tools/rules/toggles1.rule  -j '$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/leetspeak.rule --rules ~/tools/rules/toggles1.rule  -j '$!'  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/Incisive-leetspeak.rule --rules ~/tools/rules/toggles1.rule  -j '$!'  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/unix-ninja-leetspeak.rule --rules ~/tools/rules/toggles1.rule  -j '$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles2.rule --rules ~/tools/rules/toggles1.rule  -j '$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles3.rule --rules ~/tools/rules/toggles1.rule  -j '$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles4.rule --rules ~/tools/rules/toggles1.rule  -j '$!' --potfile-path $potfile

# Try the targeted wordlist with each rule + toggles2 and add an exclamation point at the end of each guess
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/dive.rule --rules ~/tools/rules/toggles2.rule -j '$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/d3ad0ne.rule --rules ~/tools/rules/toggles2.rule -j '$!'  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/best64.rule --rules ~/tools/rules/toggles2.rule  -j '$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/generated2.rule --rules ~/tools/rules/toggles2.rule  -j '$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/generated.rule --rules ~/tools/rules/toggles2.rule  -j '$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles1.rule --rules ~/tools/rules/toggles2.rule  -j '$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/leetspeak.rule --rules ~/tools/rules/toggles2.rule  -j '$!'  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/Incisive-leetspeak.rule --rules ~/tools/rules/toggles2.rule  -j '$!'  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/unix-ninja-leetspeak.rule --rules ~/tools/rules/toggles2.rule  -j '$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles2.rule --rules ~/tools/rules/toggles2.rule  -j '$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles3.rule --rules ~/tools/rules/toggles2.rule  -j '$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles4.rule --rules ~/tools/rules/toggles2.rule  -j '$!' --potfile-path $potfile

# Try the targeted wordlist with each rule + toggles1 and add an exclamation point at the beginning of each guess
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/dive.rule --rules ~/tools/rules/toggles1.rule -j '^!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/d3ad0ne.rule --rules ~/tools/rules/toggles1.rule -j '^!'  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/best64.rule --rules ~/tools/rules/toggles1.rule  -j '^!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/generated2.rule --rules ~/tools/rules/toggles1.rule  -j '^!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/generated.rule --rules ~/tools/rules/toggles1.rule  -j '^!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles1.rule --rules ~/tools/rules/toggles1.rule  -j '^!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/leetspeak.rule --rules ~/tools/rules/toggles1.rule  -j '^!'  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/Incisive-leetspeak.rule --rules ~/tools/rules/toggles1.rule  -j '^!'  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/unix-ninja-leetspeak.rule --rules ~/tools/rules/toggles1.rule  -j '^!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles2.rule --rules ~/tools/rules/toggles1.rule  -j '^!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles3.rule --rules ~/tools/rules/toggles1.rule  -j '^!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles4.rule --rules ~/tools/rules/toggles1.rule  -j '^!' --potfile-path $potfile

# Try the targeted wordlist with each rule + toggles2 and add an exclamation point at the beginning of each guess
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/dive.rule --rules ~/tools/rules/toggles2.rule -j '^!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/d3ad0ne.rule --rules ~/tools/rules/toggles2.rule -j'^!'  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/best64.rule --rules ~/tools/rules/toggles2.rule  -j '^!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/generated2.rule --rules ~/tools/rules/toggles2.rule  -j '^!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/generated.rule --rules ~/tools/rules/toggles2.rule  -j '^!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles1.rule --rules ~/tools/rules/toggles2.rule  -j '^!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/leetspeak.rule --rules ~/tools/rules/toggles2.rule  -j '^!'  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/Incisive-leetspeak.rule --rules ~/tools/rules/toggles2.rule  -j '^!'  --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/unix-ninja-leetspeak.rule --rules ~/tools/rules/toggles2.rule  -j '^!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles2.rule --rules ~/tools/rules/toggles2.rule  -j '^!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles3.rule --rules ~/tools/rules/toggles2.rule  -j '^!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles4.rule --rules ~/tools/rules/toggles2.rule  -j '^!' --potfile-path $potfile
# 
# Try the second wordlist straight and then with character masks before and after each word.
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --potfile-path $potfile
$binary -O -a 6 --session $sess -m $hashtype $hashes $wordlist2 ?a?a --increment --potfile-path $potfile
$binary -O -a 7 --session $sess -m $hashtype $hashes ?a?a $wordlist2 --increment --potfile-path $potfile

# Try the second wordlist with each rule. By default the dive rule is commented out. It can take a long time if using dictionary like crackstation. Uncomment accordingly.
# $binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --rules ~/tools/rules/dive.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --rules ~/tools/rules/d3ad0ne.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --rules ~/tools/rules/best64.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --rules ~/tools/rules/generated2.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --rules ~/tools/rules/generated.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --rules ~/tools/rules/toggles1.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --rules ~/tools/rules/leetspeak.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --rules ~/tools/rules/Incisive-leetspeak.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --rules ~/tools/rules/unix-ninja-leetspeak.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --rules ~/tools/rules/toggles2.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --rules ~/tools/rules/toggles3.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --rules ~/tools/rules/toggles4.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --rules ~/tools/rules/toggles5.rule --potfile-path $potfile

# Try wordlist2 with each rule + toggles1. By default the dive rule is commented out. It can take a long time if using dictionary like crackstation. Uncomment accordingly.
# $binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/dive.rule --rules ~/tools/rules/toggles1.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/d3ad0ne.rule --rules ~/tools/rules/toggles1.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/best64.rule --rules ~/tools/rules/toggles1.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/generated2.rule --rules ~/tools/rules/toggles1.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/generated.rule --rules ~/tools/rules/toggles1.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles1.rule --rules ~/tools/rules/toggles1.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/leetspeak.rule --rules ~/tools/rules/toggles1.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/Incisive-leetspeak.rule --rules ~/tools/rules/toggles1.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/unix-ninja-leetspeak.rule --rules ~/tools/rules/toggles1.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles2.rule --rules ~/tools/rules/toggles1.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles3.rule --rules ~/tools/rules/toggles1.rule --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist1 --rules ~/tools/rules/toggles4.rule --rules ~/tools/rules/toggles1.rule --potfile-path $potfile

# Try wordlist2 with each rule + toggles1 and add an exclamation point at the end of each guess. By default the dive rule is commented out. It can take a long time. Uncomment accordingly.
# $binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --rules ~/tools/rules/dive.rule --rules ~/tools/rules/toggles1.rule -j'$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --rules ~/tools/rules/d3ad0ne.rule --rules ~/tools/rules/toggles1.rule -j'$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --rules ~/tools/rules/best64.rule --rules ~/tools/rules/toggles1.rule -j'$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --rules ~/tools/rules/generated2.rule --rules ~/tools/rules/toggles1.rule -j'$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --rules ~/tools/rules/generated.rule --rules ~/tools/rules/toggles1.rule -j'$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --rules ~/tools/rules/toggles1.rule --rules ~/tools/rules/toggles1.rule -j'$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --rules ~/tools/rules/leetspeak.rule --rules ~/tools/rules/toggles1.rule -j'$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --rules ~/tools/rules/Incisive-leetspeak.rule --rules ~/tools/rules/toggles1.rule -j'$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --rules ~/tools/rules/unix-ninja-leetspeak.rule --rules ~/tools/rules/toggles1.rule -j'$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --rules ~/tools/rules/toggles2.rule --rules ~/tools/rules/toggles1.rule -j'$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --rules ~/tools/rules/toggles3.rule --rules ~/tools/rules/toggles1.rule -j'$!' --potfile-path $potfile
$binary -O -a 0 --session $sess -m $hashtype $hashes $wordlist2 --rules ~/tools/rules/toggles4.rule --rules ~/tools/rules/toggles1.rule -j'$!' --potfile-path $potfile

# Combinator attack using two wordlists. You can also create a combined wordlist from multiple dictionaries  with 'combinator.bin list1 list2 list3 > combined.dic' 
$binary -O -a 1 --session $sess -m $hashtype $hashes $wordlist1 $wordlist2 --potfile-path $potfile

# Combinator attack using two wordlists and add a character at the end of the second word.
$binary -O -a 1 --session $sess -m $hashtype $hashes $wordlist1 $wordlist2 -k'$!' --potfile-path $potfile
$binary -O -a 1 --session $sess -m $hashtype $hashes $wordlist1 $wordlist2 -k'$#' --potfile-path $potfile
$binary -O -a 1 --session $sess -m $hashtype $hashes $wordlist1 $wordlist2 -k'$$' --potfile-path $potfile
$binary -O -a 1 --session $sess -m $hashtype $hashes $wordlist1 $wordlist2 -k'$&' --potfile-path $potfile
$binary -O -a 1 --session $sess -m $hashtype $hashes $wordlist1 $wordlist2 -k'$.' --potfile-path $potfile
$binary -O -a 1 --session $sess -m $hashtype $hashes $wordlist1 $wordlist2 -k'$*' --potfile-path $potfile
$binary -O -a 1 --session $sess -m $hashtype $hashes $wordlist1 $wordlist2 -k'$ ' --potfile-path $potfile

# Combinator attack using two wordlists and add a character at the end of the first word.
$binary -O -a 1 --session $sess -m $hashtype $hashes $wordlist1 $wordlist2 -j'$!' --potfile-path $potfile
$binary -O -a 1 --session $sess -m $hashtype $hashes $wordlist1 $wordlist2 -j'$#' --potfile-path $potfile
$binary -O -a 1 --session $sess -m $hashtype $hashes $wordlist1 $wordlist2 -j'$$' --potfile-path $potfile
$binary -O -a 1 --session $sess -m $hashtype $hashes $wordlist1 $wordlist2 -j'$&' --potfile-path $potfile
$binary -O -a 1 --session $sess -m $hashtype $hashes $wordlist1 $wordlist2 -j'$.' --potfile-path $potfile
$binary -O -a 1 --session $sess -m $hashtype $hashes $wordlist1 $wordlist2 -j'$*' --potfile-path $potfile
$binary -O -a 1 --session $sess -m $hashtype $hashes $wordlist1 $wordlist2 -j'$ ' --potfile-path $potfile

# Combinator attack using two dictionaries and a rule on the second word
$binary -O -a 1 --session $sess -m $hashtype $hashes $wordlist1 $wordlist1 --rule-right ~/tools/rules/dive.rule
$binary -O -a 1 --session $sess -m $hashtype $hashes $wordlist2 $wordlist1 --rule-right ~/tools/rules/d3ad0ne.rule

# Hybrid Mask Attack Appending and Prending 4 characters
$binary -O -a 6 --session $sess -m $hashtype $hashes $wordlist1 ?a?a?a?a --potfile-path $potfile
$binary -O -a 7 --session $sess -m $hashtype $hashes ?a?a?a?a $wordlist1 --potfile-path $potfile

# Brute Force Attack
# Brute force up to 7 characters
$binary -O -a 3 --session $sess -m $hashtype $hashes ?a?a?a?a?a?a?a --increment --potfile-path $potfile

# Mask Attack
# Brute force mask attack with 8 then 9 chars using masks because pure brute-force will take too long
$binary -O -a 3 --session $sess -m $hashtype $hashes -1 ?u?l ?u?1?1?1?1?1?a?a --potfile-path $potfile
$binary -O -a 3 --session $sess -m $hashtype $hashes ?u?l?l?l?l?l?l?a?a --increment --potfile-path $potfile



