# crackerhash

What is it?
===========
This is a script to automate password cracking using Hashcat. 

Quick Start
------------
Grab the script, unpack it and define variables at the top of the script.

Requirements
------------
Hashcat
Password dictionary such rockyou or crackstation

Usage
-----
Open the script and define the variables.
 
wordlist1="/path/to/targeted-wordlist.txt"
wordlist2="/path/to/crackstation.txt"
hashes="/path/to/company-hashes.ntds"
potfile="/path/to/company.pot"
sess="session1"
binary="/path/to/hashcat64.bin"

You will get the best results if you spend a little time up front creating a good targeted wordlist.
The targeted list consists of previous passwords and specialized words associated with the organization..
Consider using DigiNinja's 'cewl' to generate a wordlist: https://github.com/digininja/CeWl
     cewl -d 3 -u "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; WOW64; Trident/6.0)" -w \
     targeted.txt -v http://company.com
Also consider adding: 
* Variations on the company name
* Current season and year e.g., Winter19
* Company city
* Account names
* Users first names
* Creds from public data breaches
* Local sports teams

Run the script:
./crackerhash.sh


