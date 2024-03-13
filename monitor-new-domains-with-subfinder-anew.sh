while true;
do subfinder -silent -dL $DOMAINSFILE -all | anew subdomains.txt | notify
  sleep 3600;
done
