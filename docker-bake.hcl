group "default" {
	targets = ["debian-latest", "alpine-latest", "debian-13", "debian-12", "debian-11", "debian-10", "alpine-13", "alpine-12", "alpine-11", "alpine-10"]
}

variable "REGISTRY_PREFIX" {
	default = ""
}

variable "IMAGE_NAME" {
	default = "postgres-backup-local"
}

variable "BUILD_REVISION" {
	default = ""
}

target "debian" {
	args = {"GOCRONVER" = "v0.0.10"}
	dockerfile = "debian.Dockerfile"
}

target "alpine" {
	args = {"GOCRONVER" = "v0.0.10"}
	dockerfile = "alpine.Dockerfile"
}

target "debian-latest" {
	inherits = ["debian"]
	platforms = ["linux/amd64", "linux/arm64", "linux/arm/v7", "linux/s390x", "linux/ppc64le"]
	args = {"BASETAG" = "14"}
	tags = [
		"${REGISTRY_PREFIX}${IMAGE_NAME}:latest",
		"${REGISTRY_PREFIX}${IMAGE_NAME}:14",
		notequal("", BUILD_REVISION) ? "${REGISTRY_PREFIX}${IMAGE_NAME}:14-debian-${BUILD_REVISION}" : ""
	]
}

target "alpine-latest" {
	inherits = ["alpine"]
	platforms = ["linux/amd64", "linux/arm64", "linux/arm/v7", "linux/s390x", "linux/ppc64le"]
	args = {"BASETAG" = "14-alpine"}
	tags = [
		"${REGISTRY_PREFIX}${IMAGE_NAME}:alpine",
		"${REGISTRY_PREFIX}${IMAGE_NAME}:14-alpine",
		notequal("", BUILD_REVISION) ? "${REGISTRY_PREFIX}${IMAGE_NAME}:14-alpine-${BUILD_REVISION}" : ""
	]
}

target "debian-13" {
	inherits = ["debian"]
	platforms = ["linux/amd64", "linux/arm64", "linux/arm/v7", "linux/s390x", "linux/ppc64le"]
	args = {"BASETAG" = "13"}
	tags = [
		"${REGISTRY_PREFIX}${IMAGE_NAME}:13",
		notequal("", BUILD_REVISION) ? "${REGISTRY_PREFIX}${IMAGE_NAME}:13-debian-${BUILD_REVISION}" : ""
	]
}

target "alpine-13" {
	inherits = ["alpine"]
	platforms = ["linux/amd64", "linux/arm64", "linux/arm/v7", "linux/s390x", "linux/ppc64le"]
	args = {"BASETAG" = "13-alpine"}
	tags = [
		"${REGISTRY_PREFIX}${IMAGE_NAME}:13-alpine",
		notequal("", BUILD_REVISION) ? "${REGISTRY_PREFIX}${IMAGE_NAME}:13-alpine-${BUILD_REVISION}" : ""
	]
}

target "debian-12" {
	inherits = ["debian"]
	platforms = ["linux/amd64", "linux/arm64", "linux/arm/v7", "linux/s390x", "linux/ppc64le"]
	args = {"BASETAG" = "12"}
	tags = [
		"${REGISTRY_PREFIX}${IMAGE_NAME}:12",
		notequal("", BUILD_REVISION) ? "${REGISTRY_PREFIX}${IMAGE_NAME}:12-debian-${BUILD_REVISION}" : ""
	]
}

target "alpine-12" {
	inherits = ["alpine"]
	platforms = ["linux/amd64", "linux/arm64", "linux/arm/v7", "linux/s390x", "linux/ppc64le"]
	args = {"BASETAG" = "12-alpine"}
	tags = [
		"${REGISTRY_PREFIX}${IMAGE_NAME}:12-alpine",
		notequal("", BUILD_REVISION) ? "${REGISTRY_PREFIX}${IMAGE_NAME}:12-alpine-${BUILD_REVISION}" : ""
	]
}

target "debian-11" {
	inherits = ["debian"]
	platforms = ["linux/amd64", "linux/arm64", "linux/arm/v7"]
	args = {"BASETAG" = "11"}
	tags = [
		"${REGISTRY_PREFIX}${IMAGE_NAME}:11",
		notequal("", BUILD_REVISION) ? "${REGISTRY_PREFIX}${IMAGE_NAME}:11-debian-${BUILD_REVISION}" : ""
	]
}

target "alpine-11" {
	inherits = ["alpine"]
	platforms = ["linux/amd64", "linux/arm64", "linux/arm/v7", "linux/s390x", "linux/ppc64le"]
	args = {"BASETAG" = "11-alpine"}
	tags = [
		"${REGISTRY_PREFIX}${IMAGE_NAME}:11-alpine",
		notequal("", BUILD_REVISION) ? "${REGISTRY_PREFIX}${IMAGE_NAME}:11-alpine-${BUILD_REVISION}" : ""
	]
}

target "debian-10" {
	inherits = ["debian"]
	platforms = ["linux/amd64", "linux/arm64", "linux/arm/v7"]
	args = {"BASETAG" = "10"}
	tags = [
		"${REGISTRY_PREFIX}${IMAGE_NAME}:10",
		notequal("", BUILD_REVISION) ? "${REGISTRY_PREFIX}${IMAGE_NAME}:10-debian-${BUILD_REVISION}" : ""
	]
}

target "alpine-10" {
	inherits = ["alpine"]
	platforms = ["linux/amd64", "linux/arm64", "linux/arm/v7", "linux/s390x", "linux/ppc64le"]
	args = {"BASETAG" = "10-alpine"}
	tags = [
		"${REGISTRY_PREFIX}${IMAGE_NAME}:10-alpine",
		notequal("", BUILD_REVISION) ? "${REGISTRY_PREFIX}${IMAGE_NAME}:10-alpine-${BUILD_REVISION}" : ""
	]
}
