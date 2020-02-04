# gcloud auth automaticly with browser creds then u install gcloud SDK
param(
    $cloudProvider = "gcp",
    $instanceName,
    $networkName = "$instanceName-netwark",
    $subnet = "$instanceName-subnet",
    $image = "ubuntu-1604-xenial-v20200129",
    $machineType = "n1-highcpu-8",
    $region = "europe-west3"
)
gcloud compute networks create $networkName --range "10.0.0.0/10" --subnet-mode custom 
gcloud compute networks subnets create $subnet --network $networkName --region $region
gcloud compute instances create $instanceName --network $networkName --subnet $subnet --image $image --machine-type $machineType --region $region