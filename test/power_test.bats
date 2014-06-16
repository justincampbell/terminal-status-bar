load test_helper

@test "power displays a power plug when plugged-in" {
  fixture "pmset" "pmset-charged"
  run $tmux_status_bar -p

  [ $output = " 🔌 " ]
  [ $status -eq 0 ]
}

@test "power is quiet when plugged-in" {
  fixture "pmset" "pmset-charged"
  run $tmux_status_bar -q -p

  [ -z $output ]
  [ $status -eq 0 ]
}

@test "power displays a battery and time remaining while discharging" {
  fixture "pmset" "pmset-discharging-with-estimate"
  run $tmux_status_bar -p

  [ $output = " ~1:23 🔋 " ]
  [ $status -eq 0 ]
}

@test "power is not quiet while discharging" {
  fixture "pmset" "pmset-discharging-with-estimate"
  run $tmux_status_bar -q -p

  [ $output = " ~1:23 🔋 " ]
  [ $status -eq 0 ]
}

@test "power displays a battery and question marks while still calculating" {
  fixture "pmset" "pmset-discharging"
  run $tmux_status_bar -p

  [ $output = " ~?:?? 🔋 " ]
  [ $status -eq 0 ]
}

@test "power displays a red exclamation point with less than an hour left" {
  fixture "pmset" "pmset-low"
  run $tmux_status_bar -p

  [ $output = " ~0:12 ❗️🔋 " ]
  [ $status -eq 0 ]
}
