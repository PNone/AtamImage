FROM ubuntu:18.04
RUN apt-get update
# COPY ./gcc-7_7.4.0-1ubuntu1~18.04.1_amd64.deb /
# COPY ./gdb_8.1-0ubuntu3_amd64.deb /
COPY ./*.deb /
RUN apt-get install -y binutils=2.30-21ubuntu1~18.04.9
RUN dpkg -i /gcc-7-base_7.4.0-1ubuntu1~18.04.1_amd64.deb
RUN apt-get purge -y cpp-7
RUN apt-get install -y /cpp-7_7.4.0-1ubuntu1~18.04.1_amd64.deb --allow-downgrades
RUN apt-get install -y /libasan4_7.4.0-1ubuntu1~18.04.1_amd64.deb --allow-downgrades
RUN apt-get install -y /libubsan0_7.4.0-1ubuntu1~18.04.1_amd64.deb --allow-downgrades
RUN apt-get install -y /libcilkrts5_7.4.0-1ubuntu1~18.04.1_amd64.deb --allow-downgrades
RUN apt-get install -y /libgcc-7-dev_7.4.0-1ubuntu1~18.04.1_amd64.deb --allow-downgrades
RUN apt-get install -y /gcc-7_7.4.0-1ubuntu1~18.04.1_amd64.deb --allow-downgrades
RUN apt-get install -y /gdb_8.1-0ubuntu3_amd64.deb --allow-downgrades
RUN apt-get install -y /bsdmainutils_11.1.2ubuntu1_amd64.deb --allow-downgrades
RUN echo 'alias gcc="gcc-7"' >> ~/.bashrc


# RUN apt-get install -y gcc-7=7.4.0-1ubuntu1~18.04.1
# RUN apt-get install -y gcc-7.4.0 as-2.30 ld-2.30 gdb-8.1.0.20180409-git readelf-2.30 objdump-2.30
# RUN apt-get install -y gcc-7.4.0 as-2.30 ld-2.30 gdb-8.1.0.20180409-git readelf-2.30 objdump-2.30
# RUN apt-get install -y gcc-7.4.0 as-2.30 ld-2.30 gdb-8.1.0.20180409-git readelf-2.30 objdump-2.30
# RUN apt-get install -y gcc-7.4.0 as-2.30 ld-2.30 gdb-8.1.0.20180409-git readelf-2.30 objdump-2.30
# RUN apt-get install -y gcc-7.4.0 as-2.30 ld-2.30 gdb-8.1.0.20180409-git readelf-2.30 objdump-2.30
# RUN apt-get install -y gcc-7.4.0 as-2.30 ld-2.30 gdb-8.1.0.20180409-git readelf-2.30 objdump-2.30
# RUN apt-get install -y gcc-7.4.0 as-2.30 ld-2.30 gdb-8.1.0.20180409-git readelf-2.30 objdump-2.30
