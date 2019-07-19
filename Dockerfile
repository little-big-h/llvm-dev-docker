FROM ubuntu:devel
RUN apt update
RUN apt upgrade -y
RUN apt install -y build-essential curl cmake python
RUN curl -L https://github.com/llvm/llvm-project/archive/llvmorg-8.0.1.tar.gz | tar xz
RUN mkdir -p llvm-project-llvmorg-8.0.1/llvm/build && \
		cd llvm-project-llvmorg-8.0.1/llvm/build && \
		cmake -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 .. && \
		cmake --build . -- -j$(nproc) && \
		cmake --build . -- install && \
		cd ../../.. && rm llvm-project-llvmorg-8.0.1
