ROOTDIR=$(realpath $(pwd)/../..)
ChatAFLDIR=$(realpath $(pwd)/../../ChatAFL)
export PATH=${PATH}:${ChatAFLDIR}
export AFLNET=${ChatAFLDIR}
perf record -g -- ${AFLNET}/afl-fuzz -d -i $AFLNET/tutorials/live555/in-rtsp -o out-live555 -N tcp://127.0.0.1/8554 -x $AFLNET/tutorials/live555/rtsp.dict -P RTSP -D 10000 -q 3 -s 3 -E -K -R ${WORKDIR}/live5555/testProgs/testOnDemandRTSPServer 8554