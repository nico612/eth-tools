


# ==============================================================================
# Build options

ROOT_PACKAGE=github.com/nico612/eth-tools
VERSION_PACKAGE=github.com/marmotedu/component-base/pkg/version



# make sure include common.mk at the first include line
include scripts/make-rules/common.mk

# ==============================================================================
# Build

.PHONY: build
# Build source code for host platform
build:
	@echo "build application"

.PHONY: buildmultiarch
# Build source code for multiple platforms
buildmultiarch:
	@echo "build multiarch"


# ==============================================================================
# Docker

.PHONY: image
# Build docker images for host arch
image:
	@echo "image"

.PHONY: image.multiarch
# Build docker images for multiple platforms
image.multiarch:
	@echo "image.multiarch"

.PHONY: push
# Build docker images for host arch and push images to registry.
push:
	@echo "push images to registry"
.PHONY: push.multiarch


# ============================================================================================================
# Deploy

.PHONY: deploy
# Deploy updated components to development env.
deploy:
	@echo "deploy"

.PHONY: install
# Install system with all its components.
install:
	@echo "tolls install"


# ============================================================================================================
# Clean

.PHONY: clean
# Remove all files that are created by building.
clean:
	@echo "remove all files that are created by building."


# ============================================================================================================
# 代码生成类

.PHONY: gen
# gen: Generate all necessary files, such as error code files.
gen: tidy
	go generate ${ROOT_DIR}/...


.PHONY: ca
# ca: Generate CA files for all iam components.
ca:
	@echo "gen ca"

# ============================================================================================================
# 静态代码检查

.PHONY: lint
# Check syntax and styling of og sources.
lint:
	@echo: "check syntax and styling of og sources."

# ============================================================================================================
# 测试类命令

.PHONY: test
# Run unit test.
test:
	@echo ""

.PHONY: cover
# Run unit test and get test coverage.
cover:
	@echo ""

# ============================================================================================================
# 格式化命令

.PHONY: format
# format: Gofmt (reformat) package sources (exclude vendor dir if existed).
format:
	@echo ""

.PHONY: verify-copyright
# verify-copyright: Verify the boilerplate headers for all files.
verify-copyright:
	@echo ""


.PHONY: add-copyright
# add-copyright: Ensures source code files have copyright license headers.
add-copyright:
	@echo ""

# ============================================================================================================
# Swagger 文档
.PHONY: swagger
# swagger: Generate swagger document.
swagger:
	@echo "swagger"

.PHONY: swagger.serve
# serve-swagger: Serve swagger spec and docs.
serve-swagger:
	@echo "serve-swagger"

# ==============================================================================
# 其他类
## tools: install dependent tools.
.PHONY: tools
tools:
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	go install github.com/bufbuild/buf/cmd/buf@v1.15.1

.PHONY: check-updates
# check-updates: Check outdated dependencies of the go projects.
check-updates:
	@echo "check-updates"

.PHONY: tidy
tidy:
	go mod tidy



# show help
help:
	@echo ''
	@echo 'Usage:'
	@echo ' make [target]'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
	helpMessage = match(lastLine, /^# (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 2, RLENGTH); \
			printf "\033[36m%-22s\033[0m %s\n", helpCommand,helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help


