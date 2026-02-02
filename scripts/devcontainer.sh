function devcontainerExec {
  devcontainer exec \
    --workspace-folder . \
    --remote-env THIS_ENVIRONMENT_LABEL="$(basename `pwd`)" \
    -- $@
}

function devcontainerUp {
  devcontainer up \
    --workspace-folder . \
    --expect-existing-container
}

function devcontainerUpNew {
  source ~/secrets/devcontainer.sh

  devcontainer up \
    --workspace-folder . \
    --remove-existing-container

  source ~/secrets/devcontainer.sh

  devcontainerExec bash -s << EOF
    git config --global core.editor "vi"
    git config --global url."https://james-bray:$EVT_GITHUB_TOKEN@github.eagleview.com".insteadOf "https://github.eagleview.com"
EOF
}

function dc {
  if [ "$#" -ne "0" ]; then
    devcontainerExec $@
  else
    devcontainerExec bash
  fi
}

function dcu {
  devcontainerUp || (devcontainerUpNew && devcontainerExecNew)
}