publish:
	./apply_env.sh && flutter build web --release && firebase deploy --only=hosting