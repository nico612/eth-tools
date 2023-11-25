

GO_SUPPORTED_VERSIONS ?= 1.18|1.19|1.20

# 注入版本标志
GO_LDFLAGS += -X $(VERSION_PACKAGE).GitVersion=$(VERSION) \
	-X $(VERSION_PACKAGE).GitCommit=$(GIT_COMMIT) \
	-X $(VERSION_PACKAGE).GitTreeState=$(GIT_TREE_STATE) \
	-X $(VERSION_PACKAGE).BuildDate=$(shell date -u +'%Y-%m-%dT%H:%M:%SZ')
ifneq ($(DLV),)
	GO_BUILD_FLAGS += -gcflags "all=-N -l"
	LDFLAGS = ""
endif


GO_BUILD_FLAGS += -ldflags "$(GO_LDFLAGS)"


ifeq ($(GOOS),windows)
	GO_OUT_EXT := .exe
endif


ifeq ($(ROOT_PACKAGE),)
	$(error the variable ROOT_PACKAGE must be set prior to including golang.mk)
endif


GOPATH := $(shell go env GOPATH)
ifeq ($(origin GOBIN), undefined)
	GOBIN := $(GOPATH)/bin
endif

# 指定命令文件目录
COMMANDS ?= $(filter-out %.md, $(wildcard ${ROOT_DIR}/cmd/*))
BINS ?= $(foreach cmd,${COMMANDS},$(notdir ${cmd}))


ifeq (${COMMANDS},)
  $(error Could not determine COMMANDS, set ROOT_DIR or run in source dir)
endif
ifeq (${BINS},)
  $(error Could not determine BINS, set ROOT_DIR or run in source dir)
endif

# 指定测试目录
EXCLUDE_TESTS=github.com/nico612/metting





