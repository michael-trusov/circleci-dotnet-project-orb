#!/bin/bash
#shellcheck disable=all

apt update && apt upgrade -y
apt install -y default-jre
apt update && apt install -y openssh-client