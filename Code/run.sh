#!/bin/bash

CURRDIR=$(pwd)


if [ $# -eq 0 ]; then
  echo "Usage: ./run < main command > [arg1 ... argn]" 
  echo "This script runs everything"
  echo "The main commands and arguments are:"
  echo -e "\t proofOfConcept"
  echo -e "\t createAnn <save Name>"
  echo -e "\t displayAnn <image Name>"
  echo ""
  echo -e "\t train <starting ANN> <save file> <DIRECTORY of graphs>"
  echo -e "\t test <starting ANN> <save file> <DIRECTORY of graphs>"
  echo -e "\t cover <starting ANN> <save file> <DIRECTORY of graphs>"
  echo ""
  echo -e "\t generate <n> <alpha> <p> <r> <save file>"
  echo ""
  echo -e "\t convert <DIIMACS Graph>"
  echo ""
  echo -e "\t runHybrid <graph file>"
  echo ""
  echo -e "\t runGreedy <algoNumber [1 .. 4]> <graph file>"
  echo "All of these options are explained in the Dissertation and all output is directed here where possible."
  exit
fi
SELECTION=$1

case $SELECTION in
'proofOfConcept')
  cd ANN/
  java Driver -p > logProof
  mv logProof proofOfConcept.ann ..
  cd ..
  mv /tmp/testRes* .
  ;;
'createAnn')
  if [ $# -eq 2 ]; then
    file=$2
    cd ANN/
    java Driver -m $file
    mv file".vcGraph" ..
    cd ..
  fi
  ;;
'displayANN')
  if [ $# -eq 2 ]; then
    file=$CURRDIR"/"$2
    cd ANN/
    java Driver -l $file
    neato -Tps -Kdot annOut.dot > $file".eps" 
    mv $file".eps" ..
    cd ..
  fi
  ;;
'train')
  if [ $# -eq 4 ]; then
    inFile=$CURRDIR"/"$2
    outFile=$3
    graphDirect=$CURRDIR"/"$4
    cd ANN/
    java TestHarness -train $inFile $outFile $graphDirect | grep 'Abs\|Percentage\|Validation'
    echo "training logs and files can be found in the directory of $4"
  fi
  ;;
'test')
  if [ $# -eq 4 ]; then
    inFile=$CURRDIR"/"$2
    outFile=$3
    graphDirect=$CURRDIR"/"$4
    cd ANN/
    java TestHarness -test $inFile $outFile $graphDirect | grep 'Abs\|Percentage\|Validation\|Test'
    echo "files can be found in the directory of $4"
  fi
  ;;
'cover')
  if [ $# -eq 4 ]; then
    inFile=$CURRDIR"/"$2
    outFile=$3
    graphDirect=$CURRDIR"/"$4
    cd ANN/
    java TestHarness -cover $inFile $outFile $graphDirect | grep 'Vertex\|Time' 
  fi
  ;;
'generate')
  if [ $# -eq 6 ]; then
    N=$2
    ALPHA=$3
    P=$4
    R=$5
    FILE=$6
    cd Generator/
    java Driver $N $ALPHA $P $R $FILE > genLog
    mv genLog $FILE".vcGraph" ..
  fi
  ;;
'convert')
  if [ $# -eq 2 ]; then
    GRAPH=$CURRDIR"/"$2
    cd Graph/
    java DimacsConverter $GRAPH
    mv $GRAPH".vcGraph" ..
  fi
  ;;
'runHybrid')
  if [ $# -eq 2 ]; then
    GRAPH=$CURRDIR"/"$2
    cd Hybrid/
    java Driver $GRAPH | grep Vertex 
  fi
  ;;
'runGreedy')
  if [ $# -eq 3 ]; then
    CHOICE=$2
    GRAPH=$CURRDIR"/"$3
    cd VCPNew/
    java Driver $CHOICE $GRAPH
  fi
  ;;
esac



