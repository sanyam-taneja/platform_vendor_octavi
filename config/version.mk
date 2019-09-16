# Copyright (C) 2020 ColtOS Project
# Copyright (C) 2020 Octavi-OS
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Versioning System
OCTAVI_MAJOR_VERSION = 10.0

OCTAVI_RELEASE_VERSION = v1.0

OCTAVI_BUILD_TYPE ?= Unofficial

OCTAVI_BUILD_DATE := $(shell date +"%Y%m%d")

TARGET_PRODUCT_SHORT := $(subst octavi_,,$(OCTAVI_BUILD))

OCTAVI_VERSION := OctaviOS-$(OCTAVI_RELEASE_VERSION)-$(OCTAVI_BUILD)-$(OCTAVI_BUILD_DATE)-$(OCTAVI_BUILD_TYPE)

OCTAVI_MOD_VERSION := $(OCTAVI_MAJOR_VERSION)-$(OCTAVI_RELEASE_VERSION)

OCTAVI_DISPLAY_VERSION := OctaviOS-$(OCTAVI_RELEASE_VERSION)-$(OCTAVI_BUILD_TYPE)

OCTAVI_FINGERPRINT := OctaviOS/$(OCTAVI_MOD_VERSION)/$(TARGET_PRODUCT_SHORT)/$(OCTAVI_BUILD_DATE)
