#!/bin/bash
source $HOME/.sdkman/bin/sdkman-init.sh
sdk u gradle
gradle clean assemble
