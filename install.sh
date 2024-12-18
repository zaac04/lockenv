#!/bin/bash
url="https://github.com/zaac04/lockenv/releases/download/v2.1/lockenv"
wget -O lockenv $url
binary_destination_folder="/usr/local/bin"
sudo cp lockenv $binary_destination_folder
sudo chmod +x "$binary_destination_folder/lockenv"