# FFMPEG_BUILD_SCRIPT

# Troubleshooting
This page lists solutions to problems you might encounter with this Script..


## recompile with -fPIC
```
requires dynamic R_X86_64_PC32 reloc against 'ff_pw_1023' 
which may overflow at runtime; recompile with -fPIC
```

I had this problem when building FFMPEG static libraries (e.g. libavcodec.a) for Android ARM64 target platform (using Android NDK clang).

When producing arm64 static library (e.g. libavcodec.a) it looks like assembler files (e.g. libavcodec/h264_qpel_10bit.asm) uses some x86 (32bit) assembler commands which are incompatible when statically linking with x86-64 bit target library since they don't support required relocation type.

### Possible solutions 

1. if you're building a shared library but need to link with static libavcodec

1-1. you may need to force PIC support (with --enable-pic during FFmpeg configure)

1-2. add the following option to your project LDFLAGS:

```
-Wl,-Bsymbolic

```
In case of cmake:

```
set(CMAKE_SHARED_LINKER_FLAGS "-Wl,-Bsymbolic")

```

2. compile all ffmpeg files with no assembler optimizations (for ffmpeg this is configure option: --disable-asm)
 
3. produce dynamic libraries (e.g. libavcodec.so) and link them in your final library dynamically


