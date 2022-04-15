#!/bin/bash

steamcmd_dir="/root/steamcmd" #Steam安装目录

install_dir="/root/DSTserver" #饥荒安装目录

cluster_name="Cluster_2"

dontstarve_dir="/root/.klei/DoNotStarveTogether"

function fail()

{

        echo Error: "$@" >&2

        exit 1

}

function check_for_file()

{

    if [ ! -e "$1" ]; then

            fail "Missing file: $1"

    fi

}

cd "$steamcmd_dir" || fail "Missing $steamcmd_dir directory!"

check_for_file "steamcmd.sh"

check_for_file "$dontstarve_dir/$cluster_name/cluster.ini"

check_for_file "$dontstarve_dir/$cluster_name/cluster_token.txt"

check_for_file "$dontstarve_dir/$cluster_name/Master/server.ini"

check_for_file "$dontstarve_dir/$cluster_name/Caves/server.ini"

check_for_file "$install_dir/bin"

cd "$install_dir/bin" || fail

run_shared=(./dontstarve_dedicated_server_nullrenderer)

run_shared+=(-console)

run_shared+=(-cluster "$cluster_name")

run_shared+=(-monitor_parent_process $$)

run_shared+=(-shard)

"${run_shared[@]}" Caves | sed 's/^/Caves: /' &

"${run_shared[@]}" Master | sed 's/^/Master: /' 