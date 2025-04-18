FROM ubuntu:18.04
RUN apt-get update

# Do not remove man pages
RUN sed -i 's:^path-exclude=/usr/share/man:#path-exclude=/usr/share/man:' \
    /etc/dpkg/dpkg.cfg.d/excludes

COPY ./*.deb ./deb_files/
RUN apt-get install -y less
RUN apt-get install -y man-db

RUN apt-get install -y ./deb_files/binutils-common_2.30-21ubuntu1~18.04.2_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/libbinutils_2.30-21ubuntu1~18.04.2_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/binutils-x86-64-linux-gnu_2.30-21ubuntu1~18.04.2_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/binutils_2.30-21ubuntu1~18.04.2_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/binutils-doc_2.30-21ubuntu1~18.04.2_all.deb --allow-downgrades
RUN apt-get install -y ./deb_files/gcc-7-base_7.4.0-1ubuntu1~18.04.1_amd64.deb --allow-downgrades
RUN apt-get purge -y cpp-7
RUN apt-get install -y ./deb_files/cpp-7_7.4.0-1ubuntu1~18.04.1_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/cpp-7-doc_7.4.0-1ubuntu1~18.04.1_all.deb --allow-downgrades
RUN apt-get install -y ./deb_files/libasan4_7.4.0-1ubuntu1~18.04.1_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/libubsan0_7.4.0-1ubuntu1~18.04.1_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/libcilkrts5_7.4.0-1ubuntu1~18.04.1_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/libgcc-7-dev_7.4.0-1ubuntu1~18.04.1_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/gcc-7_7.4.0-1ubuntu1~18.04.1_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/gcc-7-doc_7.4.0-1ubuntu1~18.04.1_all.deb --allow-downgrades
RUN apt-get install -y ./deb_files/gdb_8.1-0ubuntu3_amd64.deb --allow-downgrades
RUN apt-get install -y ./deb_files/gdb-doc_8.1-0ubuntu3_all.deb --allow-downgrades
RUN apt-get install -y ./deb_files/bsdmainutils_11.1.2ubuntu1_amd64.deb --allow-downgrades

# Delete deb_files to save on space
RUN rm -rf ./deb_files

# RUN groupadd -g ${STUDENT_GROUP_UID_ATAM} ${STUDENT_GROUP_NAME_ATAM} && useradd -m -u ${STUDENT_UID_ATAM} -g ${STUDENT_GROUP_NAME_ATAM} student

# Create user using secrets
RUN --mount=type=secret,id=student_uid_atam \
    --mount=type=secret,id=student_group_uid_atam \
    --mount=type=secret,id=student_group_name_atam \
    --mount=type=secret,id=student_pass_atam \
    STUDENT_UID=$(cat /run/secrets/student_uid_atam) && \
    STUDENT_GROUP_UID=$(cat /run/secrets/student_group_uid_atam) && \
    STUDENT_GROUP_NAME=$(cat /run/secrets/student_group_name_atam) && \
    STUDENT_PASS=$(cat /run/secrets/student_pass_atam) && \
    groupadd -g "$STUDENT_GROUP_UID" "$STUDENT_GROUP_NAME" && \
    useradd -m -u "$STUDENT_UID" -g "$STUDENT_GROUP_NAME" student && \
    echo "student:$STUDENT_PASS" | chpasswd

# Add student to sudo group
RUN usermod -aG sudo student
USER student
RUN echo 'alias gcc="gcc-7"' >> ~/.bashrc
