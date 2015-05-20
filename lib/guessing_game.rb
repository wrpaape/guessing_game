


def display_header
  system("clear")

  3.times { puts center_message("","#") }
            puts center_message("  " + "~" * 13 + "  ","#")
            puts center_message(" ( Welcome to... ) ","#")
            puts center_message(" )     THE     ( ","#")
            puts center_message(" ( GUESSING GAME ) ","#")
            puts center_message("  " + "~" * 13 + "  ","#")
  3.times { puts center_message("","#") }

end

def center_message(message,pad_char)
  width = `tput cols`.chomp.to_i
  padding = width / 2 -  (message.length / 2)
  if message.length.even?
    pad_char * padding + message + pad_char * padding
  else
    pad_char * padding + message + pad_char * (padding - 1)
  end
end

display_header
