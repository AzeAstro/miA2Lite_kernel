mkdir out
export PATH="/home/atlas_co/miA2Lite/toolchain/clang/bin:/home/atlas_co/miA2Lite/toolchain/gcc32/bin:/home/atlas_co/miA2Lite/toolchain/gcc/bin:$PATH"
export out=out


make O=$out daisy_nethunter_defconfig

make -j"$(nproc --all)" \
        O=out \
    CC="ccache clang" \
    CXX="ccache clang++" \
    AR="ccache llvm-ar" \
    AS="ccache llvm-as" \
    NM="ccache llvm-nm" \
    LD="ccache ld.lld" \
    STRIP="ccache llvm-strip" \
    OBJCOPY="ccache llvm-objcopy" \
    OBJDUMP="ccache llvm-objdump"\
    OBJSIZE="ccache llvm-size" \
    READELF="ccache llvm-readelf" \
        CROSS_COMPILE=aarch64-linux-gnu- \
        CROSS_COMPILE_ARM32=arm-linux-gnueabi-

$out/scripts/sign-file sha512 $out/certs/signing_key.pem $out/certs/signing_key.x509 $out/drivers/net/wireless/realtek/rtl8188eus/8188eu.ko

