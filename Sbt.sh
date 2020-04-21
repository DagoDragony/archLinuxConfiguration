#!/usr/bin/zsh

plugins='addSbtPlugin("net.virtual-void" % "sbt-dependency-graph" % "0.10.0-RC1")'
sbtPaths=(
  "$HOME/.sbt/0.13/plugins/plugins.sbt"
  "$HOME/.sbt/1.0/plugins/plugins.sbt"
)

for p in $sbtPaths
do
  echo "Writing to $p";
  mkdir -p "${p:h}"
  echo $plugins > $p
done