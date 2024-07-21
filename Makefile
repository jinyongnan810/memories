publish:
	./apply_env.sh && flutter build web --release && firebase deploy --only=hosting

build-app: 
	dart run build_runner build --delete-conflicting-outputs

watch:
	dart run build_runner watch --delete-conflicting-outputs