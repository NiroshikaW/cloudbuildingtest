env:
	@go env -w GONOPROXY="gitlab.com"
	@go env -w GOPRIVATE="gitlab.com"

build: env
	@go build -o main -a main.go

test: env
	@go test ./...

fmt:
	@go fmt ./...

vendor:
	@go mod vendor

#gen-api:
#	@oapi-codegen -generate types,server,spec -package api -o pkg/api/api.go api/openapi.yaml

#gen-skp-client:
#	@swagger -q generate client -f api/skp-manage-assets.yaml -c skp -m skp -a skp -t pkg

#run-pre-commit:
#	@pre-commit run --all-files

# lists all available targets
list:
	@echo "List of available targets:"
	@sh -c "$(MAKE) -p no_targets__ | awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /);for(i in A)print A[i]}' | grep -v '__\$$' | grep -v 'make\[1\]' | grep -v 'Makefile' | sort"
# required for list
no_targets__:

.DEFAULT_GOAL = list
