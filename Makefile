COMMON_BUILD_CMDS = rm -rf build && ./apply_env.sh && flutter build web --release && cp robots.txt build/web && cp env build/web

publish:
    $(COMMON_BUILD_CMDS) && firebase deploy --only=hosting

prepare-publish:
    $(COMMON_BUILD_CMDS)

publish-server:
	firebase deploy --only=functions

server-dev:
	npm run --prefix server dev

build-app: 
	dart run build_runner build --delete-conflicting-outputs

watch:
	dart run build_runner watch --delete-conflicting-outputs