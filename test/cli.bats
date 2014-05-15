load test_helper

@test "shows help with no options" {
  run $tmux_status_bar

  echo $output | grep "tmux-status-bar"
  echo $output | grep "Options:"
  [ $status -eq 1 ]
}

@test "shows help when passed -h" {
  run $tmux_status_bar -h

  echo $output | grep "tmux-status-bar"
  echo $output | grep "Options:"
  [ $status -eq 0 ]
}

@test "displays the commands in the order they were passed in" {
  stub "pmset"
  stub "scutil"

  run $tmux_status_bar -pn
  first=$output

  run $tmux_status_bar -np
  second=$output

  [ "$first" != "$second" ]
}
