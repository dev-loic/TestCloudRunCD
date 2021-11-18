DOCKER_IMAGE_NAME=test-cloud-run-cd
GCR_MULTI_REGION=eu.gcr.io
PROJECT_ID=wagon-bootcamp-309809
GCR_REGION=europe-west1


build_m1_local:
	docker build -t ${DOCKER_IMAGE_NAME} .

run_m1_local:
	docker run -e PORT=8000 -p 8001:8000 ${DOCKER_IMAGE_NAME}

build_m1_prod:
	docker buildx build --platform linux/amd64 -t ${GCR_MULTI_REGION}/${PROJECT_ID}/${DOCKER_IMAGE_NAME} --load .

# prod for everybody
push_image:
	docker push ${GCR_MULTI_REGION}/${PROJECT_ID}/${DOCKER_IMAGE_NAME}

deploy_image:
	gcloud run deploy --image ${GCR_MULTI_REGION}/${PROJECT_ID}/${DOCKER_IMAGE_NAME} --platform managed --region ${GCR_REGION}
