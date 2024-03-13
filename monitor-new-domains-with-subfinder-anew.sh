while true;
do subfinder -silent -dL domains.txt -all | anew subdomains.txt | notify
  sleep 3600;
done
