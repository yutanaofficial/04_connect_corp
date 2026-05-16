#!/usr/bin/env bash

topo="clab-04_connect_corp"

testping() {
  # echo -n "Ping $1  -> $2  "
  dest=$2
  docker exec -it $topo-$1 ping -c1 -W1 ${!dest} > /dev/null
  if [ $? -eq 0 ]; then echo -n "   ok    "; else echo -e -n " \033[31m FAIL \033[0m  "; fi
}

pingall() {
  nodes=$1
  # Create Header Line
  echo -n "         "
  for dest in ${nodes}; do
  printf "%-9s" ${dest}
  done
  echo ""
  #
  # Now go through each source
  for source in ${nodes}; do
    printf "%-9s" ${source}
    for dest in ${nodes}; do
      if [ ${source} = ${dest} ]; then
        echo -n "-------  "
      else
        testping ${source} ${dest}
      fi
    done
    echo ""
  done 
}

nodes="as1_h1   as1_h2   as2_h1   as3_h1   as4_h1   as5_h1   as6_h1   as7_h1   as8_h1   as9_h1   as100_h1 as100_h2 as100_h3 as100_h4"

echo "Ping from each Host to each other host"
echo ""
echo "IPv4:"
as1_h1="201.0.0.2"
as1_h2="201.0.1.10"
as2_h1="202.0.0.2"
as3_h1="203.0.0.2"
as4_h1="204.0.0.2"
as5_h1="205.0.0.2"
as6_h1="206.0.0.2"
as7_h1="207.0.0.2"
as8_h1="208.0.0.2"
as9_h1="209.0.0.2"
as100_h1="209.1.1.2"
as100_h2="209.1.1.3"
as100_h3="209.1.2.2"
as100_h4="209.1.2.3"
pingall "${nodes}"
#
echo ""
echo "IPv6:"
as1_h1="2000:1111:1:fffe::1000"
as1_h2="2000:1111:1:ffff::1000"
as2_h1="2000:2222:2:ffff::1000"
as3_h1="2000:3333:3:ffff::1000"
as4_h1="2000:4444:4:ffff::1000"
as5_h1="2000:5555:5:ffff::1000"
as6_h1="2000:6666:6:ffff::1000"
as7_h1="2000:7777:7:ffff::1000"
as8_h1="2000:8888:8:ffff::1000"
as9_h1="2000:9999:9:ffff::1000"
as100_h1="2000:9999:1000:1::100"
as100_h2="2000:9999:1000:1::200"
as100_h3="2000:9999:1000:2::100"
as100_h4="2000:9999:1000:2::200"

pingall "${nodes}"

