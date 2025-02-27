

## DevOps Assignment - Kubernetes Deployment with Helm

## Remarks
•	Please note all implementation and testing of this assignment was done on AWS EC2 Environment
•	Project of course is fully functional and ready to be demonstrated
•	I have consulted with my assistant ChatGPT to do the project

## Prerequisites
Before proceeding, ensure you have the following installed:
•	Clone the project from GitHub 
•	Install Docker
•	Install Kubernetes (Minikube or a local cluster setup)
•	Helm (version 3 or later)

## Step 1: Build the Docker Container
1.	Navigate to the project directory that we clone from github: 
cd /path/to/project
2.	Build the Docker image: 
docker build -t devops-assignment:latest .
3.	Verify the built image: 
docker images | grep devops-assignment

## Step 2: Deploy the Application and MongoDB Using Helm
1.	Install the Helm chart: 
helm install ycon-app ./devops-assignment
2.	Verify the deployment: 
kubectl get pods
3.	Check the logs of the running application: 
kubectl logs -l app=devops-assignment

## Step 3: Customize Deployment Parameters
To customize deployment parameters, modify the values.yaml file based on the project specifications

Then apply changes:
helm upgrade ycon-app ./devops-assignment

## Step 4: Rolling Update and Service Connectivity
Rolling Update Strategy
The Helm chart defines a rolling update strategy in the YAML  Deployment template:
  type: RollingUpdate
  rollingUpdate:
    maxUnavailable: 0
    maxSurge: 1

** This ensures zero downtime while updating the application. maxUnavailable was set to zero to save with server resources **

## Service Connectivity
*	A Kubernetes Service is defined to allow internal communication between the app and MongoDB.
*	The application connects to MongoDB using mongodb://mongodb-service:27017.

## Check the service:
* minikube status
* kubectl get svc

## Additional Information
*	To uninstall the deployment: 
*	helm uninstall ycon-app
*	To delete the Docker image: 
*	docker rm devops-assignment:latest




