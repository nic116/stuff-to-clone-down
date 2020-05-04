# QACFinalProject

## Contents 
* [Introduction](#Introduction)  
* [Deployment Pretequisites](#prerequisites)
* [Planning](#planning)
* [Use Cases](#UserCases)
* [Risk Analysis](#Risk) 
* [Technologies Used](#Technology) 
* [Environments ](#Environments)
* [Testing](#Testing)
* [Deployment Pipeline](#pipeline)
* [Deployment](#Deployment)
* [Costs](#Costs) 
* [Project Conclusion](#Conclusion) 
* [Future Work](#FutureWork) 

<a name="Introduction"></a>
## Introduction 
### Project Brief
The general outline of this project was to use all the concepts learnt out to this point, design and implement a solution for automating the deployments and development workflows for the projects that is linked below: 
 
**Frontend and backend for client application** https://github.com/spring-petclinic/spring-petclinic-rest
 
 
 
As a group of 5 individuals we would have to either use the tools we had been taught during our training such as **Terraform, Kubernetes, Ansible** or utilise other tools that would work in a similar fashion to these justifying why they would be the most preferable for deployment. 

The deployment of this project would require automated building and re-deployment to testing and live environments upon any GitHub changes, whilst also keeping track of running costs.   

<a name="prerequisites"></a>
## Deployment Prerequisites
A unix-machine with Terraform and Ansible installed along with subscription to a cloud provider. In this case the cloud provider used is Amazon Web Service (AWS), but this can be configured with any.

### Terraform
Terraform needs to be configured with a provider to manage resources. In this case a service principal is set up, allowing Terraform to connect to our AWS subscription with a aws access and secret access key.

### Ansible
A Unix based system is required in order to run ansible (we used Ubuntu 18.04 LTS), and configure the virtual machines created by Terraform.

<a name="planning"></a>
## Planning

As this is a group project composed of 5 members, there will need to be adequate planning measures in place so that all individuals can work efficiently and coherently towards the main goal which is the successful deployment of the application.  

Therefore, throughout the duration of this project we chose to employ **Scrum** as our project management framework. Unlike conventional methods of project planning, Scrum promotes and encourages teams to learn through experiences, self-organise and share ideas whilst working towards resolving a problem.


To follow best practice within industry, we use a Kanban board to manage the project. We chose to use the Trello application to create my Kanban board, due to familiarity with the software, having seen it used at QA.

The board is designed around the continous deplyment and implementation of the application, along with other features needed for the specifics of the project (create this README file for example). These product backlogs are then further broken down in to a sprint backlog, tasks, progress, done and bugs list. These additional lists allow for dynamic progress updates of the project and to maintain specific obtainable objectives throughout the project to allow for a deliverable product by the deadline.

We defined "done" as to mean that the feature had been successfully implemented into the application and had no negative effects.
Any implemented feature that negatively effected the performance of the application were logged into the bugs column.



Below shows the inital Scrum plan for this project, this was agreed apon by each group member and includes the start and finish dates of each of sprint.
![Group-Trello-1](https://user-images.githubusercontent.com/61239212/80955909-0b58db80-8df8-11ea-8e24-bd4179dec16b.png)

Throughout the course of the project we also had daily standups where we would inform eachother what we had been done, review what was left to do and make a suitable plan of action for that day, filling in the tasks we had discussed under each sprint as well as assigining the task to invdividuals.

![Planning]########################   Add last trello



<a name="Risk"></a>
## Risk Analysis (Needs to be added onece done)
![RiskAssessment](add link)


<a name="Technology"></a>
## Technologies Used
![Group-Tech-used](https://user-images.githubusercontent.com/61239212/80956449-2c6dfc00-8df9-11ea-89ff-aeed05e1f977.png)


<a name="Environments"></a>
## Environments
In this project we used multiple environments and tools to test, build and deploy the applications, the tools are listed below:

- Terraform

Terraform was used to create our deployment infrastructure as code, in this case to create two environements; Staging and Production. In Terrafform each environment is identical but is tagged as Production and Staging. The environments have 1 Kubernetes Cluster and all it dependencies, 1 VM for controlling the clusters using Kubectl and testing the app and finally a Jenkins CI/CD server which executes the pipeline by building, testing and deploying the application on the K8 cluster.

We chose Terraform as it lets you write infrastructure as code, the infrastructure configurations can be versioned and maintained, so if another environment needs to be created, you can be sure that you are using the latest configurations which avoids environment drift.

 ***** Setup files can be found in the Terraform Folder *****

- Ansible

Ansible was used to provision and configure the dependencies required to test and build our application on our remote hosts, this was done so that our app could be deployed seamlessly after Terrafform creates the infrastructure that we need. We created multiple custom roles inside Ansible that; install Docker, Install the applications our app needs to work, configure Jenkins and more.

We chose Ansible for this project as it is a very useful automation tool that lets you configure manage and deploy applications, also can configure Windows machines as well as Linux machines, YAML is easy to read and understand and gives you a clear view of what is happening, Ansible is also agentless and doesn’t need any extra configuration and comes with all the features ready to use out the box.


***** Setup files can be found in the following dir -> terraform/ansible

- Kubernetes

Our Kubernetes cluster was created using Terraform and this was done in the testing and production environments. Kubernetes helped us deploy our application containers and was used because it is easily able to manage, scale and deploy large applications. It is also very easy to use with Azure and other cloud providers. 

***** Setup files can be found in the following dir -> terraform/kubernetes-cluster

<a name="Testing"></a>

######################################### Edit this for our case once the testing is done ########################################################
## Testing


Things to add to the test sectrion:
1. backent testing
2. frontend testing
3. And requirements for both of them
4. Add coverage
#################################################################################



<a name="pipeline"></a>
## Deployment Pipeline
![s5](/Documentation/Pipeline.jpg)

<a name="Deployment"></a>
## Deployment

We used Terraform to create the infrastructure (VM's and Kubernetes Cluster) after this process we used Ansible to go into the VM's we  created and install all the applications we would need for the project to work e.g Jenkins, Java, Python, Docker, Maven. After running Ansible we then trigger the build process which is running on our Jenkins CI/CD server, this tests the application and if the tests pass the deployment stage is triggered and the application is deployed to the Kubernetes Cluster on Azure. See video Below for more info.




<a name="Costs"></a>
## Costs
We used Pricing Calculator to configure and estimate the monthly running costs for the AWS products that we need to automate the deployment of the application. We decided that we need 2 VMs and the AWS Kubernetes Service, we used eu-west-2 as region because that’s what we found available according to the subscription that we were using and we came to the conclusion that we would have an operational expenditure of £32.82 plus 0.01USD per hour to run terraform, paying only for what we are using with no upfront costs for the services.
![Group-Cost](https://user-images.githubusercontent.com/61239212/80957894-fb42fb00-8dfb-11ea-9012-7492fdb57d4d.png)



<a name="Conclusion"></a>
## Project Conclusion

What went well:
* Using terraform to create the infrastructure went swiftly without many issues. 
* Team meetings were helpful and orientating.
* ADD SOMETHING ELSE

What went wrong:
* Running the frontend application came with some issues that requiered the help of our instructor.
* Creating pods for the cluster took some extra time.

Future improvements:
* A more detail examination of the costs.
* ADD SOMETHING ELSE. 


