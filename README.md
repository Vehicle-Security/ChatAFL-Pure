A clean ChatAFL codebase, decoupled from container configurations. 

### Getting Start

Since AFL can only work on LLVM-12 or earlier version, we use ubuntu 20.04.   

To support higher version LLVM, please see https://github.com/QUICTester/QUIC-Fuzz/blob/main/aflnet/llvm_mode/afl-llvm-pass.so.cc   


1. Install deps:   
```
sudo bash deps.sh
```

2. Set up LLM:  
Edit [`ChatAFL/chat-llm-conf.h`](ChatAFL/chat-llm-conf.h) to add your API.  


#### Start Fuzzing
See [live5555-demo](Run/live5555/README.md)


### Dev

1. develop and debug with vscode   


2. profile with perf  
```
# set ChatAFL to O2

# gen flamegraph  
cd Run/live5555
bash perf.sh
```

