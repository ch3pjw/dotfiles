#!/bin/bash

read -s pass
echo "${pass}" | sha256sum
