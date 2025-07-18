push:
	git add .
	git commit -m "new"
	git push origin main --force

s3:
	python3 utils/create_s3.py
	aws s3 ls "$S3_BUCKET_NAME/data/raw/" --recursive | head -n 25

install:
	bash utils/bootstrap-amd.sh

tree-dev:
	tree -a -I '.git|.venv|prod|docs|tmp'

backup:
	zip "$$(basename $$PWD)_$$(date +%Y%m%d_%H%M%S).zip" \
	$$(find . -type f -size -100M \
		! -path "*/.git/*" \
		! -path "*/.venv/*" \
		! -path "*/tmp/*" \
		! -path "models/*")


