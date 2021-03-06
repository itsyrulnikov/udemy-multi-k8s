docker build -t itsyrulnikov/udemy-multi-client:latest -t itsyrulnikov/udemy-multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t itsyrulnikov/udemy-multi-server:latest -t itsyrulnikov/udemy-multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t itsyrulnikov/udemy-multi-worker:latest -t itsyrulnikov/udemy-multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push itsyrulnikov/udemy-multi-client:latest
docker push itsyrulnikov/udemy-multi-server:latest
docker push itsyrulnikov/udemy-multi-worker:latest

docker push itsyrulnikov/udemy-multi-client:$SHA
docker push itsyrulnikov/udemy-multi-server:$SHA
docker push itsyrulnikov/udemy-multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=itsyrulnikov/udemy-multi-server:$SHA
kubectl set image deployments/worker-deployment worker=itsyrulnikov/udemy-multi-worker:$SHA
kubectl set image deployments/client-deployment client=itsyrulnikov/udemy-multi-client:$SHA