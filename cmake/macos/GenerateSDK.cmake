################################################################################
#
#  Copyright (c) 2010-2021 Belledonne Communications SARL.
# 
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
# 
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
# 
#  You should have received a copy of the GNU General Public License
#  along with this program. If not, see <http://www.gnu.org/licenses/>.
#
################################################################################


list(APPEND CMAKE_MODULE_PATH "${LINPHONESDK_DIR}/cmake")
include(LinphoneSdkUtils)


# Create the zip file of the SDK
set(INSTALL_FOLDER "desktop")# Used to podspec
execute_process(
	COMMAND "zip" "-r" "--symlinks" "linphone-sdk-macos-${LINPHONESDK_VERSION}.zip" "linphone-sdk/${INSTALL_FOLDER}"
	WORKING_DIRECTORY "${LINPHONESDK_BUILD_DIR}"
)

# Generate podspec file
file(READ "${LINPHONESDK_DIR}/LICENSE.txt" LINPHONESDK_LICENSE)
file(READ "${LINPHONESDK_ENABLED_FEATURES_FILENAME}" LINPHONESDK_ENABLED_FEATURES)
linphone_sdk_convert_comma_separated_list_to_cmake_list("${LINPHONESDK_MACOS_ARCHS}" VALID_ARCHS)
string(REPLACE ";" " " VALID_ARCHS "${VALID_ARCHS}")

set(LINPHONESDK_FRAMEWORK_FOLDER "XCFrameworks")
if(ENABLE_FAT_BINARY)
	set(LINPHONESDK_FRAMEWORK_FOLDER "Frameworks")
endif()

configure_file("${LINPHONESDK_DIR}/cmake/macos/linphone-sdk.podspec.cmake" "${LINPHONESDK_BUILD_DIR}/linphone-sdk.podspec" @ONLY)
