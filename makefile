BINARY_NAME=lockenv
EXE_NAME=lockenv.exe
DATE =$(shell date "+%d %b %Y")
Version=v2.0
Maintainer="Zaac04"

BUILD_FILE := build.txt
ifeq (,$(wildcard $(BUILD_FILE)))
	$(shell echo 1 > $(BUILD_FILE))
endif
BUILD_NUMBER := $(shell cat $(BUILD_FILE))
NEW_BUILD_NUMBER := $(shell expr $(BUILD_NUMBER) + 1)

install_dep:
	go install github.com/wailsapp/wails/v2/cmd/wails@latest
	sudo apt-get -y install build-essential libgtk-3-dev libwebkit2gtk-4.0-dev pkg-config
	sudo apt-get -y install upx-ucl

update_build_number:
	@echo $(NEW_BUILD_NUMBER) > $(BUILD_FILE)

show_build_number:
	@echo "Current build number is $(BUILD_NUMBER)"

buildLinux:
	@$(MAKE) clean
	go mod tidy
	cd frontend && npm i && npm run build
	go build -o ${BINARY_NAME} -tags desktop,production -ldflags "-w -s -X 'github.com/zaac04/lockenv/version.Maintainer=${Maintainer}' -X 'github.com/zaac04/lockenv/version.Version=${Version}' -X 'github.com/zaac04/lockenv/version.BuildNo=${NEW_BUILD_NUMBER}' -X 'github.com/zaac04/lockenv/version.Date=${DATE}'" -o ./build/linux/${BINARY_NAME}
	upx --best --lzma ./build/linux/${BINARY_NAME}
	@$(MAKE) update_build_number
	cp ./build/linux/${BINARY_NAME} .

buildLinuxServer:
	@$(MAKE) clean
	go mod tidy
	cd server && go build  -ldflags "-w -s -X 'github.com/zaac04/lockenv/version.Maintainer=${Maintainer}' -X 'github.com/zaac04/lockenv/version.Version=${Version}' -X 'github.com/zaac04/lockenv/version.BuildNo=${NEW_BUILD_NUMBER}' -X 'github.com/zaac04/lockenv/version.Date=${DATE}'" -o ../build/linux/server/${BINARY_NAME}-server
	# upx --best --lzma ./build/linux/server/${BINARY_NAME}-server
	@$(MAKE) update_build_number
	cp ./build/linux/server/${BINARY_NAME}-server . 

buildWindows:
	@$(MAKE) clean
	GOOS=windows GOARCH=amd64 go build -tags desktop,production -ldflags "-w -s -X 'github.com/zaac04/lockenv/version.Maintainer=${Maintainer}' -X 'github.com/zaac04/lockenv/version.Version=${Version}' -X 'github.com/zaac04/lockenv/version.BuildNo=${NEW_BUILD_NUMBER}' -X 'github.com/zaac04/lockenv/version.Date=${DATE}'" -o ./build/windows/${EXE_NAME}
	upx --best --lzma ./build/windows/${EXE_NAME}
	@$(MAKE) update_build_number
	cp ./build/windows/${EXE_NAME} .

run:
	./${BINARY_NAME}

clean:
	go clean