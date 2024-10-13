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

assume-unchanged-web:
	git update-index --assume-unchanged web/index.html

no-assume-unchanged-web:
	git update-index --no-assume-unchanged web/index.html

assume-unchanged-android:
	git update-index --assume-unchanged android/app/src/main/AndroidManifest.xml

no-assume-unchanged-android:
	git update-index --no-assume-unchanged android/app/src/main/AndroidManifest.xml

assume-unchanged-ios: 
	git update-index --assume-unchanged ios/Runner/AppDelegate.swift

no-assume-unchanged-ios:
	git update-index --no-assume-unchanged ios/Runner/AppDelegate.swift

splash:
	dart run flutter_native_splash:create --path=flutter_native_splash.yaml