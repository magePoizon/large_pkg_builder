#!/bin/zsh

# Created by Elliot Isaiah Decaro 09Jul2025

# Used to create large pkgs. Standard pkgs use cpio archiving (32bit), which only allows a maximum individual filesize of 4gb. Using the "--large-payload" flag alleviates this issue by using a newer archiving method (64bit)."--min-os-version 12.0" is necessary as earlier versions cannot use "--large-payload" 



# --------
# Parent Values

scriptDir=${0:A:h}

# folder containing files to be packaged
rootFolder="${scriptDir}/ROOT"

# unique identifier name for this pkg
identifierEnd="example"
identifier="com.example.${identifierEnd}"

# format version like MM.YYYY e.g. 062025
version="1122"

# Where the pkged files should be installed on target
# If you use a full path here, you will not be able to set the permissions on the directories, so it's best to build your full directory in the ROOT folder with all the necessary permissions
installDestination="/"

# Where you want your pkg to end up (directory)
pkgBuildDir="${scriptDir}/build"


pkgFilename="${identifierEnd}_${version}_sCompiled_ED.pkg"
pkgOutputPath="${pkgBuildDir}/${pkgFilename}"


# --------
# Verify details

echo "========"
echo "Verify details below..."
echo "Root folder: $rootFolder"
echo "File name: $identifierEnd"
echo "Identifier: $identifier"
echo "version: $version"
echo "Destination: $installDestination"
echo "Output: $pkgBuildDir"
echo "Output File: $pkgFilename"
echo "Output Path: $pkgOutputPath"


# prompt for confirmation
read "response?Is all the above correct? [y/N] "

# if not Y or y, abort
if [[ ! $response =~ ^[Yy]$ ]]; then
	echo "Aborted by user."
	exit 1
fi

echo "========="
echo "Executing build process..."

# make sure build directory exists
#mkdir -p "${pkgBuildDir}"


pkgbuild \
--root "${rootFolder}" \
--install-location "${installDestination}" \
--identifier "${identifier}" \
--version "${version}" \
--large-payload \
--min-os-version 12.0 \
"${pkgOutputPath}"