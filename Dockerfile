FROM ubuntu:devel as base
RUN apt update --fix-missing
RUN apt upgrade -y
RUN apt install -y build-essential curl cmake python libfmt-dev git valgrind
RUN curl -L https://github.com/llvm/llvm-project/archive/llvmorg-8.0.1.tar.gz | tar xz

FROM base
RUN mkdir -p llvm-project-llvmorg-8.0.1/llvm/build && \
		cd llvm-project-llvmorg-8.0.1/llvm/build && \
		cmake -DLLVM_ENABLE_THREADS=OFF -DLLVM_BUILD_LLVM_DYLIB=ON -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_BUILD_TYPE=RelWithDebInfo .. && \
		cmake --build . -- -j$(nproc) && \
		cmake --build . -- install && \
		cd ../../.. && rm -r llvm-project-llvmorg-8.0.1

FROM base
RUN mkdir -p llvm-project-llvmorg-8.0.1/llvm/build && \
		cd llvm-project-llvmorg-8.0.1/llvm/build && \
		cmake -DLLVM_ENABLE_THREADS=OFF -DLLVM_BUILD_LLVM_DYLIB=ON -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_BUILD_TYPE=Debug .. && \
		cmake --build . -- -j$(nproc) && \
		cmake --build . -- install
