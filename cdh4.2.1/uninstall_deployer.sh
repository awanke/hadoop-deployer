#!/usr/bin/env bash
# coding=utf-8
# Author: zhaigy@ucweb.com
# Data:   2013-01

DIR=`cd $(dirname $0);pwd`
. $DIR/support/PUB.sh

# $0 host
undeploy()
{
  ssh $USER@$1 "
    cd $D;
    . support/PUB.sh;

    . support/deployer_profile.sh;
    unprofile;

    if [ \"$ME\" != \"\`hostname\`\" ]; then
      cd ..;
      rm -rf $D;
    fi;
  "
}

main()
{
  cd $DIR

  show_head;

  for s in $NODES; do
    [ ! -f "logs/install_deployer_ok_$s" ] && continue
    same_to $s $DIR
    echo ">> undeploy $s"
    undeploy $s
    rm -f "logs/install_deployer_ok_$s"
    echo ">>"
  done

  rm -f logs/install_deployer_ok

  echo ">> OK"
  cd $OLD_DIR
}

#==========
main
