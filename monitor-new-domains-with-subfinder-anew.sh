while true;
do
  # For cohere.ai
  subfinder -silent -dL target1.txt -all | anew target1subs.txt | notify -bulk -pc ./providers.yaml
  # For cohere.com
  subfinder -silent -dL target2.txt -all | anew target2subs.txt | notify -bulk -pc ./providers.yaml
 sleep 3600;
done

# run script as a systemd service file
