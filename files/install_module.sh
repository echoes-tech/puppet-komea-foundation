#!/bin/bash

module=""
version=""
environment="development"

display_help() {
  echo
  echo "This might help you:"
  echo "$(basename "$0") [-h] [-e] -m -v -- script to install a puppet module in a specific environment with sudo."
  echo
  echo "   -h Displays this help"
  echo "   -e Optionnal: specifies the environment where the module will be installed"
  echo "      Default value: $environment"
  echo "   -m The name of the module to install"
  echo "   -v The version of the module to install"
}


while getopts ':h:e:m:v:' option; do
  case "$option" in
    h) display_help
       exit
       ;;
    e) environment="$OPTARG"
       ;;
    m) module="$OPTARG"
       ;;
    v) version="$OPTARG"
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       display_help >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       display_help >&2
       exit 1
       ;;
  esac
done
shift $((OPTIND - 1))

if [ "$version" == "" ]; then
  echo
  echo "Version should not be empty."
  display_help
  exit 1
fi

if [ "$module" == "" ]; then
  echo
  echo "Module name should not be empty."
  display_help
  exit 1
fi

if [ ! -d /etc/puppet/environments/$environment ]; then
   sudo mkdir /etc/puppet/environments/$environment
fi
sudo puppet module install --environment $environment --modulepath /etc/puppet/environments/$1/modules --version $version $module
