BEGIN {
  # exact rule pattern, only idProduct is variable (4 hex digits)
  rule = "^SUBSYSTEM==\"usb\",ENV\\{DEVTYPE\\}==\"usb_device\",ATTRS\\{idVendor\\}==\"1df7\",ATTRS\\{idProduct\\}==\"[0-9a-fA-F]{4}\",MODE:=\"0666\"$"
  count = 0
}
# Start only when we see the sdrplay rules heredoc
$0 ~ /66-sdrplay\.rules.*<<[[:space:]]*EOF/ { inblock=1; next }

# End at the matching EOF
inblock && $0 == "EOF" {
  exit
}

# Inside heredoc: validate and print
inblock {
  # Skip empty lines and comments (if any appear in future)
  if ($0 ~ /^[[:space:]]*$/ || $0 ~ /^[[:space:]]*#/) {
    next
  }

  if ($0 !~ rule) {
    printf("Invalid udev rule detected:\n  %s\n", $0) > "/dev/stderr"
    exit 1
  }
  count++
  print
}
END {
  if (count == 0) {
    print "No udev rules extracted" > "/dev/stderr"
    exit 1
  }
}
