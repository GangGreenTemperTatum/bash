# Kudos and TY to [Jason Haddix](https://www.linkedin.com/posts/jhaddix_want-a-one-liner-that-delivers-fresh-domains-activity-7069426069941989376-wDIu)
subfinder -silent -d {target}.com -o {target}
while true; do subfinder -silent -dL {target} -all -nW | anew {target} | notify; sleep 3600; done
