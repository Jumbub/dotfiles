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

function devcontainerDelete {
  local label="$(basename "$(pwd)")"
  local container_id=$(docker ps -aq --filter "label=devcontainer.local_folder=$(pwd)")
  if [ -z "$container_id" ]; then
    echo "No devcontainer found for $label"
    return 1
  fi
  echo "Removing devcontainer for $label ($container_id)"
  docker rm -f "$container_id"
}

function dcd {
  devcontainerDelete
}

function dcu {
  devcontainerUp || devcontainerUpNew
}
