docker build -t ds4u/multi-client:latest -t ds4u/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ds4u/multi-server:latest -t ds4u/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ds4u/milti-worker:latest -t ds4u/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ds4u/multi-client:latest
docker push ds4u/multi-server:latest
docker push ds4u/milti-worker:latest
docker push ds4u/multi-client:$SHA
docker push ds4u/multi-server:$SHA
docker push ds4u/milti-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ds4u/multi-server:$SHA
kubectl set image deployments/client-deployment client=ds4u/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ds4u/multi-worker:$SHA
