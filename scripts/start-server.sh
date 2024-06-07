#!/bin/bash
echo "---Searching Urban Terror updater---"
if [ ! -f ${DATA_DIR}/Ur*.sh ]; then
    echo "---Urban Terror updater not found, downloading, please wait...---"
    cd ${DATA_DIR}
    if wget -q "$(wget -qO- "${DL_URL}" | grep "tar.gz?key=" | cut -d '"' -f4 | cut -d '=' -f2-)" ; then
        echo "---Successfully downloaded Urban Terror updater---"
    else
        echo "---Something went wrong, can't download Urban Terror updater, putting container into sleep mode!---"
        sleep infinity
    fi
    tar -C ${DATA_DIR} --strip-components=1 -xf ${DATA_DIR}/UrbanTerror*
    rm -R ${DATA_DIR}/UrbanTerror*
    chmod +x ${DATA_DIR}/*
else
    echo "---Urban Terror updater found, continuing!---"
fi

echo "---Checking if Urban Terror is installed---"
if [ ! -f ${DATA_DIR}/Quake3-UrT-Ded.x86_64 ]; then
    echo "---Urban Terror not found, please wait...---"
    cd ${DATA_DIR}
    echo -e "y\n${GAME_V}\n${DL_LOCATION}\n${ENGINE}\nn\n" | ${DATA_DIR}/Ur*.sh
    echo -e "y\n" | ${DATA_DIR}/Ur*.sh
elif [ "${CHECK_FOR_UPDATES}" == "true" ]; then
    echo "---Urban Terror found, checking for updates---"
    echo "y\n" | ${DATA_DIR}/Ur*
else
    echo "---Urban Terror found, update check skiped---"
fi

echo "---Preparing Server---"
if [ -f ${DATA_DIR}/q3ut4/${CONFIG_NAME} ]; then
    echo "---Found server configuration file: \"${CONFIG_NAME}\"---"
elif [ ! -f ${DATA_DIR}/q3ut4/${CONFIG_NAME} ] && [ "${CONFIG_NAME}" == "server.cfg" ]; then
    echo "---\"${CONFIG_NAME}\" not found, creating...---"
    cp ${DATA_DIR}/q3ut4/server_example.cfg ${DATA_DIR}/q3ut4/${CONFIG_NAME}
    sed -i "/set  sv_hostname                       \"New Unnamed Server\"/c\set  sv_hostname                       \"Docker Server\"" ${DATA_DIR}/q3ut4/${CONFIG_NAME}
else
    echo "---Custom server configuration file: \"${CONFIG_NAME}\" not found, putting container into sleep mode---"
    sleep infinity
fi
chmod -R ${DATA_PERM} ${DATA_DIR}

echo "---Starting Urban Terror---"
cd ${DATA_DIR}
${DATA_DIR}/Quake3-UrT-Ded.x86_64 +set net_port ${GAME_PORT} +set fs_homepath ${DATA_DIR} +exec server.cfg ${START_PARAMS}