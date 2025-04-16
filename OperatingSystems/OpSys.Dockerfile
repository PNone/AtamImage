FROM ubuntu:18.04
RUN apt-get update
COPY ./*.deb ./deb_files/
RUN apt-get install -y less man-db
# Timezone for tzdata
ARG TZ=Asia/Jerusalem
# ARG DEBIAN_FRONTEND=noninteractive
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Keyboard layout for keyboard-configuration package
# Preseed keyboard-configuration
RUN echo 'keyboard-configuration  keyboard-configuration/modelcode       select  pc105' > /tmp/kbd.cfg && \
    echo 'keyboard-configuration  keyboard-configuration/layout          select  Hebrew' >> /tmp/kbd.cfg && \
    echo 'keyboard-configuration  keyboard-configuration/layoutcode      select  il' >> /tmp/kbd.cfg && \
    echo 'keyboard-configuration  keyboard-configuration/variant         select  ' >> /tmp/kbd.cfg && \
    echo 'keyboard-configuration  keyboard-configuration/variantcode     select  ' >> /tmp/kbd.cfg && \
    echo 'keyboard-configuration  keyboard-configuration/optionscode     select  grp:alt_shift_toggle' >> /tmp/kbd.cfg && \
    echo 'keyboard-configuration  keyboard-configuration/toggle          select  Alt+Shift' >> /tmp/kbd.cfg && \
    echo 'keyboard-configuration  keyboard-configuration/xkb-keymap      select  il,us' >> /tmp/kbd.cfg && \
    debconf-set-selections /tmp/kbd.cfg && rm /tmp/kbd.cfg
RUN apt-get install -y xfce4 xubuntu-desktop

RUN apt-get install -y ./deb_files/chromium-codecs-ffmpeg_86.0.4240.75-0ubuntu0.18.04.1_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/chromium-codecs-ffmpeg-extra_86.0.4240.75-0ubuntu0.18.04.1_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/chromium-browser_86.0.4240.75-0ubuntu0.18.04.1_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/chromium-browser-l10n_86.0.4240.75-0ubuntu0.18.04.1_all.deb --allow-downgrades

RUN apt-get install -y ./deb_files/geany_1.32-2_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/geany-common_1.32-2_all.deb --allow-downgrades
RUN apt-get install -y ./deb_files/codeblocks_16.01+dfsg-2.1_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/codeblocks-common_16.01+dfsg-2.1_all.deb --allow-downgrades
RUN apt-get install -y ./deb_files/make_4.1-9.1ubuntu1_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/binutils-common_2.30-21ubuntu1~18.04.4_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/libbinutils_2.30-21ubuntu1~18.04.4_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/binutils-x86-64-linux-gnu_2.30-21ubuntu1~18.04.4_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/binutils_2.30-21ubuntu1~18.04.4_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/binutils-doc_2.30-21ubuntu1~18.04.4_all.deb --allow-downgrades
RUN apt-get install -y ./deb_files/gcc-7-base_7.5.0-3ubuntu1~18.04_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/gcc-8-base_8.4.0-1ubuntu1~18.04_amd64.deb --allow-downgrades
RUN apt-get purge -y cpp-7
RUN apt-get install -y ./deb_files/cpp_7.4.0-1ubuntu2.3_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/cpp-doc_7.4.0-1ubuntu2.3_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/cpp-7_7.5.0-3ubuntu1~18.04_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/cpp-7-doc_7.5.0-3ubuntu1~18.04_all.deb --allow-downgrades
RUN apt-get install -y ./deb_files/libasan4_7.5.0-3ubuntu1~18.04_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/libubsan0_7.5.0-3ubuntu1~18.04_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/libcilkrts5_7.5.0-3ubuntu1~18.04_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/libgcc-7-dev_7.5.0-3ubuntu1~18.04_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/gcc_7.4.0-1ubuntu2.3_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/gcc-doc_7.4.0-1ubuntu2.3_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/gcc-7_7.5.0-3ubuntu1~18.04_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/gcc-7-doc_7.5.0-3ubuntu1~18.04_all.deb --allow-downgrades
RUN apt-get install -y ./deb_files/gdb_8.1-0ubuntu3.2_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/gdb-doc_8.1-0ubuntu3.2_all.deb --allow-downgrades
RUN apt-get install -y ./deb_files/bsdmainutils_11.1.2ubuntu1_amd64.deb --allow-downgrades

# Install bsdmainutils manual, as it is not properly installed for some reason
RUN mkdir ~/bsdmainutils_tmp
RUN dpkg-deb -x ./deb_files/bsdmainutils_11.1.2ubuntu1_amd64.deb ~/bsdmainutils_tmp
RUN cp ~/bsdmainutils_tmp/usr/share/man/man1/*.1.gz /usr/share/man/man1/
RUN mandb
RUN rm -rf ~/bsdmainutils_tmp

RUN mkdir ~/cpp_tmp
RUN dpkg-deb -x ./deb_files/cpp-7_7.5.0-3ubuntu1~18.04_amd64.deb ~/cpp_tmp
RUN cp ~/cpp_tmp/usr/share/man/man1/*.1.gz /usr/share/man/man1/
RUN mandb
RUN rm -rf ~/cpp_tmp

RUN mkdir ~/gcc_tmp
RUN dpkg-deb -x ./deb_files/gcc-7_7.5.0-3ubuntu1~18.04_amd64.deb ~/gcc_tmp
RUN cp ~/gcc_tmp/usr/share/man/man1/*.1.gz /usr/share/man/man1/
RUN mandb
RUN rm -rf ~/gcc_tmp


# Securely create student user
RUN --mount=type=secret,id=student_uid_os \
    --mount=type=secret,id=student_pass_os \
    STUDENT_UID=$(cat /run/secrets/student_uid_os) && \
    STUDENT_PASS=$(cat /run/secrets/student_pass_os) && \
    useradd -m -u "$STUDENT_UID" -g root student && \
    echo "student:$STUDENT_PASS" | chpasswd

# Add student to sudo group
RUN usermod -aG sudo student
USER student
RUN echo 'alias gcc="gcc-7"' >> ~/.bashrc
