function mip
  set -l grep_ip
  if ip addr | grep 192.168
    set grep_ip (ip addr | grep '192\.168')
  else
    set grep_ip (ip addr | grep '10\.0')
  end

  echo $grep_ip | awk '{print $2}' | xargs -I{} fish -c 'echo {} | pbcopy; echo {}'
end
