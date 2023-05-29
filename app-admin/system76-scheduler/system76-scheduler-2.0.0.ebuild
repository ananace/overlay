# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
        aho-corasick-0.7.20
        anstream-0.3.0
        anstyle-1.0.0
        anstyle-parse-0.2.0
        anstyle-query-1.0.0
        anstyle-wincon-1.0.0
        anyhow-1.0.70
        async-broadcast-0.5.1
        async-channel-1.8.0
        async-executor-1.5.0
        async-fs-1.6.0
        async-io-1.13.0
        async-lock-2.7.0
        async-recursion-1.0.4
        async-task-4.4.0
        async-trait-0.1.68
        atoi-2.0.0
        atomic-waker-1.1.0
        autocfg-1.1.0
        bindgen-0.64.0
        bitflags-1.2.1
        block-buffer-0.10.4
        blocking-1.3.0
        bstr-1.4.0
        bytelines-2.4.0
        byteorder-1.4.3
        bytes-1.4.0
        castaway-0.2.2
        cc-1.0.79
        cexpr-0.6.0
        cfg-expr-0.14.0
        cfg-if-1.0.0
        clang-sys-1.6.1
        clap-4.2.2
        clap_builder-4.2.2
        clap_lex-0.4.1
        colorchoice-1.0.0
        compact_str-0.7.0
        concat-in-place-1.1.0
        concurrent-queue-2.1.0
        const_format-0.2.30
        const_format_proc_macros-0.2.29
        cookie-factory-0.3.2
        cpufeatures-0.2.6
        crossbeam-utils-0.8.15
        crypto-common-0.1.6
        derivative-2.2.0
        digest-0.10.6
        dirs-4.0.0
        dirs-sys-0.3.7
        enumflags2-0.7.6
        enumflags2_derive-0.7.6
        errno-0.3.0
        errno-dragonfly-0.1.2
        event-listener-2.5.3
        fastrand-1.9.0
        fomat-macros-0.3.2
        futures-0.3.28
        futures-channel-0.3.28
        futures-core-0.3.28
        futures-executor-0.3.28
        futures-io-0.3.28
        futures-lite-1.13.0
        futures-macro-0.3.28
        futures-sink-0.3.28
        futures-task-0.3.28
        futures-util-0.3.28
        generator-0.7.3
        generic-array-0.14.7
        getrandom-0.2.8
        glob-0.3.1
        hashbrown-0.12.3
        heck-0.4.1
        hermit-abi-0.2.6
        hermit-abi-0.3.1
        hex-0.4.3
        indexmap-1.9.3
        instant-0.1.12
        io-lifetimes-1.0.9
        ioprio-0.2.0
        is-terminal-0.4.6
        itoa-1.0.6
        kdl-4.6.0
        lazy_static-1.4.0
        lazycell-1.3.0
        libc-0.2.141
        libspa-0.6.0
        libspa-sys-0.6.0
        linux-raw-sys-0.3.1
        log-0.4.17
        matchers-0.1.0
        memchr-2.5.0
        memoffset-0.6.5
        memoffset-0.7.1
        miette-5.7.0
        miette-derive-5.7.0
        minimal-lexical-0.2.1
        mio-0.8.6
        nix-0.21.2
        nix-0.26.2
        nom-7.1.3
        nu-ansi-term-0.46.0
        num-traits-0.2.15
        num_cpus-1.15.0
        once_cell-1.17.1
        ordered-stream-0.2.0
        overload-0.1.1
        parking-2.0.0
        peeking_take_while-0.1.2
        pin-project-lite-0.2.9
        pin-utils-0.1.0
        pipewire-0.6.0
        pipewire-sys-0.6.0
        pkg-config-0.3.26
        polling-2.5.2
        ppv-lite86-0.2.17
        proc-macro-crate-1.3.1
        proc-macro2-1.0.56
        qcell-0.5.3
        quote-1.0.26
        rand-0.8.5
        rand_chacha-0.3.1
        rand_core-0.6.4
        redox_syscall-0.2.16
        redox_syscall-0.3.5
        redox_users-0.4.3
        regex-1.7.3
        regex-automata-0.1.10
        regex-syntax-0.6.29
        rustc-hash-1.1.0
        rustix-0.37.6
        rustversion-1.0.12
        ryu-1.0.13
        serde-1.0.160
        serde_derive-1.0.160
        serde_repr-0.1.12
        serde_spanned-0.6.1
        sha1-0.10.5
        sharded-slab-0.1.4
        shlex-1.1.0
        signal-hook-registry-1.4.1
        slab-0.4.8
        smallvec-1.10.0
        socket2-0.4.9
        static_assertions-1.1.0
        strsim-0.10.0
        syn-1.0.109
        syn-2.0.13
        system-deps-6.0.4
        tempfile-3.5.0
        thiserror-1.0.40
        thiserror-impl-1.0.40
        thread_local-1.1.7
        tokio-1.27.0
        tokio-macros-2.0.0
        toml-0.7.3
        toml_datetime-0.6.1
        toml_edit-0.19.8
        tracing-0.1.37
        tracing-attributes-0.1.23
        tracing-core-0.1.30
        tracing-log-0.1.3
        tracing-subscriber-0.3.16
        typenum-1.16.0
        uds_windows-1.0.2
        unicode-ident-1.0.8
        unicode-width-0.1.10
        unicode-xid-0.2.4
        upower_dbus-0.3.2
        utf8parse-0.2.1
        valuable-0.1.0
        version-compare-0.1.1
        version_check-0.9.4
        waker-fn-1.1.0
        wasi-0.11.0+wasi-snapshot-preview1
        wepoll-ffi-0.1.2
        wildmatch-2.1.1
        winapi-0.3.9
        winapi-i686-pc-windows-gnu-0.4.0
        winapi-x86_64-pc-windows-gnu-0.4.0
        windows-0.44.0
        windows-sys-0.42.0
        windows-sys-0.45.0
        windows-sys-0.48.0
        windows-targets-0.42.2
        windows-targets-0.48.0
        windows_aarch64_gnullvm-0.42.2
        windows_aarch64_gnullvm-0.48.0
        windows_aarch64_msvc-0.42.2
        windows_aarch64_msvc-0.48.0
        windows_i686_gnu-0.42.2
        windows_i686_gnu-0.48.0
        windows_i686_msvc-0.42.2
        windows_i686_msvc-0.48.0
        windows_x86_64_gnu-0.42.2
        windows_x86_64_gnu-0.48.0
        windows_x86_64_gnullvm-0.42.2
        windows_x86_64_gnullvm-0.48.0
        windows_x86_64_msvc-0.42.2
        windows_x86_64_msvc-0.48.0
        winnow-0.4.1
        zbus-3.11.1
        zbus_macros-3.11.1
        zbus_names-2.5.0
        zvariant-3.12.0
        zvariant_derive-3.12.0
        zvariant_utils-1.0.0
