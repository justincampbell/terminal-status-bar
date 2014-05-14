setup() {
  TSB_TMPDIR=$BATS_TMPDIR/tsb
  TSB_STUBS=$TSB_TMPDIR/stubs
  PATH=$TSB_STUBS:$PATH

  musicfile=$TSB_TMPDIR/.music
  tmux_status_bar=$PWD/bin/tmux-status-bar

  rm -rf $TSB_TMPDIR
  mkdir -p $TSB_TMPDIR
  cd $TSB_TMPDIR
}

teardown() {
  echo $status: $output
}

stub() {
  stub=$TSB_STUBS/$1
  mkdir -p $TSB_STUBS
  echo "#!/bin/bash" > $stub
  echo "$2" >> $stub
  chmod +x $stub
}
