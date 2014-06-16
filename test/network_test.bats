load test_helper

@test "network displays a network indicator when reachable" {
  stub "scutil" "echo Reachable"
  run $tmux_status_bar -n

  [ $output = " 📶 " ]
  [ $status -eq 0 ]
}

@test "network is quiet when reachable" {
  stub "scutil" "echo Reachable"
  run $tmux_status_bar -q -n

  [ -z $output ]
  [ $status -eq 0 ]
}

@test "network displays a red x when unreachable" {
  stub "scutil"
  run $tmux_status_bar -n

  [ $output = " ❗️📶 " ]
  [ $status -eq 0 ]
}

@test "network is not quiet when unreachable" {
  stub "scutil"
  run $tmux_status_bar -q -n

  [ $output = " ❗️📶 " ]
  [ $status -eq 0 ]
}
