# FROM frolvlad/alpine-mono
FROM microsoft/dotnet:2.0-sdk-jessie
ADD ./IsometricApi /api
WORKDIR /api
EXPOSE 5000
ENV PAKET_VERSION=5.150.0
ENV MONO_VERSION 5.10.0.140

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF

RUN echo "deb http://download.mono-project.com/repo/debian stable-jessie main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
  && apt-get update \
  && apt-get install -y mono-runtime \
&& rm -rf /var/lib/apt/lists/* /tmp/*
RUN apt-get update \
  && apt-get install -y binutils curl mono-devel ca-certificates-mono fsharp mono-vbnc nuget referenceassemblies-pcl \
  && rm -rf /var/lib/apt/lists/* /tmp/*
# RUN apk add --no-cache mono --repository http://dl-4.alpinelinux.org/alpine/edge/testing && \
#     apk add --no-cache --virtual=.build-dependencies ca-certificates && \
#     cert-sync /etc/ssl/certs/ca-certificates.crt && \
#     apk del .build-dependencies && \
#     apk add --update openssl
# REFERENCE: https://github.com/fsprojects/Paket/issues/3009
RUN wget https://curl.haxx.se/ca/cacert.pem --no-check-certificate -O ~/cacert.pem && cert-sync ~/cacert.pem
RUN wget https://github.com/fsprojects/Paket/releases/download/${PAKET_VERSION}/paket.bootstrapper.exe --no-check-certificate -O ./.paket/paket.exe
RUN chmod +x ./paket
# RUN ./paket install

# FROM microsoft/dotnet:2.1-sdk-alpine
# ADD ./IsometricApi /api
WORKDIR /api/IsometricRest
RUN dotnet restore
RUN dotnet run