"

inherit cargo linux-info systemd

DESCRIPTION="Linux service that manages process priorities and CFS scheduler latencies for improved responsiveness on the desktop"
HOMEPAGE="https://github.com/pop-os/system76-scheduler"
SRC_URI="
        $(cargo_crate_uris)
        https://github.com/pop-os/system76-scheduler/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
"

USE=""

LICENSE="MPL-2.0"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD MIT Unicode-DFS-2016 ZLIB"
KEYWORDS="~amd64"
BDEPEND="
        dev-util/bcc
        sys-devel/clang
        media-video/pipewire
"
SLOT="0"

pkg_pretend() {
        local CONFIG_CHECK="~SCHED_DEBUG"

        check_extra_config
}

src_compile() {
        export EXECSNOOP_PATH=$(which execsnoop)
        cargo_src_compile
}

src_install() {
        cargo_src_install --path ./daemon

        systemd_dounit data/com.system76.Scheduler.service
        systemd_install_serviced "${FILESDIR}/${PN}-execsnoop-path.conf" com.system76.Scheduler.service

        insinto /etc/dbus-1/system.d/
        doins data/com.system76.Scheduler.conf

        insinto /usr/share/system76-scheduler
        doins data/config.kdl

        insinto /usr/share/system76-scheduler/process-scheduler
        doins data/pop_os.kdl
}
