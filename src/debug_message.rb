def debug_init(flag)
  $DEBUG_FLAG = flag
end
def debug_message(*bodies)
  if ( $DEBUG_FLAG )
    printf("%s:", Time.now.strftime("%Y/%m/%d %H:%M:%S"))
    bodies.each do | body |
      printf("%s", body.to_s)
    end
    printf("\n")
  end
end
def debug_input(func, body)
  if ( $DEBUG_FLAG )
    printf("%s:%s ----\n%s\n", Time.now.strftime("%Y/%m/%d %H:%M:%S"),
           func, body)
    printf("%s:----\n", Time.now.strftime("%Y/%m/%d %H:%M:%S"))
  end
end
def debug_output(res)
  if ( $DEBUG_FLAG )
    printf("%s:%s\n", Time.now.strftime("%Y/%m/%d %H:%M:%S"),
           res.to_s)
    printf("%s:----\n", Time.now.strftime("%Y/%m/%d %H:%M:%S"))
  end
end
def debug_error(error, trace)
  if ( $DEBUG_FLAG )
    printf("%s:%s ----\n%s\n", Time.now.strftime("%Y/%m/%d %H:%M:%S"),
           error,
           trace.join("\n"))
    printf("%s:----\n", Time.now.strftime("%Y/%m/%d %H:%M:%S"))
  end
end
