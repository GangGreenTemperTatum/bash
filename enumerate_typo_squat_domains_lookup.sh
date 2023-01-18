for i in `cat ./typo-squat-domains.txt`; do echo "Checking Domain Entry" ${i} "with WHOIS:"; whois ${i} | grep 'Registrant Organization\|Registrant
