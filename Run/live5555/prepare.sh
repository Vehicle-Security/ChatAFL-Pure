WORKDIR=$(pwd)
ROOTDIR=$(realpath $(pwd)/../..)
ChatAFLDIR=$(realpath $(pwd)/../../ChatAFL)

# echo $ChatAFLDIR

# build ChatAFL 
# rm -rf ${ChatAFLDIR}/afl-fuzz
if [ ! -f ${ChatAFLDIR}/afl-fuzz ]; then
	cd ${ChatAFLDIR} 
	make clean all -j
	cd llvm_mode && make -j
fi

# for coverage analysis
if [ ! -d ${WORKDIR}/live-gcov ]; then
	# patch code
	# tar -zxvf live.2023.05.10.tar.gz -C ${WORKDIR}/live-gcov --strip-components=1
	git clone https://github.com/rgaufman/live555.git live-gcov
	cd ${WORKDIR}/live-gcov
	git checkout ceeb4f4
	patch -p1 < ${ROOTDIR}/subjects/RTSP/Live555/gcov.patch
	./genMakefiles linux
fi
if [ ! -f ${WORKDIR}/live-gcov/testProgs/testRTSPClient ]; then
	# compile code
	cd ${WORKDIR}/live-gcov
	make CFLAGS="-fprofile-arcs -ftest-coverage" CPPFLAGS="-fprofile-arcs -ftest-coverage" \
		 CXXFLAGS="-fprofile-arcs -ftest-coverage" LDFLAGS="-fprofile-arcs -ftest-coverage" clean all -j
fi

# for fuzzing test
if [ ! -d ${WORKDIR}/live5555 ]; then
	# fetch code
	mkdir -p ${WORKDIR}/live5555
	git clone https://github.com/rgaufman/live555.git live5555
	cd ${WORKDIR}/live5555
	git checkout ceeb4f4
	patch -p1 < ${ROOTDIR}/subjects/RTSP/Live555/fuzzing.patch
	./genMakefiles linux
fi
# rm -rf ${WORKDIR}/live5555/testProgs/testOnDemandRTSPServer
if [ ! -f ${WORKDIR}/live5555/testProgs/testOnDemandRTSPServer ]; then 
	cd ${WORKDIR}/live5555
	export ASAN_OPTIONS='abort_on_error=1:symbolize=0:detect_leaks=0:detect_stack_use_after_return=1:detect_container_overflow=0:poison_array_cookie=0:malloc_fill_byte=0:max_malloc_fill_size=16777216'
	export AFL_PATH=${ChatAFLDIR}
	export AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES=1
	export AFL_SKIP_CPUFREQ=1
	export AFL_NO_AFFINITY=1
	export PATH=${PATH}:${ChatAFLDIR}
	AFL_USE_ASAN=1 make clean all -j || make all -j
fi
