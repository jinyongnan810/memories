publish:
	rm -rf build && ./apply_env.sh && flutter build web --release && cp robots.txt build/web && cp env build/web && firebase deploy --only=hosting

publish-server:
	firebase deploy --only=functions

server-dev:
	npm run --prefix server dev

build-app: 
	dart run build_runner build --delete-conflicting-outputs

watch:
	dart run build_runner watch --delete-conflicting-outputs