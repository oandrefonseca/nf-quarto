#!/bin/bash -ue
quarto create-project --type website
quarto render -P project_name:Three
