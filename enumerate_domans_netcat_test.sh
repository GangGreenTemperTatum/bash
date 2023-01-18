# Bash/Shell For Loop one-line statement that iterates through the file and uses netcat to perform an outbound TCP test on port X to each of the IP's:
for i in `cat <domains>.txt`; do nc -vz ${i} <port>; done;
