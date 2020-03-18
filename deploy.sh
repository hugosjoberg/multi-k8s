docker build -t hsjoberg/multi-client:latest -t hsjoberg/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hsjoberg/mutli-server:latest -t hsjoberg/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hsjoberg/multi-worker:latest -t hsjoberg/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push hsjoberg/multi-client:latest
docker push hsjoberg/multi-client:$SHA
docker push hsjoberg/multi-server:latest
docker push hsjoberg/multi-server:$SHA
docker push hsjoberg/multi-worker:latest
docker push hsjoberg/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hsjoberg/multi-server:$SHA
kubectl set image deployments/client-deployment client=hsjoberg/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hsjoberg/multi-worker:$SHA
