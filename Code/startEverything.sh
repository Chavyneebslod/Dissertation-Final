#!/bin/bash

  


  CPROOT=$(pwd)
  HYBRID=$CPROOT"/Hybrid" 
  VCP=$CPROOT"/VCPNew/Algorithms" 
  GRAPH=$CPROOT"/Graph"
  ANN=$CPROOT"/ANN"
  GEN=$CPROOT"/Generator"
  echo "Setting classpath"
  CLASSPATH=$CLASSPATH":"$HYBRID":"$VCP":"$GRAPH":"$ANN":"$GEN

  tar -xjvf code.tar.bz2

  echo "Building project"
  for x in $(ls); do
    if [ -d $x ]; then
      cd $x
      ./.build
      cd .. 
    fi
  done
