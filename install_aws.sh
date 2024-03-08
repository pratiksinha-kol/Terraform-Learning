#!/usr/bin/env bash

cd /workspace/

rm -rf awscliv2.zip
rm -rf '/workspace/aws'
echo "Old AWS CLI Removed"


curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
cd $THEIA_WORKSPACE_ROOT    
echo "AWS CLI Installed"