vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO nmoinvaz/minizip
    REF 2.10.0
    SHA512 8717e00242ba4f8247ef60c925813bcfaf104243cdbfff4cca690e7c1f7da1132084e1b939b3adf1f019d220a1034f46f2fe2a543cca19106af5136e09d6af16
    HEAD_REF master
    PATCHES
        fix-zstd.patch
        fix-lzma.patch
        name.patch
)

vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        compat MZ_COMPAT
        zlib MZ_ZLIB
        bzip2 MZ_BZIP2
        lzma MZ_LZMA
        zstd MZ_ZSTD
        pkcrypt MZ_PKCRYPT
        wzaes MZ_WZAES
        libcomp MZ_LIBCOMP
        openssl MZ_OPENSSL
        brg MZ_BRG
        signing MZ_SIGNING
        compress_only MZ_COMPRESS_ONLY
        decompress_only MZ_DECOMPRESS_ONLY
        file32_api MZ_FILE32_API
)

vcpkg_configure_cmake(
        SOURCE_PATH ${SOURCE_PATH}
        PREFER_NINJA
        OPTIONS
            ${FEATURE_OPTIONS}
            -DMZ_LIBBSD=OFF
            -DMZ_PROJECT_SUFFIX=fork
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/minizipfork TARGET_PATH share/minizipfork)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/minizipfork RENAME copyright)
