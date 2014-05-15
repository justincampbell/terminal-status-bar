load test_helper

@test "power displays a power plug when plugged-in" {
  stub "pmset"
  run $tmux_status_bar -p

  echo $output | grep " 🔌 "
  [ $status -eq 0 ]
}

@test "power displays a battery and time remaining while discharging" {
  stub "pmset" "echo '-InternalBattery-0 99%; discharging; 9:41 remaining'"
  run $tmux_status_bar -p

  [ $output = " ~9:41 🔋 " ]
  [ $status -eq 0 ]
}

@test "power displays a battery and question marks while still calculating" {
  stub "pmset" "echo '-InternalBattery-0 99%; discharging; (no'"
  run $tmux_status_bar -p

  [ $output = " ~?:?? 🔋 " ]
  [ $status -eq 0 ]
}

@test "power displays a red exclamation point with less than an hour left" {
  stub "pmset" "echo '-InternalBattery-0 20%; discharging; 0:59 remaining'"
  run $tmux_status_bar -p

  echo $output | grep " ~0:59 ❗️🔋 "
  [ $status -eq 0 ]
}
