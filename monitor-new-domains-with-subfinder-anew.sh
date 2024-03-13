while true;
  # For cohere.ai
  subfinder -silent -dL target1.txt -all | anew target1subs.txt | notify
  # For cohere.com
  subfinder -silent -dL target2.txt -all | anew target2subs.txt | notify
 sleep 3600;
done
