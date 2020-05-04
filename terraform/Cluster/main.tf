#EKS Cluster
resource "aws_eks_cluster" "QAC-group-project" {
  name     = var.cluster_name
  role_arn = aws_iam_role.IAM-Roles.arn

  vpc_config {
    security_group_ids = var.aws_security_group
    subnet_ids         = var.aws_subnets
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.IAM-Roles-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.IAM-Roles-AmazonEKSServicePolicy,
  ]
}

output "endpoint" {
  value = "${aws_eks_cluster.QAC-group-project.endpoint}"
}

output "kubeconfig-certificate-authority-data" {
  value = "${aws_eks_cluster.QAC-group-project.certificate_authority.0.data}"
}

#EKS Node Group

resource "aws_eks_node_group" "group-project" {
  cluster_name    = aws_eks_cluster.QAC-group-project.name
  node_group_name = "Nodes"
  node_role_arn   = aws_iam_role.nodes.arn
  subnet_ids         = var.aws_subnets
  instance_types  = ["t2.micro"]
  # source_security_group_ids = [aws_security_group.group-project.id]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
  ]
}



#Iam Roles
resource "aws_iam_role" "IAM-Roles" {
  name = "terraform-eks-IAM-Roles"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

}

resource "aws_iam_role_policy_attachment" "IAM-Roles-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.IAM-Roles.name
}

resource "aws_iam_role_policy_attachment" "IAM-Roles-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.IAM-Roles.name
}

#Iam Worker Nodes
resource "aws_iam_role" "nodes" {
  name = "terraform-eks-nodes"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_instance_profile" "nodes" {
  name = "terraform-eks-demo"
  role = aws_iam_role.nodes.name
}