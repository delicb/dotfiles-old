extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)  tar -jxvf "$1"                        ;;
      *.tar.gz)   tar -zxvf "$1"                        ;;
      *.bz2)      bunzip2 "$1"                          ;;
      *.dmg)      hdiutil mount "$1"                    ;;
      *.gz)       gunzip "$1"                           ;;
      *.tar)      tar -xvf "$1"                         ;;
      *.tbz2)     tar -jxvf "$1"                        ;;
      *.tgz)      tar -zxvf "$1"                        ;;
      *.zip)      unzip "$1"                            ;;
      *.ZIP)      unzip "$1"                            ;;
      *.pax)      cat "$1" | pax -r                     ;;
      *.pax.Z)    uncompress "$1" --stdout | pax -r     ;;
      *.Z)        uncompress "$1"                       ;;
      *) echo "'$1' cannot be extracted/mounted via extract()" ;;
    esac
  else
     echo "'$1' is not a valid file to extract"
  fi
}

func using_port() {
    lsof -n -i:$1 | grep LISTEN
}

#gfmt() {
#    echo "Running gofmt"
#    gofmt -l -s -w $(find . -type f -name '*.go' -not -path "./vendor/*")
#    echo "Running goimports"
#    goimports -l -w $(find . -type f -name '*.go' -not -path "./vendor/*")
#}

venv() {
    local venvs_root
    venvs_root=~/venvs
    if [[ -z $1 ]]; then
        echo "Usage: venv <NAME>"
        return 1
    fi
    if [[ $1 == "off" ]]; then
        echo "param if off"
        deactivate
        return 0
    fi

    if [[ -d $venvs_root/$1 ]]; then

        if [[ -f $venvs_root/$1/bin/activate ]]; then
            VIRTUAL_ENV_DISABLE_PROMPT=1 source $venvs_root/$1/bin/activate
        else
            echo "Folder ~/venvs/$1 exists, but does not seem to be valid virtual environment"
            return 2
        fi
    else
        echo "Venv $1 does not exist. For now - create it manually."
    fi
}

venv "$@"
