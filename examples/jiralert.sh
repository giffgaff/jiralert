#!/bin/sh
sed -i "s|api_url:|api_url: ${JIRALERT_URL}|g" "/config/jiralert.yml"
sed -i "s|user:|user: ${JIRALERT_USER}|g" "/config/jiralert.yml"
sed -i "s|password:|password: ${JIRALERT_PASS}|g" "/config/jiralert.yml"
sed -i "s|project:|project: ${JIRALERT_PROJECT}|g" "/config/jiralert.yml"